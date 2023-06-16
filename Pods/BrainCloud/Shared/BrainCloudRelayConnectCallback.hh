/**
 * This class handles relay connection success/failure callbacks
 */

#pragma once

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"
#import "braincloud/BrainCloudClient.h"
#import "braincloud/IRelayConnectCallback.h"

class BrainCloudRelayConnectCallback final : public BrainCloud::IRelayConnectCallback
{
public:
    void setCompletionBlocks(BCRelayConnectSuccessCompletionBlock completionBlock,
                             BCRelayConnectFailureCompletionBlock errorCompletionBlock,
                             BCCallbackObject cbObject)
    {
        m_completionBlock = completionBlock;
        m_errorCompletionBlock = errorCompletionBlock;
        m_cbObject = cbObject;
    }

protected:
    void relayConnectSuccess(const std::string& jsonResponse) override
    {
        if (m_completionBlock)
        {
            m_completionBlock([NSString stringWithUTF8String:jsonResponse.c_str()], m_cbObject);
        }
    }

    void relayConnectFailure(const std::string& errorMessage) override
    {
        if (m_errorCompletionBlock)
        {
            auto errorCompletionBlock = m_errorCompletionBlock;
            auto cbObject = m_cbObject;

            m_completionBlock = nil;
            m_errorCompletionBlock = nil;
            m_cbObject = nil;

            errorCompletionBlock([NSString stringWithUTF8String:errorMessage.c_str()], cbObject);
        }
    }

private:
    BCRelayConnectSuccessCompletionBlock m_completionBlock = nil;
    BCRelayConnectFailureCompletionBlock m_errorCompletionBlock = nil;
    BCCallbackObject m_cbObject = nil;
};
