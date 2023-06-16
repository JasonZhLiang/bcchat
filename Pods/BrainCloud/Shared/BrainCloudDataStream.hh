//
//  BrainCloudDataStream.hh
//  brainCloudClientObjc
//
//  Created by Preston Jennings on 2015-11-26.
//  Copyright © 2015 bitHeads. All rights reserved.
//
#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudDataStream : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Creates custom data stream page event
 *
 * @param eventName Name of event
 * @param eventProperties Properties of event
 */
- (void)customPageEvent:(NSString *)eventName
    jsonEventProperties:(NSString *)jsonEventProperties
        completionBlock:(BCCompletionBlock)completionBlock
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;


/**
 * Creates custom data stream screen event
 *
 * @param eventName Name of event
 * @param eventProperties Properties of event
 */
- (void)customScreenEvent:(NSString *)eventName
      jsonEventProperties:(NSString *)jsonEventProperties
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Creates custom data stream track event
 *
 * @param eventName Name of event
 * @param eventProperties Properties of event
 */
- (void)customTrackEvent:(NSString *)eventName
     jsonEventProperties:(NSString *)jsonEventProperties
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * SendCrashReport
 *
 * @param crashType
 * @param errorMsg
 * @param crashJson
 * @param crashLog
 * @param userName
 * @param userEmail
 * @param userNotes
 * @param userSubmitted
 */
- (void)submitCrashReport:(NSString *)crashType
                 errorMsg:(NSString *)errorMsg
                crashJson:(NSString *)crashJson
                 crashLog:(NSString *)crashLog
                 userName:(NSString *)userName
                userEmail:(NSString *)userEmail
                userNotes:(NSString *)userNotes
            userSubmitted:(bool)userSubmitted
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;


@end

#pragma clang diagnostic pop
