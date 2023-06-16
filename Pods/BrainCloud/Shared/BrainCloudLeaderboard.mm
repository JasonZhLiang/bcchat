//
//  BrainCloudLeaderboard.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-07.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include <string>
#include <vector>

#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudLeaderboard.hh"

@interface BrainCloudLeaderboard ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudLeaderboard

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)getSocialLeaderboard:(NSString *)leaderboardId
                 replaceName:(bool)replaceName
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getSocialLeaderboard(
        [leaderboardId UTF8String], replaceName, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getSocialLeaderboardByVersion:(NSString *)leaderboardId
                          replaceName:(bool)replaceName
                            versionId:(int)versionId
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getSocialLeaderboardByVersion(
        [leaderboardId UTF8String], replaceName, versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getMultiSocialLeaderboard:(NSArray *)leaderboardIds
           leaderboardResultCount:(NSInteger)leaderboardResultCount
                      replaceName:(bool)replaceName
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    std::vector<std::string> lbIds;
    for (NSString *nsid in leaderboardIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }
    _client->getLeaderboardService()->getMultiSocialLeaderboard(
        lbIds, (int)leaderboardResultCount, replaceName, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardPage:(NSString *)leaderboardId
                       sortOrder:(SortOrder)sortOrder
                      startIndex:(int)startIndex
                        endIndex:(int)endIndex
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGlobalLeaderboardPage(
        [leaderboardId UTF8String], (BrainCloud::SortOrder)sortOrder, startIndex, endIndex,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardPageByVersion:(NSString *)leaderboardId
                                sortOrder:(SortOrder)sortOrder
                               startIndex:(int)startIndex
                                 endIndex:(int)endIndex
                                versionId:(int)versionId
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGlobalLeaderboardPageByVersion(
        [leaderboardId UTF8String], (BrainCloud::SortOrder)sortOrder, startIndex, endIndex, versionId,
        new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)getGlobalLeaderboardView:(NSString *)leaderboardId
                       sortOrder:(SortOrder)sortOrder
                     beforeCount:(int)beforeCount
                      afterCount:(int)afterCount
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGlobalLeaderboardView(
        [leaderboardId UTF8String], (BrainCloud::SortOrder)sortOrder, beforeCount, afterCount,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardViewByVersion:(NSString *)leaderboardId
                                sortOrder:(SortOrder)sortOrder
                              beforeCount:(int)beforeCount
                               afterCount:(int)afterCount
                                versionId:(int)versionId
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGlobalLeaderboardViewByVersion(
        [leaderboardId UTF8String], (BrainCloud::SortOrder)sortOrder, beforeCount, afterCount, versionId,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardEntryCount:(NSString *)leaderboardId
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGlobalLeaderboardEntryCount(
        [leaderboardId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardEntryCountByVersion:(NSString *)leaderboardId
                                      versionId:(int32_t)versionId
                                completionBlock:(BCCompletionBlock)cb
                           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                       cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGlobalLeaderboardEntryCountByVersion(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardVersions:(NSString *)leaderboardId
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGlobalLeaderboardVersions(
        [leaderboardId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToLeaderboard:(NSString *)leaderboardId
                         score:(int)score
                 jsonOtherData:(NSString *)jsonOtherData
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->postScoreToLeaderboard(
        [leaderboardId UTF8String], score, [jsonOtherData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToDynamicLeaderboard:(NSString *)leaderboardId
                                score:(int)score
                             jsonData:(NSString *)jsonData
                      leaderboardType:(LeaderboardType)leaderboardType
                         rotationType:(RotationType)rotationType
                       roatationReset:(NSDate *)rotationReset
                        retainedCount:(int)retainedCount
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject
{
    time_t time = [rotationReset timeIntervalSince1970];
    struct tm *timeStruct = localtime(&time);

    _client->getLeaderboardService()->postScoreToDynamicLeaderboard(
        [leaderboardId UTF8String], score, [jsonData UTF8String], (BrainCloud::SocialLeaderboardType)leaderboardType,
        (BrainCloud::RotationType)rotationType, timeStruct, retainedCount, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToDynamicLeaderboardUTC:(NSString *)leaderboardId
                                score:(int)score
                             jsonData:(NSString *)jsonData
                      leaderboardType:(LeaderboardType)leaderboardType
                         rotationType:(RotationType)rotationType
                       roatationResetUTC:(int64_t)rotationResetUTC
                        retainedCount:(int)retainedCount
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->postScoreToDynamicLeaderboardUTC(
        [leaderboardId UTF8String], score, [jsonData UTF8String], (BrainCloud::SocialLeaderboardType)leaderboardType,
        (BrainCloud::RotationType)rotationType, rotationResetUTC, retainedCount, new BrainCloudCallback(cb, ecb, cbObject));
}
- (void)postScoreToDynamicLeaderboardDays:(NSString *)leaderboardId
                                    score:(int)score
                                 jsonData:(NSString *)jsonData
                          leaderboardType:(LeaderboardType)leaderboardType
                           roatationReset:(NSDate *)rotationReset
                            retainedCount:(int)retainedCount
                          numDaysToRotate:(int)numDaysToRotate
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject
{
    time_t time = [rotationReset timeIntervalSince1970];
    struct tm *timeStruct = localtime(&time);

    _client->getLeaderboardService()->postScoreToDynamicLeaderboardDays(
        [leaderboardId UTF8String], score, [jsonData UTF8String], (BrainCloud::SocialLeaderboardType)leaderboardType,
        timeStruct, retainedCount, numDaysToRotate, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToDynamicLeaderboardDaysUTC:(NSString *)leaderboardId
                                    score:(int)score
                                 jsonData:(NSString *)jsonData
                          leaderboardType:(LeaderboardType)leaderboardType
                           roatationResetUTC:(int64_t)rotationResetUTC
                            retainedCount:(int)retainedCount
                          numDaysToRotate:(int)numDaysToRotate
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->postScoreToDynamicLeaderboardDaysUTC(
        [leaderboardId UTF8String], score, [jsonData UTF8String], (BrainCloud::SocialLeaderboardType)leaderboardType,
        rotationResetUTC, retainedCount, numDaysToRotate, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToDynamicGroupLeaderboardDaysUTC:(NSString *)leaderboardId
                                  groupId:(NSString *)groupId
                                    score:(int)score
                                 jsonData:(NSString *)jsonData
                          leaderboardType:(LeaderboardType)leaderboardType
                           roatationResetUTC:(int64_t)rotationResetUTC
                            retainedCount:(int)retainedCount
                          numDaysToRotate:(int)numDaysToRotate
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->postScoreToDynamicGroupLeaderboardDaysUTC(
        [leaderboardId UTF8String], [groupId UTF8String], score, [jsonData UTF8String], "DAYS",
        rotationResetUTC, retainedCount, numDaysToRotate, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)removePlayerScore:(NSString *)leaderboardId
                versionId:(int)versionId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->removePlayerScore(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGroupSocialLeaderboard:(NSString *)leaderboardId
                          groupId:(NSString *)groupId
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGroupSocialLeaderboard(
        [leaderboardId UTF8String], [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGroupSocialLeaderboardByVersion:(NSString *)leaderboardId
                                   groupId:(NSString *)groupId
                                 versionId:(int)versionId
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGroupSocialLeaderboardByVersion(
        [leaderboardId UTF8String], [groupId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPlayersSocialLeaderboard:(NSString *)leaderboardId
                         profileIds:(NSArray *)profileIds
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    std::vector<std::string> lbIds;
    for (NSString *nsid in profileIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }

    _client->getLeaderboardService()->getPlayersSocialLeaderboard(
        [leaderboardId UTF8String], lbIds, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPlayersSocialLeaderboardByVersion:(NSString *)leaderboardId
                                  profileIds:(NSArray *)profileIds
                                   versionId:(int)versionId
                             completionBlock:(BCCompletionBlock)cb
                        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                    cbObject:(BCCallbackObject)cbObject
{
    std::vector<std::string> lbIds;
    for (NSString *nsid in profileIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }
    
    _client->getLeaderboardService()->getPlayersSocialLeaderboardByVersion(
        [leaderboardId UTF8String], lbIds, versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)listAllLeaderboards:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->listAllLeaderboards(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPlayerScore:(NSString *)leaderboardId
               versionId:(int)versionId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getPlayerScore(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPlayerScoresFromLeaderboards:(NSArray *)leaderboardIds
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject
{
    std::vector<std::string> lbIds;
    for (NSString *nsid in leaderboardIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }

    _client->getLeaderboardService()->getPlayerScoresFromLeaderboards(
        lbIds, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToGroupLeaderboard:(NSString *)leaderboardId
                            groupId:(NSString *)groupId
                              score:(int)score
                           jsonData:(NSString *)jsonData
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->postScoreToGroupLeaderboard(
        [leaderboardId UTF8String], [groupId UTF8String], score, [jsonData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToDynamicGroupLeaderboard:(NSString *)leaderboardId
                                   groupId:(NSString *)groupId
                                     score:(int)score
                                  jsonData:(NSString *)jsonData
                           leaderboardType:(NSString *)leaderboardType
                              rotationType:(NSString *)rotationType
                         rotationResetTime:(int64_t)rotationResetTime
                             retainedCount:(int32_t)retainedCount
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->postScoreToDynamicGroupLeaderboard(
            [leaderboardId UTF8String], [groupId UTF8String], score, [jsonData UTF8String],[leaderboardType UTF8String],
                [rotationType UTF8String], rotationResetTime, retainedCount, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToDynamicGroupLeaderboardUTC:(NSString *)leaderboardId
                                   groupId:(NSString *)groupId
                                     score:(int)score
                                  jsonData:(NSString *)jsonData
                           leaderboardType:(NSString *)leaderboardType
                              rotationType:(NSString *)rotationType
                         rotationResetTimeUTC:(int64_t)rotationResetTimeUTC
                             retainedCount:(int32_t)retainedCount
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->postScoreToDynamicGroupLeaderboardUTC(
            [leaderboardId UTF8String], [groupId UTF8String], score, [jsonData UTF8String],[leaderboardType UTF8String],
                [rotationType UTF8String], rotationResetTimeUTC, retainedCount, new BrainCloudCallback(cb, ecb, cbObject));
}
- (void)removeGroupScore:(NSString *)leaderboardId
                 groupId:(NSString *)groupId
               versionId:(int)versionId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->removeGroupScore(
        [leaderboardId UTF8String], [groupId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGroupLeaderboardView:(NSString *)leaderboardId
                        groupId:(NSString *)groupId
                           sort:(SortOrder)sort
                    beforeCount:(int)beforeCount
                     afterCount:(int)afterCount
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGroupLeaderboardView(
        [leaderboardId UTF8String], [groupId UTF8String], (BrainCloud::SortOrder)sort, beforeCount, afterCount, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGroupLeaderboardViewByVersion:(NSString *)leaderboardId
                                 groupId:(NSString *)groupId
                               versionId:(int)versionId
                                    sort:(SortOrder)sort
                             beforeCount:(int)beforeCount
                              afterCount:(int)afterCount
                         completionBlock:(BCCompletionBlock)cb
                    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                cbObject:(BCCallbackObject)cbObject
{
    _client->getLeaderboardService()->getGroupLeaderboardViewByVersion(
        [leaderboardId UTF8String], [groupId UTF8String], versionId, (BrainCloud::SortOrder)sort, beforeCount, afterCount, new BrainCloudCallback(cb, ecb, cbObject));
}

@end
