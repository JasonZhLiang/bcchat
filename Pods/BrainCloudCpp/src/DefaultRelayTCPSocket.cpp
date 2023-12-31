#include "braincloud/internal/DefaultRelayTCPSocket.h"

#include <iostream>

namespace BrainCloud
{
    IRelayTCPSocket* IRelayTCPSocket::create(const std::string& address, int port, int maxPacketSize)
    {
        return new DefaultRelayTCPSocket(address, port, maxPacketSize);
    }

    DefaultRelayTCPSocket::DefaultRelayTCPSocket(const std::string& address, int port, int maxPacketSize)
        : m_maxPacketSize(maxPacketSize)
    {
        // clear the fd_sets
        FD_ZERO(&m_fdsSet);
        FD_ZERO(&m_fdsRead);
        FD_ZERO(&m_fdsWrite);

        // Allocate our read buffer
        m_buffer = new uint8_t[maxPacketSize];

        // Fetch IPs associated with this address string. We run this in a thread because it could block for a while.
        m_state = State::FetchingRemotes;
        m_getAddrInfoThread = std::thread([this, address, port]()
        {
            struct addrinfo hints;

            memset(&hints, 0, sizeof(hints));
            hints.ai_family = AF_UNSPEC;
            hints.ai_socktype = SOCK_STREAM;
            hints.ai_protocol = IPPROTO_TCP;
            
            int ret = getaddrinfo(address.c_str(), std::to_string(port).c_str(), &hints, &m_pRemoteAddresses);

            if (ret != 0)
            {
                std::cout << "Relay: Failed calling getaddrinfo, errno: " << errno << std::endl;
                m_socket = INVALID_SOCKET;
                m_state = State::Error;
            }
            else
            {
                m_state = State::Connecting;
            }
        });
    }

    DefaultRelayTCPSocket::~DefaultRelayTCPSocket()
    {
        if (m_getAddrInfoThread.joinable()) m_getAddrInfoThread.join();
        if (m_pRemoteAddresses) freeaddrinfo(m_pRemoteAddresses);
        close();
        delete[] m_buffer;
    }

    bool DefaultRelayTCPSocket::isConnected()
    {
        return m_state == State::Connected;
    }

    bool DefaultRelayTCPSocket::isValid()
    {
        return m_state != State::Error;
    }

    void DefaultRelayTCPSocket::connect(addrinfo* pAddress)
    {
        // Create socket
        {
            m_socket = socket(PF_INET, SOCK_STREAM, 0);
            if (m_socket == SOCKET_ERROR)
            {
                std::cout << "Relay: Could not create tcp socket, errno: " << errno << std::endl;
                m_socket = INVALID_SOCKET;
                m_state = State::Error;
                return;
            }
        }

        // Set options
        {
            int on = 1;
            if (setsockopt(m_socket, IPPROTO_TCP, TCP_NODELAY, &on, sizeof(on)) == -1)
            {
                std::cout << "Relay: setsockopt() failed, TCP option = TCP_NODELAY" << errno << std::endl;
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                m_state = State::Error;
                return;
            }
            if (setsockopt(m_socket, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on)) == -1)
            {
                std::cout << "Relay: setsockopt() failed, TCP option = SO_REUSEADDR" << errno << std::endl;
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                m_state = State::Error;
                return;
            }
        }

        // Set non-blocking connect
        {
            int rc = 0;
            if ((rc = fcntl(m_socket, F_GETFL, NULL)) == -1)
            {
                std::cout << "Relay: fcntl(F_GETFL) failed when trying to change socket's blocking mode, errno = " << errno << std::endl;
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                m_state = State::Error;
                return;
            }

            rc |= O_NONBLOCK; // Non-blocking

            if ((fcntl(m_socket, F_SETFL, rc)) == -1)
            {
                std::cout << "Relay: fcntl(F_SETFL) failed when trying to change socket's blocking mode, errno = " << errno << std::endl;
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                m_state = State::Error;
                return;
            }
        }

        // Initiate the connection
        {
            ::connect(m_socket, pAddress->ai_addr, (int)pAddress->ai_addrlen);
            if (errno != EINPROGRESS)
            {
                std::cout << "Relay: connect() failed, errno = " << errno << std::endl;
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                return;
            }
        }

