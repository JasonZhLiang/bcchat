//
//  BrainCloudTournament.h
//  BrainCloud
//
//  Created by Bradley Hill on 2017-01-06.
//  Copyright © 2017 BitHeads Inc. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"
#import "BrainCloudLeaderboard.hh"

@class BrainCloudClient;

@interface BrainCloudTournament : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Processes any outstanding rewards for the given player
 *
 * Service Name - tournament
 * Service Operation - CLAIM_TOURNAMENT_REWARD
 *
 * @param leaderboardId The leaderboard for the tournament
 * @param versionId Version of the tournament. Use -1 for the latest version.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)claimTournamentReward:(NSString *)leaderboardId
                    versionId:(int)versionId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Get tournament status associated with a leaderboard
 *
 * Service Name - tournament
 * Service Operation - GET_TOURNAMENT_STATUS
 *
 * @param leaderboardId The leaderboard for the tournament
 * @param versionId Version of the tournament. Use -1 for the latest version.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getTournamentStatus:(NSString *)leaderboardId
                  versionId:(int)versionId
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Get the status of a division
 *
 * Service Name - tournament
 * Service Operation - GET_DIVISION_INFO
 *
 * @param divSetId The id for the division
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getDivisionInfo:(NSString *)divSetId
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the player's recently active divisions
 *
 * Service Name - tournament
 * Service Operation - GET_MY_DIVISIONS
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getMyDivisions:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Joins a division
 *
 * Service Name - tournament
 * Service Operation - JOIN_DIVISION
 *
 * @param divSetId the id for the division
 * @param tournamentCode the tournament to join
 * @param initialScore score for player starting tournament, usually 0
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)joinDivision:(NSString *) divSetId
      tournamentCode: (NSString *)tournamentCode
        initialScore: (long)initialScore
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Leaves the specifid division
 *
 * Service Name - tournament
 * Service Operation - LEAVE_DIVISION_INSTANCE
 *
 * @param leaderBoardId the id of the tournament
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)leaveDivisionInstance:(NSString *) leaderBoardId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Join the specified tournament.
 * Any entry fees will be automatically collected.
 *
 * Service Name - tournament
 * Service Operation - JOIN_TOURNAMENT
 *
 * @param leaderboardId The leaderboard for the tournament
 * @param tournamentCode Tournament to join
 * @param initialScore The initial score for players first joining a tournament
 *						  Usually 0, unless leaderboard is LOW_VALUE
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)joinTournament:(NSString *)leaderboardId
          tournamentCode:(NSString *)tournamentCode
            initialScore:(int)initialScore
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Removes player's score from tournament leaderboard
 *
 * Service Name - tournament
 * Service Operation - LEAVE_TOURNAMENT
 *
 * @param leaderboardId The leaderboard for the tournament
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)leaveTournament:(NSString *)leaderboardId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Post the users score to the leaderboard - LOCAL time
 *
 * Service Name - tournament
 * Service Operation - POST_TOURNAMENT_SCORE
 *
 * @param leaderboardId The leaderboard for the tournament
 * @param score The score to post
 * @param jsonData Optional data attached to the leaderboard entry
 * @param roundStartedTimeLocal Time the user started the match and is converted
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)postTournamentScore:(NSString *)leaderboardId
                      score:(int)score
                   jsonData:(NSString *)jsonData
           roundStartedTimeLocal:(NSDate *)roundStartedTimeLocal
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Post the users score to the leaderboard - UTC time
 *
 * Service Name - tournament
 * Service Operation - POST_TOURNAMENT_SCORE
 *
 * @param leaderboardId The leaderboard for the tournament
 * @param score The score to post
 * @param jsonData Optional data attached to the leaderboard entry
 * @param roundStartedTimeUTC Time the user started the match resulting in the score being posted in UTC. Use UTC time in milliseconds since epoch
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)postTournamentScoreUTC:(NSString *)leaderboardId
                      score:(int)score
                   jsonData:(NSString *)jsonData
           roundStartedTimeUTC:(int64_t)roundStartedTimeUTC
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;
/**
* Post the users score to the leaderboard - LOCAL time
*
* Service Name - tournament
* Service Operation - POST_TOURNAMENT_SCORE_WITH_RESULTS
*
* @param leaderboardId The leaderboard for the tournament
* @param score The score to post
* @param jsonData Optional data attached to the leaderboard entry
* @param roundStartedTimeLocal Time the user started the match and is converted
* @param sort Sort key Sort order of page.
* @param beforeCount The count of number of players before the current player to include.
* @param afterCount The count of number of players after the current player to include.
* @param initialScore The initial score for players first joining a tournament
*                         Usually 0, unless leaderboard is LOW_VALUE
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)postTournamentScoreWithResults:(NSString *)leaderboardId
                                 score:(int)score
                              jsonData:(NSString *)jsonData
                      roundStartedTimeLocal:(NSDate *)roundStartedTimeLocal
                             sortOrder:(SortOrder)sortOrder
                           beforeCount:(int)beforeCount
                            afterCount:(int)afterCount
                          initialScore:(int)initialScore
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject;

/**
* Post the users score to the leaderboard - UTC time
*
* Service Name - tournament
* Service Operation - POST_TOURNAMENT_SCORE_WITH_RESULTS
*
* @param leaderboardId The leaderboard for the tournament
* @param score The score to post
* @param jsonData Optional data attached to the leaderboard entry
* @param roundStartedTimeUTC Time the user started the match resulting in the score being posted in UTC. Use UTC time in milliseconds since epoch
* @param sort Sort key Sort order of page.
* @param beforeCount The count of number of players before the current player to include.
* @param afterCount The count of number of players after the current player to include.
* @param initialScore The initial score for players first joining a tournament
*                         Usually 0, unless leaderboard is LOW_VALUE
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)postTournamentScoreWithResultsUTC:(NSString *)leaderboardId
                                 score:(int)score
                              jsonData:(NSString *)jsonData
                      roundStartedTimeUTC:(int64_t)roundStartedTimeUTC
                             sortOrder:(SortOrder)sortOrder
                           beforeCount:(int)beforeCount
                            afterCount:(int)afterCount
                          initialScore:(int)initialScore
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject;
/**
 * Returns the user's expected reward based on the current scores
 *
 * Service Name - tournament
 * Service Operation - VIEW_CURRENT_REWARD
 *
 * @param leaderboardId The leaderboard for the tournament
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)viewCurrentReward:(NSString *)leaderboardId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Returns the user's reward from a finished tournament
 *
 * Service Name - tournament
 * Service Operation - VIEW_REWARD
 *
 * @param leaderboardId The leaderboard for the tournament
 * @param versionId Version of the tournament. Use -1 for the latest version.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)viewReward:(NSString *)leaderboardId
               versionId:(int)versionId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
