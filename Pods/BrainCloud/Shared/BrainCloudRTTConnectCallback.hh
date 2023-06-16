/**
 * This class handles RTT connection success/failure callbacks and passes 
 * the data to Objective-C via blocks.
 */

#pragma once

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"
#import "braincloud/BrainCloudClient.h"
#import "braincloud/IRTTConnectCallback.h"

class BrainCloudRTTConnectCallback final : public BrainCloud::IRTTConnectCallback
{
public:
    void setCompletionBlocks(BCRTTConnectSuccessCompletionBlock completionBlock,
                             BCRTTConnectFailureCompletionBlock errorCompletionBlock,
                             BCCallbackObject cbObject)
    {
        m_completionBlock = completionBlock;
        m_errorCompletionBlock = errorCompletionBlock;
        m_cbObject = cbObject;
    }

protected:
    void rttConnectSuccess() override
    {
        if (m_completionBlock)
        {
            m_completionBlock(m_cbObject);
        }
    }

    void rttConnectFailure(const std::string& errorMessage) override
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
    BCRTTConnectSuccessCompletionBlock m_completionBlock = nil;
    BCRTTConnectFailureCompletionBlock m_errorCompletionBlock = nil;
    BCCallbackObject m_cbObject = nil;
};
