//
//  BrainCloudOneWayMatch.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-11.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudOneWayMatch : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Starts a match
*
* Service Name - OneWayMatch
* Service Operation - StartMatch
*
* @param otherPlayerId The player to start a match with
* @param rangeDelta The range delta used for the initial match search
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)startMatch:(NSString *)otherPlayerId
              rangeDelta:(int32_t)range
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Cancels a match
*
* Service Name - OneWayMatch
* Service Operation - CancelMatch
*
* @param playbackStreamId The playback stream id returned in the start match
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)cancelMatch:(NSString *)playbackStreamId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Completes a match
*
* Service Name - OneWayMatch
* Service Operation - CompleteMatch
*
* @param playbackStreamId The playback stream id returned in the initial start match
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)completeMatch:(NSString *)playbackStreamId
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
