//
//  BrainCloudPresence.h
//  BrainCloud
//
//  Created by Ryan Ruth on 2018-09-13.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#ifndef BrainCloudPresence_h
#define BrainCloudPresence_h

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudPresence : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Force an RTT presence update to all listeners of the caller
 *
 * Service Name - presence
 * Service Operation - FORCE_PUSH
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)forcePush:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the presence data of friends
 *
 * Service Name - presence
 * Service Operation - GET_PRESENCE_OF_FRIENDS
 *
 * @param includeOffline will not include offline profiles unless it's set to true
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getPresenceOfFriends:(NSString *) platform
              includeOffline:(bool)includeOffline
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the presence data of friends
 *
 * Service Name - presence
 * Service Operation - GET_PRESENCE_OF_GROUP
 *
 * @param groupId the id for the group
 * @param includeOffline will not include offline profiles unless it's set to true
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getPresenceOfGroup:(NSString *)groupId
            includeOffline:(bool)includeOffline
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the presence data of profileIds.
 *
 * Service Name - presence
 * Service Operation - GET_PRESENCE_OF_USERS
 *
 * @param profileIds list of profile ids
 * @param includeOffline will not include offline profiles unless it's set to true
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getPresenceOfUsers:(NSArray *)profileIds
            includeOffline:(bool)includeOffline
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Registers the caller for RTT presence updates from friends for the given friends.
 *
 * Service Name - presence
 * Service Operation - REGISTER_LISTENERS_FOR_FRIENDS
 *
 * @param platform the store platform - Valid stores: all, brainCloud, facebook
 * @param bidirectional allows registration for target user for presence update
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)registerListenersForFriends:(NSString *)platform
                     bidirectional:(bool)bidirectional
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject;

/**
 * Registers the caller for RTT presence updates from friends for the given groupId.
 *
 * Service Name - presence
 * Service Operation - REGISTER_LISTENERS_FOR_GROUP
 *
 * @param groupId the id of the group
 * @param bidirectional allows registration for target user for presence update
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)registerListenersForGroup:(NSString *)groupId
                    bidirectional:(bool)bidirectional
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject;

/**
 * Registers the caller for RTT presence updates from friends for the given profileIds.
 *
 * Service Name - presence
 * Service Operation - REGISTER_LISTENERS_FOR_PROFILES
 *
 * @param profileIds the id of the group
 * @param bidirectional allows registration for target user for presence update
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)registerListenersForProfiles:(NSArray *)profileIds
                      bidirectional:(bool)bidirectional
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject;

/**
 * Update the presence data visible field for the caller
 *
 * Service Name - presence
 * Service Operation - SET_VISIBILITY
 *
 * @param visible determines if the user is visible
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)setVisibility:(bool)visible
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Update the presence data visible field for the caller
 *
 * Service Name - presence
 * Service Operation - SET_VISIBILITY
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)stopListening:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Update the presence data visible field for the caller
 *
 * Service Name - presence
 * Service Operation - UPDATE_ACTIVITY
 *
 * @param jsonActivity the json data
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateActivity:(NSString *)jsonActivity
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

#endif /* BrainCloudPresence_h */

@end
