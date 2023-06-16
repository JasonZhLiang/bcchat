/**
 * This class handles relay message callbacks
 */

#pragma once

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"
#import "braincloud/BrainCloudClient.h"
#import "braincloud/IRelayCallback.h"

class BrainCloudRelayCallback final : public BrainCloud::IRelayCallback
{
public:
    void setCompletionBlock(BCRelayEventBlock completionBlock,
                            BCCallbackObject cbObject)
    {
        m_completionBlock = completionBlock;
        m_cbObject = cbObject;
    }

protected:
    void relayCallback(int netId, const uint8_t* bytes, int size) override
    {
        if (m_completionBlock)
        {
            auto data = [NSData dataWithBytes:bytes length:size];
            m_completionBlock(netId, data, m_cbObject);
        }
    }

private:
    BCRelayEventBlock m_completionBlock = nil;
    BCCallbackObject m_cbObject = nil;
};
