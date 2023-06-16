//
//  BrainCloudGamification.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-12.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "BrainCloudGamification.hh"

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "BrainCloudClient.hh"
#include "TypeHelpers.hh"

@interface BrainCloudGamification ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudGamification

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)readAllGamification:(bool)includeMetaData
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readAllGamification(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readMilestones:(bool)includeMetaData
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readMilestones(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readAchievements:(bool)includeMetaData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readAchievements(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readXpLevelsMetaData:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readXpLevelsMetaData(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readAchievedAchievements:(bool)includeMetaData
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readAchievedAchievements(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readCompletedMilestones:(bool)includeMetaData
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readCompletedMilestones(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readInProgressMilestones:(bool)includeMetaData
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readInProgressMilestones(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readMilestonesByCategory:(NSString *)category
                 includeMetaData:(bool)includeMetaData
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readMilestonesByCategory(
        [category UTF8String], includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)awardAchievements:(NSArray *)achievementIds
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->awardAchievements(
        TypeHelpers::NSStringArrayToVector(achievementIds), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readQuests:(bool)includeMetaData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readQuests(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readCompletedQuests:(bool)includeMetaData
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readCompletedQuests(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readInProgressQuests:(bool)includeMetaData
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readInProgressQuests(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readNotStartedQuests:(bool)includeMetaData
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readNotStartedQuests(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readQuestsWithStatus:(bool)includeMetaData
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readQuestsWithStatus(
        includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readQuestsWithBasicPercentage:(bool)includeMetaData
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject
{
    _client
        ->getGamificationService()
        ->readQuestsWithBasicPercentage(includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readQuestsWithComplexPercentage:(bool)includeMetaData
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject
{
    _client
        ->getGamificationService()
        ->readQuestsWithComplexPercentage(includeMetaData,
                                          new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readQuestsByCategory:(NSString *)category
             includeMetaData:(bool)includeMetaData
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getGamificationService()->readQuestsByCategory(
        [category UTF8String], includeMetaData, new BrainCloudCallback(cb, ecb, cbObject));
}

@end
