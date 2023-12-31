#include "braincloud/internal/DefaultRelayUDPSocket.h"

#include <unistd.h>
#include <arpa/inet.h>
#include <iostream>
#include <string.h>

namespace BrainCloud
{
    IRelayUDPSocket* IRelayUDPSocket::create(const std::string& address, int port, int maxPacketSize)
    {
        return new DefaultRelayUDPSocket(address, port, maxPacketSize);
    }

    DefaultRelayUDPSocket::DefaultRelayUDPSocket(const std::string& address, int port, int maxPacketSize)
        : m_maxPacketSize(maxPacketSize)
    {
        // clear the fd_sets
        FD_ZERO(&m_fdsSet);
        FD_ZERO(&m_fdsRead);
        FD_ZERO(&m_fdsWrite);

        // Allocate our read buffer
        m_buffer = new uint8_t[maxPacketSize];

        // prepare the destination adress
        m_destination.sin_family = AF_INET;
        m_destination.sin_addr.s_addr = inet_addr(address.c_str());
        m_destination.sin_port = (in_port_t)htons((u_short)port);
        memset(&(m_destination.sin_zero), '\0', 8);

        // Create socket
        {
            m_socket = socket(PF_INET, SOCK_DGRAM, 0);
            if (m_socket == SOCKET_ERROR)
            {
                std::cout << "Relay: Could not create udp socket, errno: " << errno << std::endl;
                m_socket = INVALID_SOCKET;
                m_state = State::Error;
                return;
            }
        }

        // Set options
        {
            int on = 1;
            if (setsockopt(m_socket, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on)) == -1)
            {
                std::cout << "Relay: setsockopt() failed, UDFP option = SO_REUSEADDR" << errno << std::endl;
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                m_state = State::Error;
                return;
            }
        }

        // If all good, add to fd set
        FD_SET(m_socket, &m_fdsSet);

        m_state = State::Connecting;
    }

    DefaultRelayUDPSocket::~DefaultRelayUDPSocket()
    {
        close();
        delete[] m_buffer;
    }

    bool DefaultRelayUDPSocket::isConnected()
    {
        return m_state == State::Connected;
    }

    bool DefaultRelayUDPSocket::isValid()
    {
        return m_state != State::Error;
    }

    bool DefaultRelayUDPSocket::poll()
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

    void DefaultRelayUDPSocket::send(const uint8_t* pData, int size)
    {
        if (m_socket == INVALID_SOCKET || m_state != State::Connected)
        {
            return;
        }

        ::sendto(m_socket, (const char*)pData, size, 0, (sockaddr*)&m_destination, sizeof(sockaddr));
    }

    void DefaultRelayUDPSocket::updateConnection()
    {
        // For UDP, nothing to do here. It's connectionless
        m_state = State::Connected;
    }

    const uint8_t* DefaultRelayUDPSocket::peek(int& size)
    {
        size = 0;

        if (m_socket == INVALID_SOCKET ||
            m_state != State::Connected)
        {
            return nullptr;
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
            sockaddr_in fromIP;
            socklen_t len = sizeof(sockaddr_in);
            size_t received = ::recvfrom(m_socket, (char*)m_buffer, m_maxPacketSize, 0, (sockaddr*)&fromIP, &len);
            if (received <= 0)
            {
                FD_CLR(m_socket, &m_fdsSet);
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                std::cout << "Relay: Socket closed." << std::endl;
                m_state = State::Error;
                return nullptr;
            }

            // Make sure we received from the relay server, otherwise, ignore this packet
            if (memcmp(&fromIP.sin_addr, &m_destination.sin_addr, sizeof(fromIP.sin_addr)) != 0 ||
                fromIP.sin_port != m_destination.sin_port)
            {
                std::cout << "Relay: Packet received from unknown source." << std::endl;
                return nullptr;
            }

            // If packet fully read, return it
            if (received >= 2)
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
                if (received != packetSize)
                {
                    FD_CLR(m_socket, &m_fdsSet);
                    ::close(m_socket);
                    m_socket = INVALID_SOCKET;
                    std::cout << "Relay: Received size doesn't matched packet size " << received << " != " << packetSize << std::endl;
                    m_state = State::Error;
                    return nullptr;
                }
                size = packetSize;
                return m_buffer;
            }
            else
            {
                // That's an error, should never happen
                FD_CLR(m_socket, &m_fdsSet);
                ::close(m_socket);
                m_socket = INVALID_SOCKET;
                std::cout << "Relay: Packet size < 2" << std::endl;
                m_state = State::Error;
                return nullptr;
            }
        }

        return nullptr;
    }

    void DefaultRelayUDPSocket::close()
    {
        if (m_socket != INVALID_SOCKET)
        {
            FD_CLR(m_socket, &m_fdsSet);
            ::close(m_socket);
            m_socket = INVALID_SOCKET;
        }
    }
};
