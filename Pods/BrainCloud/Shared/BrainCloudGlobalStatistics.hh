//
//  BrainCloudGlobalStatistics.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-06.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;

@interface BrainCloudGlobalStatistics : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Method returns all of the global statistics.
*
* Service Name - GlobalStatistics
* Service Operation - Read
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readAllGlobalStats:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
* Reads a subset of global statistics.
*
* Service Name - GlobalStatistics
* Service Operation - ReadSubset
*
* @param globalStats A NSString array containing the statistics to read.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readGlobalStatsSubset:(NSArray *)globalStats
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Method retrieves the global statistics for the given category.
 *
 * Service Name - GlobalStatistics
 * Service Operation - READ_FOR_CATEGORY
 *
 * @param category The global statistics category
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * @return The JSON returned in the completion block is as follows:
 * {
 *   "status":200,
 *   "data":{
 *     "gameStatistics": []
 *   }
 * }
 */
- (void)readGlobalStatsForCategory:(NSString *)category
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject;

/**
* Atomically increment (or decrement) global statistics.
* Global statistics are defined through the brainCloud portal.
*
* Service Name - GlobalStatistics
* Service Operation - UpdateIncrement
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
- (void)incrementGlobalStats:(NSString *)jsonData
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Apply statistics grammar to a partial set of statistics.
 *
 * Service Name - GlobalStatistics
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
