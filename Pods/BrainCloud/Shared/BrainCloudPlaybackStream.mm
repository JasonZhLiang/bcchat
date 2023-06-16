//
//  BrainCloudPlaybackStream.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-12.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "BrainCloudPlaybackStream.hh"
#import "BrainCloudClient.hh"
#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

@interface BrainCloudPlaybackStream ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudPlaybackStream

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)startStream:(NSString *)targetPlayerId
       includeSharedData:(bool)includeSharedData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getPlaybackStreamService()->startStream(
        [targetPlayerId UTF8String], includeSharedData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readStream:(NSString *)streamId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getPlaybackStreamService()->readStream(
        [streamId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)endStream:(NSString *)streamId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getPlaybackStreamService()->endStream(
        [streamId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteStream:(NSString *)streamId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getPlaybackStreamService()->deleteStream(
        [streamId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)addEvent:(NSString *)streamId
           jsonEventData:(NSString *)eventData
             jsonSummary:(NSString *)summary
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getPlaybackStreamService()->addEvent(
        [streamId UTF8String], [eventData UTF8String], [summary UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getRecentStreamsForInitiatingPlayer:(NSString *)initiatingPlayerId
                              maxNumStreams:(int)maxStreams
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject {
    _client
            ->getPlaybackStreamService()
            ->getRecentStreamsForInitiatingPlayer([initiatingPlayerId UTF8String], maxStreams,
                    new BrainCloudCallback(cb, ecb, cbObject));

}

- (void)getRecentStreamsForTargetPlayer:(NSString *)targetPlayerId
                          maxNumStreams:(int)maxStreams
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject {
    _client
            ->getPlaybackStreamService()
            ->getRecentStreamsForTargetPlayer([targetPlayerId UTF8String], maxStreams,
                    new BrainCloudCallback(cb, ecb, cbObject));

}

@end
