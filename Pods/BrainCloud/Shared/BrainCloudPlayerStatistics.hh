//
//  BrainCloudPlayerStatistics.hh
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-06.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudPlayerStatistics : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Read all available user statistics.
*
* Service Name - PlayerStatistics
* Service Operation - Read
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readAllUserStats:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Reads a subset of user statistics.
*
* Service Name - PlayerStatistics
* Service Operation - ReadSubset
*
* @param userStats A NSString array containing the subset of statistics to read:
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readUserStatsSubset:(NSArray *)userStats
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Method retrieves the user statistics for the given category.
 *
 * Service Name - PlayerStatistics
 * Service Operation - READ_FOR_CATEGORY
 *
 * @param category The user statistics category
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readUserStatsForCategory:(NSString *)category
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
* Reset all of the statistics for this user back to their initial value.
*
* Service Name - PlayerStatistics
* Service Operation - Reset
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)resetAllUserStats:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
* Atomically increment (or decrement) user statistics.
* Any rewards that are triggered from user statistic increments
* will be considered. Yser statistics are defined through the brainCloud portal.
* Note also that the "xpCapped" property is returned (true/false depending on whether
* the xp cap is turned on and whether the user has hit it).
*
* Service Name - PlayerStatistics
* Service Operation - Update
*
* @param jsonData The JSON encoded data to be sent to the server as follows:
* {
*   stat1: 10,
*   stat2: -5.5,
* }
* would increment stat1 by 10 and decrement stat2 by 5.5.
* For the full statistics grammer see the api.braincloudservers.com site.
* There are many more complex operations supported such as:
* {
*   stat1:INC_TO_LIMIT#9#30
* }
* which increments stat1 by 9 up to a limit of 30.
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)incrementUserStats:(NSString *)jsonData
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
* Returns JSON representing the next experience level for the user.
*
* Service Name - PlayerStatistics
* Service Operation - ReadNextXpLevel
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getNextExperienceLevel:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
* Increments the user's experience. If the player goes up a level,
* the new level details will be returned along with a list of rewards.
*
* Service Name - PlayerStatistics
* Service Operation - UpdateIncrement
*
* @param xpValue The amount to increase the player's experience by
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)incrementExperiencePoints:(int)xpValue
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
* Sets the user's experience to an absolute value. Note that this
* is simply a set and will not reward the player if their level changes
* as a result.
*
* Service Name - PlayerStatistics
* Service Operation - SetXpPoints
*
* @param xpValue The amount to set the the player's experience to
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)setExperiencePoints:(int)xpValue
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Apply statistics grammar to a partial set of statistics.
 *
 * Service Name - PlayerStatistics
 * Service Operation - PROCESS_STATISTICS
 *
 * @param jsonData The JSON format is as follows:
 * {
 *     "DEAD_CATS": "RESET",
 *     "LIVES_LEFT": "SET#9",
 *     "MICE_KILLED": "INC#2",
 *     "DOG_SCARE_BONUS_POINTS": "INC#10",
 *     "TREES_CLIMBED": 1
 * }
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)processStatistics:(NSString *)jsonData
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
