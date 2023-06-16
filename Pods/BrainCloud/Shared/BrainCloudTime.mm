//
//  BrainCloudTime.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-12.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

#import "BrainCloudTime.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudTime ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudTime

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)readServerTime:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getTimeService()->readServerTime(
        new BrainCloudCallback(cb, ecb, cbObject));
}

@end
