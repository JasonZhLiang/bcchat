/**
 * This class handles relay system messages callbacks
 */

#pragma once

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"
#import "braincloud/BrainCloudClient.h"
#import "braincloud/IRelaySystemCallback.h"

class BrainCloudRelaySystemCallback final : public BrainCloud::IRelaySystemCallback
{
public:
    void setCompletionBlock(BCRelaySystemEventBlock completionBlock,
                             BCCallbackObject cbObject)
    {
        m_completionBlock = completionBlock;
        m_cbObject = cbObject;
    }

protected:
    void relaySystemCallback(const std::string& jsonResponse) override
    {
        if (m_completionBlock)
        {
            m_completionBlock([NSString stringWithUTF8String:jsonResponse.c_str()], m_cbObject);
        }
    }

private:
    BCRelaySystemEventBlock m_completionBlock = nil;
    BCCallbackObject m_cbObject = nil;
};
