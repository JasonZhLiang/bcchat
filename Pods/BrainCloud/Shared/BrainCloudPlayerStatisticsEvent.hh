//
//  BrainCloudPlayerStatisticsEvent.h
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

@interface BrainCloudPlayerStatisticsEvent : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Trigger an event server side that will increase the user's statistics.
* This may cause one or more awards to be sent back to the user -
* could be achievements, experience, etc. Achievements will be sent by this
* client library to the appropriate awards service (Apple Game Center, etc).
*
* This mechanism supercedes the PlayerStatisticsService API methods, since
* PlayerStatisticsService API method only update the raw statistics without
* triggering the rewards.
*
* Service Name - PlayerStatisticsEvent
* Service Operation - Trigger
*
* @see BrainCloudPlayerStatistics
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)triggerStatsEvent:(NSString *)eventName
          eventMultiplier:(int)multiplier
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
* See documentation for TriggerPlayerStatisticsEvent for more
* documentation.
*
* Service Name - PlayerStatisticsEvent
* Service Operation - TriggerMultiple
*
* @param jsonData
*   [
*     {
*       "eventName": "event1",
*       "eventMultiplier": 1
*     },
*     {
*       "eventName": "event2",
*       "eventMultiplier": 1
*     }
*   ]
*/
- (void)triggerStatsEvents:(NSString *)jsonData
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
