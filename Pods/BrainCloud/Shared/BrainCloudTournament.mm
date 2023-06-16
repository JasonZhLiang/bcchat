
    
//
//  BrainCloudTournament.mm
//  BrainCloud
//
//  Created by Bradley Hill on 2017-01-06.
//  Copyright © 2017 BitHeads Inc. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

#import "BrainCloudTournament.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudTournament ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudTournament

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)claimTournamentReward:(NSString *)leaderboardId
                    versionId:(int)versionId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->claimTournamentReward(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getTournamentStatus:(NSString *)leaderboardId
                  versionId:(int)versionId
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->getTournamentStatus(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getDivisionInfo:(NSString *)divSetId
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->getDivisionInfo(
        [divSetId UTF8String],new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getMyDivisions:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->getMyDivisions(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)joinDivision:(NSString *)divSetId
      tournamentCode:(NSString *)tournamentCode
        initialScore:(long)initialScore
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->joinDivision(
        [divSetId UTF8String], [tournamentCode UTF8String], initialScore,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)leaveDivisionInstance:(NSString *)leaderBoardId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->leaveDivisionInstance(
        [leaderBoardId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)joinTournament:(NSString *)leaderboardId
        tournamentCode:(NSString *)tournamentCode
          initialScore:(int)initialScore
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->joinTournament(
        [leaderboardId UTF8String], [tournamentCode UTF8String], initialScore,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)leaveTournament:(NSString *)leaderboardId
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->leaveTournament(
        [leaderboardId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postTournamentScore:(NSString *)leaderboardId
                      score:(int)score
                   jsonData:(NSString *)jsonData
           roundStartedTimeLocal:(NSDate *)roundStartedTime
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    time_t time = [roundStartedTime timeIntervalSince1970];
    struct tm *timeStruct = gmtime(&time);

    _client->getTournamentService()->postTournamentScore(
        [leaderboardId UTF8String], score, jsonData == nil ? "" : [jsonData UTF8String], timeStruct,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postTournamentScoreUTC:(NSString *)leaderboardId
                      score:(int)score
                   jsonData:(NSString *)jsonData
           roundStartedTimeUTC:(int64_t)roundStartedTime
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->postTournamentScoreUTC(
    [leaderboardId UTF8String], score, jsonData == nil ? "" : [jsonData UTF8String], roundStartedTime,
    new BrainCloudCallback(cb, ecb, cbObject));
    
}

- (void)postTournamentScoreWithResults:(NSString *)leaderboardId
                                 score:(int)score
                              jsonData:(NSString *)jsonData
                      roundStartedTimeLocal:(NSDate *)roundStartedTime
                             sortOrder:(SortOrder)sortOrder
                           beforeCount:(int)beforeCount
                            afterCount:(int)afterCount
                          initialScore:(int)initialScore
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject
{
    time_t time = [roundStartedTime timeIntervalSince1970];
    struct tm *timeStruct = gmtime(&time);

    _client->getTournamentService()->postTournamentScoreWithResults(
        [leaderboardId UTF8String], score, jsonData == nil ? "" : [jsonData UTF8String], timeStruct,
        (BrainCloud::SortOrder)sortOrder, beforeCount, afterCount, initialScore,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postTournamentScoreWithResultsUTC:(NSString *)leaderboardId
                                 score:(int)score
                              jsonData:(NSString *)jsonData
                      roundStartedTimeUTC:(int64_t)roundStartedTime
                             sortOrder:(SortOrder)sortOrder
                           beforeCount:(int)beforeCount
                            afterCount:(int)afterCount
                          initialScore:(int)initialScore
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->postTournamentScoreWithResultsUTC(
        [leaderboardId UTF8String], score, jsonData == nil ? "" : [jsonData UTF8String], roundStartedTime,
        (BrainCloud::SortOrder)sortOrder, beforeCount, afterCount, initialScore,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)viewCurrentReward:(NSString *)leaderboardId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->viewCurrentReward(
        [leaderboardId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)viewReward:(NSString *)leaderboardId
               versionId:(int)versionId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getTournamentService()->viewReward(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

@end
