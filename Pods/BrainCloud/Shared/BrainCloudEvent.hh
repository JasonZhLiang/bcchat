//
//  BrainCloudEvent.h
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

@interface BrainCloudEvent : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Sends an event to the designated player id with the attached json data.
* Any events that have been sent to a player will show up in their
* incoming event mailbox. If the recordLocally flag is set to true,
* a copy of this event (with the exact same event id) will be stored
* in the sending player's "sent" event mailbox.
*
* Note that the list of sent and incoming events for a player is returned
* in the "ReadPlayerState" call (in the BrainCloudPlayer module).
*
* Service Name - event
* Service Operation - SEND
*
* @param toProfileId The id of the player who is being sent the event
* @param eventType The user-defined type of the event.
* @param jsonEventData The user-defined data for this event encoded in JSON.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)sendEvent:(NSString *)toProfileId
               eventType:(NSString *)eventType
           jsonEventData:(NSString *)eventData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Updates an event in the player's incoming event mailbox.
*
* Service Name - event
* Service Operation - UPDATE_EVENT_DATA
*
* @param eventId The event id
* @param jsonEventData The user-defined data for this event encoded in JSON.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)updateIncomingEventData:(NSString *)evId
                  jsonEventData:(NSString *)eventData
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;

/**
* Delete an event out of the player's incoming mailbox.
*
* Service Name - event
* Service Operation - DELETE_INCOMING
*
* @param evId The event id
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)deleteIncomingEvent:(NSString *)evId
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
* Get the events currently queued for the player.
*
* Service Name - event
* Service Operation - GET_EVENTS
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getEvents:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Delete a list of events out of the user's incoming mailbox.
 *
 * Service Name - event
 * Service Operation - DELETE_INCOMING_EVENTS
 *
 * @param eventIds Collection of event ids
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)deleteIncomingEvents:(NSArray *)eventIds
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Delete any events older than the given date out of the user's incoming mailbox.
 *
 * Service Name - event
 * Service Operation - DELETE_INCOMING_EVENTS_OLDER_THAN
 *
 * @param dateMillis createdAt cut-off time whereby older events will be deleted (In UTC since Epoch)
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)deleteIncomingEventsOlderThan:(int64_t)dateMillis
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject;

/**
 * Delete any events of the given type older than the given date out of the user's incoming mailbox.
 *
 * Service Name - event
 * Service Operation - DELETE_INCOMING_EVENTS_BY_TYPE_OLDER_THAN
 *
 * @param eventType The user-defined type of the event
 * @param dateMillis createdAt cut-off time whereby older events will be deleted (In UTC since Epoch)
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)deleteIncomingEventsByTypeOlderThan:(NSString *)eventType
                                 dateMillis:(int64_t)dateMillis
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
