//
//  BrainCloudGlobalStatistics.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-06.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "BrainCloudCallback.hh"
#import "TypeHelpers.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudGlobalStatistics.hh"

@interface BrainCloudGlobalStatistics ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudGlobalStatistics

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)readAllGlobalStats:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalStatisticsService()->readAllGlobalStats(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)readGlobalStatsSubset:(NSArray *)globalStats
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalStatisticsService()->readGlobalStatsSubset(
        TypeHelpers::NSStringArrayToVector(globalStats), new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)readGlobalStatsForCategory:(NSString *)category
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalStatisticsService()->readGlobalStatsForCategory(
        [category UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)incrementGlobalStats:(NSString *)jsonData
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalStatisticsService()->incrementGlobalGameStat(
        [jsonData UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)processStatistics:(NSString *)jsonData
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalStatisticsService()->processStatistics(
        [jsonData UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

@end
