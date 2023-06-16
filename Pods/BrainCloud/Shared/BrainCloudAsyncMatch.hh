//
//  BrainCloudAsyncMatch.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudAsyncMatch : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Creates an instance of an asynchronous match.
*
* Service Name - AsyncMatch
* Service Operation - Create
*
* @param jsonOpponentIds  JSON string identifying the opponent platform and id for this match.
*
* Platforms are identified as:
* BC - a brainCloud profile id
* FB - a Facebook id
*
* An example of this string would be:
* [
*     {
*         "platform": "BC",
*         "id": "some-braincloud-profile"
*     },
*     {
*         "platform": "FB",
*         "id": "some-facebook-id"
*     }
* ]
*
* @param pushNotificationMessage Optional push notification message to send to the other party.
*  Refer to the Push Notification functions for the syntax required.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)createMatch:(NSString *)jsonOpponentIds 
    pushNotificationMessage:(NSString *)pushMessage
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
* Creates an instance of an asynchronous match with an initial turn.
*
* Service Name - AsyncMatch
* Service Operation - Create
*
* @param jsonOpponentIds  JSON string identifying the opponent platform and id for this match.
*
* Platforms are identified as:
* BC - a brainCloud profile id
* FB - a Facebook id
*
* An exmaple of this string would be:
* [
*     {
*         "platform": "BC",
*         "id": "some-braincloud-profile"
*     },
*     {
*         "platform": "FB",
*         "id": "some-facebook-id"
*     }
* ]
*
* @param jsonMatchState    JSON string blob provided by the caller
* @param pushNotificationMessage Optional push notification message to send to the other party.
* Refer to the Push Notification functions for the syntax required.
* @param nextPlayer Optionally, force the next player player to be a specific player
* @param jsonSummary Optional JSON string defining what the other player will see as a summary of the game when listing their games
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)createMatchWithInitialTurn:(NSString *)jsonOpponentIds
                    jsonMatchState:(NSString *)matchState
           pushNotificationMessage:(NSString *)pushMessage
                        nextPlayer:(NSString *)nextPlayer
                       jsonSummary:(NSString *)summary
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject;

/**
* Submits a turn for the given match.
*
* Service Name - AsyncMatch
* Service Operation - SubmitTurn
*
* @param ownerId Match owner identfier
* @param matchId Match identifier
* @param version Game state version to ensure turns are submitted once and in order
* @param jsonMatchState JSON string provided by the caller
* @param pushNotificationMessage Optional push notification message to send to the other party.
*  Refer to the Push Notification functions for the syntax required.
* @param nextPlayer Optionally, force the next player player to be a specific player
* @param jsonSummary Optional JSON string that other players will see as a summary of the game when listing their games
* @param jsonStatistics Optional JSON string blob provided by the caller
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)submitTurn:(NSString *)ownerId
                    matchId:(NSString *)matchId
                    version:(uint64_t)version
             jsonMatchState:(NSString *)matchState
    pushNotificationMessage:(NSString *)pushMessage
                 nextPlayer:(NSString *)nextPlayer
                jsonSummary:(NSString *)summary
             jsonStatistics:(NSString *)stats
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
* Allows the current player (only) to update Summary data without having to submit a whole turn.
*
* Service Name - AsyncMatch
* Service Operation - UpdateMatchSummary
*
* @param ownerId Match owner identfier
* @param matchId Match identifier
* @param version Game state version to ensure turns are submitted once and in order
* @param jsonSummary JSON string that other players will see as a summary of the game when listing their games
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)updateMatchSummaryData:(NSString *)ownerId
                       matchId:(NSString *)matchId
                       version:(uint64_t)version
                   jsonSummary:(NSString *)summary
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
* Marks the given match as complete.
*
* Service Name - AsyncMatch
* Service Operation - Complete
*
* @param ownerId Match owner identifier
* @param matchId Match identifier
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)completeMatch:(NSString *)ownerId
              matchId:(NSString *)matchId
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
* Returns the current state of the given match.
*
* Service Name - AsyncMatch
* Service Operation - ReadMatch
*
* @param ownerId   Match owner identifier
* @param matchId   Match identifier
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readMatch:(NSString *)ownerId
                 matchId:(NSString *)matchId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Marks the given match as abandoned.
*
* Service Name - AsyncMatch
* Service Operation - Abandon
*
* @param ownerId   Match owner identifier
* @param matchId   Match identifier
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)abandonMatch:(NSString *)ownerId
             matchId:(NSString *)matchId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
* Removes the match and match history from the server. DEBUG ONLY, in production it is recommended
*   the user leave it as completed.
*
* Service Name - AsyncMatch
* Service Operation - Delete
*
* @param ownerId   Match owner identifier
* @param matchId   Match identifier
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)deleteMatch:(NSString *)ownerId
                 matchId:(NSString *)matchId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Returns the match history of the given match.
*
* Service Name - AsyncMatch
* Service Operation - ReadMatchHistory
*
* @param ownerId   Match owner identifier
* @param matchId   Match identifier
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readMatchHistory:(NSString *)ownerId
                 matchId:(NSString *)matchId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Returns all matches that are NOT in a COMPLETE state for which the player is involved.
*
* Service Name - AsyncMatch
* Service Operation - FindMatches
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)findMatches:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Returns all matches that are in a COMPLETE state for which the player is involved.
*
* Service Name - AsyncMatch
* Service Operation - FindMatchesCompleted
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)findCompleteMatches:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Marks the given match as complete.
 *
 * Service Name - AsyncMatch
 * Service Operation - CompleteMatchWithSummaryData
 *
 * @param ownerId   Match owner identifier
 * @param matchId   Match identifier
 * @param pushContent
 * @param summary
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)completeMatchWithSummaryData:(NSString *)ownerId
                             matchId:(NSString *)matchId
                         pushContent:(NSString *)pushContent
                             summary:(NSString *)summary
                                  cb:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject;

/**
 * Marks the given match as abandoned.
 *
 * Service Name - AsyncMatch
 * Service Operation - AbandonMatchWithSummaryData
 *
 * @param ownerId   Match owner identifier
 * @param matchId   Match identifier
 * @param pushContent
 * @param summary
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)abandonMatchWithSummaryData:(NSString *)ownerId
                             matchId:(NSString *)matchId
                         pushContent:(NSString *)pushContent
                             summary:(NSString *)summary
                                  cb:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
