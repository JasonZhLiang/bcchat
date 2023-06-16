//
//  BrainCloudPlaybackStream.h
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

@interface BrainCloudPlaybackStream : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Starts a stream
*
* Service Name - PlaybackStream
* Service Operation - StartStream
*
* @param targetPlayerId The player to start a stream with
* @param includeSharedData Whether to include shared data in the stream
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*
*/
- (void)startStream:(NSString *)targetPlayerId
       includeSharedData:(bool)includeSharedData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Reads a stream
*
* Service Name - PlaybackStream
* Service Operation - ReadStream
*
* @param playbackStreamId Identifies the stream to read
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readStream:(NSString *)streamId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Ends a stream
*
* Service Name - PlaybackStream
* Service Operation - EndStream
*
* @param playbackStreamId Identifies the stream to read
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)endStream:(NSString *)streamId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Deletes a stream
*
* Service Name - PlaybackStream
* Service Operation - DeleteStream
*
* @param playbackStreamId Identifies the stream to read
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)deleteStream:(NSString *)streamId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
* Adds a stream event
*
* Service Name - PlaybackStream
* Service Operation - AddEvent
*
* @param playbackStreamId Identifies the stream to read
* @param jsonEventData Describes the event
* @param jsonSummary Current summary data as of this event
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)addEvent:(NSString *)streamId
           jsonEventData:(NSString *)eventData
             jsonSummary:(NSString *)summary
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Gets stream summaries for target player
 *
 * Service Name - PlaybackStream
 * Service Operation - GetStreamSummariesForTargetPlayer
 *
 * @param initiatingPlayerId The player that started the stream
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getRecentStreamsForInitiatingPlayer:(NSString *)initiatingPlayerId
                              maxNumStreams:(int)maxStreams
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject;

/**
 * Gets stream summaries for target player
 *
 * Service Name - PlaybackStream
 * Service Operation - GetStreamSummariesForTargetPlayer
 *
 * @param targetPlayerId The player that started the stream
 * @param targetPlayerId The player that started the stream
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getRecentStreamsForTargetPlayer:(NSString *)targetPlayerId
                          maxNumStreams:(int)maxStreams
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
