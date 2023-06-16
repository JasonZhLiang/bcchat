//
//  BrainCloudPlayerStatistics.mm
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-06.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "BrainCloudCallback.hh"
#import "TypeHelpers.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudPlayerStatistics.hh"

@interface BrainCloudPlayerStatistics ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudPlayerStatistics

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)readAllUserStats:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->readAllUserStats(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)readUserStatsSubset:(NSArray *)playerStats
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->readUserStatsSubset(
        TypeHelpers::NSStringArrayToVector(playerStats), new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)readUserStatsForCategory:(NSString *)category
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->readUserStatsForCategory(
        [category UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)resetAllUserStats:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->resetAllUserStats(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)incrementUserStats:(NSString *)jsonData
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->incrementUserStats(
        [jsonData UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getNextExperienceLevel:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->getNextExperienceLevel(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)incrementExperiencePoints:(int)xpValue
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->incrementExperiencePoints(
        xpValue, new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)setExperiencePoints:(int)xpValue
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->setExperiencePoints(
        xpValue, new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)processStatistics:(NSString *)jsonData
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStatisticsService()->processStatistics(
        [jsonData UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

@end
