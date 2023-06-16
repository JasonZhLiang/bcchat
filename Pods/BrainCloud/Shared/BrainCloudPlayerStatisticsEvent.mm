//
//  BrainCloudPlayerStatisticsEvent.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-12.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "BrainCloudClient.hh"
#import "BrainCloudPlayerStatisticsEvent.hh"

@interface BrainCloudPlayerStatisticsEvent ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudPlayerStatisticsEvent

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)triggerPlayerStatisticsEvent:(NSString *)eventName
                     eventMultiplier:(int)multiplier
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject
{
    _client
            ->getPlayerStatisticsEventService()
            ->triggerStatsEvent([eventName UTF8String], multiplier,
                    new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)triggerStatsEvent:(NSString *)eventName
          eventMultiplier:(int)multiplier
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client
        ->getPlayerStatisticsEventService()
        ->triggerStatsEvent([eventName UTF8String], multiplier,
                                       new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)triggerPlayerStatisticsEvents:(NSString *)jsonData
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject
{
    _client
            ->getPlayerStatisticsEventService()
            ->triggerStatsEvents([jsonData UTF8String],
                    new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)triggerStatsEvents:(NSString *)jsonData
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client
        ->getPlayerStatisticsEventService()
        ->triggerStatsEvents([jsonData UTF8String],
                                        new BrainCloudCallback(cb, ecb, cbObject));
}

@end
