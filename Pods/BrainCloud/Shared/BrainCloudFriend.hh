//
//  BrainCloudFriend.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//
#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;
@class FriendPlatformObjc;
@class AuthenticationTypeObjc;
@interface BrainCloudFriend : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Retrieves profile information for the specified user.
 *
 * Service Name - friend
 * Service Operation - GET_PROFILE_INFO_FOR_CREDENTIAL
 *
 * @param externalId The users's external ID
 * @param authenticationType The authentication type of the user ID
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getProfileInfoForCredential:(NSString *)externalId
                 authenticationType:(AuthenticationTypeObjc *)authenticationType
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves profile information for the specified external auth user.
 *
 * Service Name - friend
 * Service Operation - GET_PROFILE_INFO_FOR_EXTERNAL_AUTH_ID
 *
 * @param externalId External ID of the user to find
 * @param externalAuthType The external authentication type used for this user's external ID
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getProfileInfoForExternalAuthId:(NSString *)externalId
                       externalAuthType:(NSString *)externalAuthType
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject;

/**
 * Returns user state of a particular user.
 *
 * Service Name - Friend
 * Service Operation - GET_SUMMARY_DATA_FOR_PROFILE_ID
 *
 * @param profileId Profile (user) ID.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getSummaryDataForProfileId:(NSString *)profileId
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves the external ID for the specified user profile ID on the specified social platform.
 *
 * @param profileId Profile (user) ID.
 * @param authenticationType Associated authentication type.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getExternalIdForProfileId:(NSString *)profileId
               authenticationType:(NSString *)authenticationType
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
* Returns a particular entity of a particular friend.
*
* Service Name - Friend
* Service Operation - ReadFriendEntity
*
* @param entityId Id of entity to retrieve.
* @param friendId Profile Id of friend who owns entity.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readFriendEntity:(NSString *)entityId
                friendId:(NSString *)friendId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
* Returns entities of all friends optionally based on type.
*
* Service Name - Friend
* Service Operation - ReadFriendsEntities
*
* @param entityType Types of entities to retrieve.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readFriendsEntities:(NSString *)entityType
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
* Read a friend's user state.
* If you are not friend with this user, you will get an error
* with NOT_FRIENDS reason code.
*
* Service Name - PlayerState
* Service Operation - ReadFriendsPlayerState
*
* @param friendId Target friend
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readFriendUserState:(NSString *)friendId
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Finds a list of users matching the search text by performing an exact match search
 *
 * Service Name - friend
 * Service Operation - FIND_USERS_BY_EXACT_NAME
 *
 * @param searchText The string to search for.
 * @param maxResults  Maximum number of results to return.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)findUsersByExactName:(NSString *)searchText
                  maxResults:(int)maxResults
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Finds a list of users matching the search text by performing a substring
 * search of all user names.
 *
 * Service Name - friend
 * Service Operation - FIND_USERS_BY_SUBSTR_NAME
 *
 * @param searchText The substring to search for. Minimum length of 3 characters.
 * @param maxResults  Maximum number of results to return. If there are more the message
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)findUsersBySubstrName:(NSString *)searchText
                   maxResults:(int)maxResults
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves profile information for the specified Universal Id
 *
 * @param searchText Universal ID text on which to search.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)findUserByExactUniversalId:(NSString *)searchText
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve profile info for the Universal Ids that match starting text
 *
 * Service Name - friend
 * Service Operation - FIND_USERS_BY_UNIVERSAL_ID_STARTING_WITH
 *
 * @param searchText The substring to search for. Minimum length of 3 characters.
 * @param maxResults  Maximum number of results to return. If there are more the message
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)findUsersByUniversalIdStartingWith:(NSString *)searchText
                                maxResults:(int)maxResults
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve profile info for the names that match starting text
 *
 * Service Name - friend
 * Service Operation - FIND_USERS_BY_NAME_STARTING_WITH
 *
 * @param searchText The substring to search for. Minimum length of 3 characters.
 * @param maxResults  Maximum number of results to return. If there are more the message
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)findUsersByNameStartingWith:(NSString *)searchText
                         maxResults:(int)maxResults
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves a list of user and friend platform information for all friends of the current user.
 *
 * Service Name - Friend
 * Service Operation - LIST_FRIENDS
 *
 * @param friendPlatform Friend platform to query.
 * @param includeSummaryData  True if including summary data; false otherwise.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)listFriends:(FriendPlatformObjc *)friendPlatform
      includeSummaryData:(bool)includeSummaryData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Links the current user and the specified users as brainCloud friends.
 *
 * Service Name - Friend
 * Service Operation - ADD_FRIENDS
 *
 * @param profileIds Collection of profile IDs.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)addFriends:(NSArray *)profileIds
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Links the profiles for the specified externalIds for the given friend platform as internal friends.
 *
 * Service Name - Friend
 * Service Operation - ADD_FRIENDS_FROM_PLATFORM
 *
 * @param friendPlatform Platform to add from (i.e: [FriendPlatformObjc Facebook]).
 * @param mode ADD or SYNC
 * @param externalIds Collection of external IDs from the friend platform.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)addFriendsFromPlatform:(FriendPlatformObjc *)friendPlatform
                          mode:(NSString *)mode
                   externalIds:(NSArray *)externalIds
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
 * Unlinks the current user and the specified users as brainCloud friends.
 *
 * Service Name - Friend
 * Service Operation - REMOVE_FRIENDS
 *
 * @param profileIds Collection of profile IDs.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)removeFriends:(NSArray *)profileIds
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Get users online status
 *
 * Service Name - Friend
 * Service Operation - GET_USERS_ONLINE_STATUS
 *
 * @param profileIds Collection of profile IDs.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getUsersOnlineStatus:(NSArray *)profileIds
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

@end
#pragma clang diagnostic pop
