//
//  BrainCloudDataStream.m
//  brainCloudClientObjc
//
//  Created by Preston Jennings on 2015-11-26.
//  Copyright © 2015 bitHeads. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "BrainCloudDataStream.hh"
#import "BrainCloudClient.hh"

@interface BrainCloudDataStream ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudDataStream

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)customPageEvent:(NSString *)eventName
    jsonEventProperties:(NSString *)jsonEventProperties
        completionBlock:(BCCompletionBlock)completionBlock
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client
    ->getDataStreamService()->customPageEvent(
                                              [eventName UTF8String],
                                              [jsonEventProperties UTF8String],
                                              new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)customScreenEvent:(NSString *)eventName
      jsonEventProperties:(NSString *)jsonEventProperties
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client
    ->getDataStreamService()->customScreenEvent(
                                                [eventName UTF8String],
                                                [jsonEventProperties UTF8String],
                                                new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)customTrackEvent:(NSString *)eventName
     jsonEventProperties:(NSString *)jsonEventProperties
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client
    ->getDataStreamService()->customTrackEvent(
                                               [eventName UTF8String],
                                               [jsonEventProperties UTF8String],
                                               new BrainCloudCallback(completionBlock, ecb, cbObject));
}

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
                 cbObject:(BCCallbackObject)cbObject
{
    _client
    ->getDataStreamService()->submitCrashReport(
                                               [crashType UTF8String],
                                               [errorMsg UTF8String],
                                               [crashJson UTF8String],
                                               [crashLog UTF8String],
                                               [userName UTF8String],
                                               [userEmail UTF8String],
                                               [userNotes UTF8String],
                                               userSubmitted,
                                               new BrainCloudCallback(completionBlock, ecb, cbObject));
}


@end
