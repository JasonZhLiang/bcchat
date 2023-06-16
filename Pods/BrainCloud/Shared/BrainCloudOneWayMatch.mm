//
//  BrainCloudOneWayMatch.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-11.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "BrainCloudClient.hh"
#import "BrainCloudOneWayMatch.hh"

@interface BrainCloudOneWayMatch ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudOneWayMatch

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)startMatch:(NSString *)otherPlayerId
              rangeDelta:(int32_t)range
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getOneWayMatchService()->startMatch(
        [otherPlayerId UTF8String], range, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)cancelMatch:(NSString *)playbackStreamId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getOneWayMatchService()->cancelMatch(
        [playbackStreamId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)completeMatch:(NSString *)playbackStreamId
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getOneWayMatchService()->completeMatch(
        [playbackStreamId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

@end
