/**
 * This class handles the server callbacks and passes the data to Objective-C
 *via blocks.
 *
 */

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"
#import "braincloud/BrainCloudClient.h"

class BrainCloudCallback : public BrainCloud::IServerCallback
{
  private:
    BCCompletionBlock m_completionBlock;
    BCErrorCompletionBlock m_errorCompletionBlock;
    BCCallbackObject m_cbObject;

  public:
    BrainCloudCallback(BCCompletionBlock completionBlock,
                       BCErrorCompletionBlock errorCompletionBlock)
        : m_completionBlock(completionBlock), m_errorCompletionBlock(errorCompletionBlock),
          m_cbObject(nil)
    {
    }

    BrainCloudCallback(BCCompletionBlock completionBlock,
                       BCErrorCompletionBlock errorCompletionBlock, BCCallbackObject cbObject)
        : m_completionBlock(completionBlock), m_errorCompletionBlock(errorCompletionBlock),
          m_cbObject(cbObject)
    {
    }

    BrainCloudCallback *setCompletionBlock(BCCompletionBlock completionBlock)
    {
        m_completionBlock = completionBlock;
        return this;
    }

    virtual void serverCallback(BrainCloud::ServiceName serviceName,
                                BrainCloud::ServiceOperation serviceOperation,
                                std::string const &jsonData)
    {
        if (m_completionBlock)
        {
            m_completionBlock(
                [NSString stringWithCString:serviceName.getValue().c_str()
                                   encoding:NSUTF8StringEncoding],
                [NSString stringWithCString:serviceOperation.getValue().c_str()
                                   encoding:NSUTF8StringEncoding],
                [NSString stringWithCString:jsonData.c_str() encoding:NSUTF8StringEncoding],
                m_cbObject);
        }
        delete this;
    }

    virtual void serverError(BrainCloud::ServiceName serviceName,
                             BrainCloud::ServiceOperation serviceOperation, int statusCode,
                             int returnCode, const std::string &jsonError)
    {
        if (m_errorCompletionBlock)
        {
            m_errorCompletionBlock(
                [NSString stringWithCString:serviceName.getValue().c_str()
                                   encoding:NSUTF8StringEncoding],
                [NSString stringWithCString:serviceOperation.getValue().c_str()
                                   encoding:NSUTF8StringEncoding],
                statusCode, returnCode,
                [NSString stringWithCString:jsonError.c_str() encoding:NSUTF8StringEncoding],
                m_cbObject);
        }
        delete this;
    }

    virtual void serverWarning(BrainCloud::ServiceName serviceName,
                               BrainCloud::ServiceOperation serviceOperation, int statusCode,
                               int returnCode, int numRetries, const std::string &jsonData)
    {
        // do nothing for server warning
    }
};

#pragma clang diagnostic pop
