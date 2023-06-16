//
//  BrainCloudGamification.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-12.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudGamification : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Method retrieves all gamification data for the player.
*
* Service Name - Gamification
* Service Operation - Read
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readAllGamification:(bool)includeMetaData
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
* Method retrieves all milestones defined for the game.
*
* Service Name - Gamification
* Service Operation - ReadMilestones
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readMilestones:(bool)includeMetaData
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
* Read all of the achievements defined for the game.
*
* Service Name - Gamification
* Service Operation - ReadAchievements
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readAchievements:(bool)includeMetaData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Method returns all defined xp levels and any rewards associated
* with those xp levels.
*
* Service Name - Gamification
* Service Operation - ReadXpLevels
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readXpLevelsMetaData:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
* Method retrives the list of achieved achievements.
*
* Service Name - Gamification
* Service Operation - ReadAchievedAchievements
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readAchievedAchievements:(bool)includeMetaData
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
* Method retrieves the list of completed milestones.
*
* Service Name - Gamification
* Service Operation - ReadCompleteMilestones
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readCompletedMilestones:(bool)includeMetaData
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;

/**
* Method retrieves the list of in progress milestones
*
* Service Name - Gamification
* Service Operation - ReadInProgressMilestones
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readInProgressMilestones:(bool)includeMetaData
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
* Method retrieves milestones of the given category.
*
* Service Name - Gamification
* Service Operation - ReadMilestonesByCategory
*
* @param category The milestone category
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readMilestonesByCategory:(NSString *)category
                 includeMetaData:(bool)includeMetaData
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
* Method will award the achievements specified. On success, this will
* call AwardThirdPartyAchievement to hook into the client-side Achievement
* service (ie GameCentre, Facebook etc).
*
* Service Name - Gamification
* Service Operation - AwardAchievements
*
* @param achievementIds A NSString array of achievement ids to award
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)awardAchievements:(NSArray*) achievementIds
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
* Method retrieves all of the quests defined for the game.
*
* Service Name - Gamification
* Service Operation - ReadQuests
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readQuests:(bool)includeMetaData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
*  Method returns all completed quests.
*
* Service Name - Gamification
* Service Operation - ReadCompletedQuests
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readCompletedQuests:(bool)includeMetaData
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
*  Method returns quests that are in progress.
*
* Service Name - Gamification
* Service Operation - ReadInProgressQuests
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readInProgressQuests:(bool)includeMetaData
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
*  Method returns quests that have not been started.
*
* Service Name - Gamification
* Service Operation - ReadNotStartedQuests
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readNotStartedQuests:(bool)includeMetaData
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
*  Method returns quests with a status.
*
* Service Name - Gamification
* Service Operation - ReadQuestsWithStatus
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readQuestsWithStatus:(bool)includeMetaData
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
*  Method returns quests with a basic percentage.
*
* Service Name - Gamification
* Service Operation - ReadQuestsWithBasicPercentage
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readQuestsWithBasicPercentage:(bool)includeMetaData
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject;

/**
*  Method returns quests with a complex percentage.
*
* Service Name - Gamification
* Service Operation - ReadQuestsWithComplexPercentage
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readQuestsWithComplexPercentage:(bool)includeMetaData
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject;

/**
* Method returns quests for the given category.
*
* Service Name - Gamification
* Service Operation - ReadQuestsByCategory
*
* @param category The quest category
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readQuestsByCategory:(NSString *)category
             includeMetaData:(bool)includeMetaData
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