        // If all good, add to fd set
        FD_SET(m_socket, &m_fdsSet);
    }

    bool DefaultRelayTCPSocket::poll()
    {
        // set the timeout for select()
        timeval    timeout;
        timeout.tv_sec = 0;
        timeout.tv_usec = 0;

        // copy the sets
        m_fdsRead = m_fdsSet;
        m_fdsWrite = m_fdsSet;

        return select((int)m_socket + 1, &m_fdsRead, &m_fdsWrite, NULL, &timeout) != SOCKET_ERROR;
    }

    void DefaultRelayTCPSocket::send(const uint8_t* pData, int size)
    {
        if (m_socket == INVALID_SOCKET || m_state != State::Connected)
        {
            return;
        }

        size_t ret = 0;
        while (ret >= 0 && ret < (int)size)
        {
            ret = ::send(m_socket, (const char*)pData, size, 0);
            if (ret >= 0 && ret <= (int)size)
            {
                size -= ret;
                pData += ret;
                continue;
            }
            return;
        }
    }

    void DefaultRelayTCPSocket::updateConnection()
    {
        if (m_state != State::Connecting)
        {
            return;
        }

        // If no active socket, try next address
        if (m_socket == INVALID_SOCKET)
        {
            if (!m_pRemoteAddresses)
            {
                // No more
                m_state = State::Error;
                return;
            }

            if (!m_pRemoteAddress)
            {
                // First one
                m_pRemoteAddress = m_pRemoteAddresses;
            }
            else
            {
                // Try next one
                m_pRemoteAddress = m_pRemoteAddress->ai_next;
            }
            if (!m_pRemoteAddress)
            {
                // No more
                freeaddrinfo(m_pRemoteAddresses);
                m_pRemoteAddress = nullptr;
                m_pRemoteAddresses = nullptr;
                m_state = State::Error;
                return;
            }

            connect(m_pRemoteAddress);
            return;
        }

        // We check if the socket is ready to write to know if we are connected
        if (!poll())
        {
            // We'll try next address
            FD_CLR(m_socket, &m_fdsSet);
            ::close(m_socket);
            m_socket = INVALID_SOCKET;
            return;
        }
        if (FD_ISSET(m_socket, &m_fdsWrite))
        {
            // Check connection result
            socklen_t len = (socklen_t)sizeof(sockaddr);
            int res = getpeername(m_socket, m_pRemoteAddress->ai_addr, &len);
            if (res)
            {
                // We'll try next address
                FD_CLR(m_socket, &m_fdsSet);
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                return;
            }

            // Change mode back to blocking (we will poll the fdset anyway)
            {
                int rc = 0;
                if ((rc = fcntl(m_socket, F_GETFL, NULL)) == -1)
                {
                    // We'll try next address
                    FD_CLR(m_socket, &m_fdsSet);
                    ::close(m_socket);
                    m_socket = INVALID_SOCKET;
                    return;
                }

                rc |= O_NONBLOCK; // Non-blocking

                if ((fcntl(m_socket, F_SETFL, rc)) == -1)
                {
                    // We'll try next address
                    FD_CLR(m_socket, &m_fdsSet);
                    ::close(m_socket);
                    m_socket = INVALID_SOCKET;
                    return;
                }
            }

            // Connected!
            m_state = State::Connected;
            freeaddrinfo(m_pRemoteAddresses);
            m_pRemoteAddress = nullptr;
            m_pRemoteAddresses = nullptr;
        }
    }

    const uint8_t* DefaultRelayTCPSocket::peek(int& size)
    {
        size = 0;

        if (m_socket == INVALID_SOCKET ||
            m_state != State::Connected)
        {
            return nullptr;
        }

        // Check if previous packet was fully read, then shift buffer
        if (m_read >= 2)
        {
            auto packetSize = (int)ntohs(*(u_short*)m_buffer);
            if (m_read >= packetSize)
            {
                memcpy(m_buffer, m_buffer + packetSize, m_read - packetSize);
                m_read -= packetSize;
            }
        }

        // Can we return another packet without polling the socket?
        if (m_read >= 2)
        {
            auto packetSize = (int)ntohs(*(u_short*)m_buffer);
            if (m_read >= packetSize)
            {
                size = packetSize;
                return m_buffer;
            }
        }

        if (!poll())
        {
            FD_CLR(m_socket, &m_fdsSet);
            ::close(m_socket);
            m_socket = INVALID_SOCKET;
            std::cout << "Relay: Socket Poll failed." << std::endl;
            m_state = State::Error;
            return nullptr;
        }

        if (FD_ISSET(m_socket, &m_fdsRead))
        {

            // Read packet
            size_t received = ::recv(m_socket, (char*)(m_buffer + m_read), m_maxPacketSize - m_read, 0);
            if (received <= 0)
            {
                FD_CLR(m_socket, &m_fdsSet);
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                std::cout << "Relay: Socket closed." << std::endl;
                m_state = State::Error;
                return nullptr;
            }

            // If packet fully read, return it
            m_read += received;
            if (m_read >= 2)
            {
                auto packetSize = (int)ntohs(*(u_short*)m_buffer);
                if (packetSize > m_maxPacketSize)
                {
                    FD_CLR(m_socket, &m_fdsSet);
                    ::close(m_socket);
                    m_socket = INVALID_SOCKET;
                    std::cout << "Relay: Packet size " << packetSize << " > max " << m_maxPacketSize << std::endl;
                    m_state = State::Error;
                    return nullptr;
                }
                if (m_read >= packetSize)
                {
                    size = packetSize;
                    return m_buffer;
                }
            }
        }

        return nullptr;
    }

    void DefaultRelayTCPSocket::close()
    {
        if (m_socket != INVALID_SOCKET)
        {
            FD_CLR(m_socket, &m_fdsSet);
            ::close(m_socket);
            m_socket = INVALID_SOCKET;
        }
    }
};
