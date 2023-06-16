//
//  BrainCloudEvent.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-12.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "BrainCloudEvent.hh"
#import "BrainCloudClient.hh"
#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#include "TypeHelpers.hh"

@interface BrainCloudEvent ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudEvent

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)sendEvent:(NSString *)toProfileId
               eventType:(NSString *)eventType
           jsonEventData:(NSString *)eventData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getEventService()->sendEvent(
        [toProfileId UTF8String], [eventType UTF8String], [eventData UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateIncomingEventData:(NSString *)evId
                  jsonEventData:(NSString *)eventData
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getEventService()->updateIncomingEventData(
        [evId UTF8String], [eventData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteIncomingEvent:(NSString *)evId
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getEventService()->deleteIncomingEvent(
        [evId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getEvents:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getEventService()->getEvents(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteIncomingEvents:(NSArray *)eventIds
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getEventService()->deleteIncomingEvents(TypeHelpers::NSStringArrayToVector(eventIds), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteIncomingEventsOlderThan:(int64_t)dateMillis
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject
{
    _client->getEventService()->deleteIncomingEventsOlderThan(dateMillis, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteIncomingEventsByTypeOlderThan:(NSString *)eventType
                                 dateMillis:(int64_t)dateMillis
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject
{
    _client->getEventService()->deleteIncomingEventsByTypeOlderThan([eventType UTF8String], dateMillis, new BrainCloudCallback(cb, ecb, cbObject));
}

@end
