//
//  BrainCloudLobby.h
//  BrainCloud
//
//  Created by Ryan Ruth on 2018-11-06.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudLobby : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Creates a new lobby
 *
 * Service Name - Lobby
 * Service Operation - CREATE_LOBBY
 *
 * @param lobbyType type of lobby to lok for. these types are defined in the portal
 * @param rating the skill rating to use for finiding the lobby. Provided as a separate parameter because it may not exactly match the users rating especially in cases where parties are involved.
 * @param otherUserCxIds
 * @param isReady initial ready status of this user
 * @param extraJson initial extra data about this user
 * @param teamCode preferred team for this user, if applicable, send "" or null for automatic assignment
 * @param settings configuration data for the room
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)createLobby:(NSString *)lobbyType
              rating:(int)rating
      otherUserCxIds:(NSArray *)otherUserCxIds
             isReady:(bool)isReady
           extraJson:(NSString *) extraJson
            teamCode:(NSString *)teamCode
            settings:(NSString *)settings
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Creates a new lobby. Uses attached ping data to resolve best location. GetRegionsForLobbies and PingRegions must be successfully responded to.
 *
 * Service Name - Lobby
 * Service Operation - CREATE_LOBBY
 *
 * @param lobbyType type of lobby to lok for. these types are defined in the portal
 * @param rating the skill rating to use for finiding the lobby. Provided as a separate parameter because it may not exactly match the users rating especially in cases where parties are involved.
 * @param otherUserCxIds
 * @param isReady initial ready status of this user
 * @param extraJson initial extra data about this user
 * @param teamCode preferred team for this user, if applicable, send "" or null for automatic assignment
 * @param settings configuration data for the room
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)createLobbyWithPingData:(NSString *)lobbyType
              rating:(int)rating
      otherUserCxIds:(NSArray *)otherUserCxIds
             isReady:(bool)isReady
           extraJson:(NSString *) extraJson
            teamCode:(NSString *)teamCode
            settings:(NSString *)settings
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Finds a lobby matching the specified parameters. Asynchronous - returns 200 to indicate matchmaking has started.
 *
 * Service Name - Lobby
 * Service Operation - FIND_LOBBY
 *
 * @param lobbyType type of lobby to lok for. these types are defined in the portal
 * @param rating the skill rating to use for finiding the lobby. Provided as a separate parameter because it may not exactly match the users rating especially in cases where parties are involved.
 * @param maxSteps the max number of steps to wait when looking for an applicable lobby. Each step around ~5
 * @param algo the algorithm to use for increasing the search scope
 * @param filterJson used to help filter the list of rooms to consider. Passed to matchmaking filter if configured
 * @param otherUserCxIds Array of other users (party members) to add to the lobby as well. Will constrain things so only lobbies with room for all players is considered.
 * @param isReady initial ready status of this user
 * @param extraJson initial extra data about this user
 * @param teamCode preferred team for this user, if applicable, send "" or null for automatic assignment
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)findLobby:(NSString *)lobbyType
               rating:(int)rating
             maxSteps:(int)maxSteps
                 algo:(NSString *)algo
           filterJson:(NSString *)filterJson
       otherUserCxIds:(NSArray *)otherUserCxIds
              isReady:(bool)isReady
            extraJson:(NSString *) extraJson
             teamCode:(NSString *)teamCode
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Finds a lobby matching the specified parameters. Asynchronous - returns 200 to indicate matchmaking has started. Uses attached ping data to resolve best location. GetRegionsForLobbies and PingRegions must be successfully responded to.
 *
 * Service Name - Lobby
 * Service Operation - FIND_LOBBY
 *
 * @param lobbyType type of lobby to lok for. these types are defined in the portal
 * @param rating the skill rating to use for finiding the lobby. Provided as a separate parameter because it may not exactly match the users rating especially in cases where parties are involved.
 * @param maxSteps the max number of steps to wait when looking for an applicable lobby. Each step around ~5
 * @param algo the algorithm to use for increasing the search scope
 * @param filterJson used to help filter the list of rooms to consider. Passed to matchmaking filter if configured
 * @param otherUserCxIds Array of other users (party members) to add to the lobby as well. Will constrain things so only lobbies with room for all players is considered.
 * @param isReady initial ready status of this user
 * @param extraJson initial extra data about this user
 * @param teamCode preferred team for this user, if applicable, send "" or null for automatic assignment
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)findLobbyWithPingData:(NSString *)lobbyType
               rating:(int)rating
             maxSteps:(int)maxSteps
                 algo:(NSString *)algo
           filterJson:(NSString *)filterJson
       otherUserCxIds:(NSArray *)otherUserCxIds
              isReady:(bool)isReady
            extraJson:(NSString *) extraJson
             teamCode:(NSString *)teamCode
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Adds a user to the lobby entry queue and will create a lobby if none are found
 *
 * Service Name - Lobby
 * Service Operation - FIND_OR_CREATE_LOBBY
 *
 * @param lobbyType type of lobby to lok for. these types are defined in the portal
 * @param rating the skill rating to use for finiding the lobby. Provided as a separate parameter because it may not exactly match the users rating especially in cases where parties are involved.
 * @param maxSteps the max number of steps to wait when looking for an applicable lobby. Each step around ~5
 * @param algo the algorithm to use for increasing the search scope
 * @param filterJson used to help filter the list of rooms to consider. Passed to matchmaking filter if configured
 * @param otherUserCxIds Array of other users (party members) to add to the lobby as well. Will constrain things so only lobbies with room for all players is considered.
 * @param isReady initial ready status of this user
 * @param extraJson initial extra data about this user
 * @param teamCode preferred team for this user, if applicable, send "" or null for automatic assignment
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)findOrCreateLobby:(NSString *)lobbyType
                  rating:(int)rating
                maxSteps:(int)maxSteps
                    algo:(NSString *)algo
              filterJson:(NSString *)filterJson
          otherUserCxIds:(NSArray *)otherUserCxIds
                 isReady:(bool)isReady
               extraJson:(NSString *) extraJson
                teamCode:(NSString *)teamCode
                settings:(NSString *)settings
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Adds a user to the lobby entry queue and will create a lobby if none are found. Uses attached ping data to resolve best location. GetRegionsForLobbies and PingRegions must be successfully responded to.
 *
 * Service Name - Lobby
 * Service Operation - FIND_OR_CREATE_LOBBY
 *
 * @param lobbyType type of lobby to lok for. these types are defined in the portal
 * @param rating the skill rating to use for finiding the lobby. Provided as a separate parameter because it may not exactly match the users rating especially in cases where parties are involved.
 * @param maxSteps the max number of steps to wait when looking for an applicable lobby. Each step around ~5
 * @param algo the algorithm to use for increasing the search scope
 * @param filterJson used to help filter the list of rooms to consider. Passed to matchmaking filter if configured
 * @param otherUserCxIds Array of other users (party members) to add to the lobby as well. Will constrain things so only lobbies with room for all players is considered.
 * @param isReady initial ready status of this user
 * @param extraJson initial extra data about this user
 * @param teamCode preferred team for this user, if applicable, send "" or null for automatic assignment
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)findOrCreateLobbyWithPingData:(NSString *)lobbyType
                  rating:(int)rating
                maxSteps:(int)maxSteps
                    algo:(NSString *)algo
              filterJson:(NSString *)filterJson
          otherUserCxIds:(NSArray *)otherUserCxIds
                 isReady:(bool)isReady
               extraJson:(NSString *) extraJson
                teamCode:(NSString *)teamCode
                settings:(NSString *)settings
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Returns the data for the specified lobby, including member data
 *
 * Service Name - Lobby
 * Service Operation - GET_LOBBY_DATA
 *
 * @param lobbyId the id of chosen lobby
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getLobbyData:(NSString *)lobbyId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Causes caller to leave the specified lobby. If the user was the owner a new owner will be chosen. If the user was the last member the lobby will be deleted
 *
 * Service Name - Lobby
 * Service Operation - LEAVE_LOBBY
 *
 * @param lobbyId is the id of chosen lobby
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)leaveLobby:(NSString *)lobbyId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Causes caller to join the specified lobby.
 *
 * Service Name - Lobby
 * Service Operation - JOIN_LOBBY
 *
 * @param lobbyId is the id of chosen lobby
 * @param isReady ready status of user
 * @param extreJson extra data about user
 * @param teamCode
 * @param otherUserCxIds array of other users
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)joinLobby:(NSString *)lobbyId
             isReady:(bool)isReady
           extraJson:(NSString *)extraJson
            teamCode:(NSString *)teamCode
      otherUserCxIds:(NSArray *)otherUserCxIds
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the channel Id for the given <channelType> and <channelSubId> Channel type must be one of "gl" or "gr"
 *
 * Service Name - Lobby
 * Service Operation - REMOVE_MEMBER
 *
 * @param lobbyId id of chosen lobby
 * @param cxId specified memebr to be removed from lobby.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)removeMember:(NSString *)lobbyId
                cxId:(NSString *)cxId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Gets description info and activity stats for channel <channelId>
 * Note that numMsgs and listeners only returned for non-global groups
 * Only callable for channels the user is a member of
 *
 * Service Name - LOBBY
 * Service Operation - SEND_SIGNAL
 *
 * @param lobbyId the lobby id
 * @param signalData signal data to be sent
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)sendSignal:(NSString *)lobbyId
            signalData:(NSString *)signalData
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * switches to the specified team(if allowed)
 *
 * Service Name - Lobby
 * Service Operation - SWITCH_TEAM
 *
 * @param lobbyId id of chosen lobby
 * @param toTeamCode specified team code
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)switchTeam:(NSString *)lobbyId
              teamCode:(NSString *)toTeamCode
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Updates the ready status and extraJson for the given lobby member
 *
 * Service Name - LOBBY
 * Service Operation - UPDATE_READY
 *
 * @param lobbyId the lobby id
 * @param isReady ready status of the user
 * @param extraJson extra data about the user
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateReady:(NSString *)lobbyId
             isReady:(bool)isReady
           extraJson:(NSString *)extraJson
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Updates the ready status and extra Json for the given lobby member
 *
 * Service Name - Lobby
 * Service Operation - UPDATE_SETTINGS
 *
 * @param lobbyId the id of the lobby
 * @param settings configuration data for the room
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateSettings:(NSString *)lobbyId
              settings:(NSString *)settings
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Gets a map keyed by rating of the visible lobby instances matching the given type and rating range.
 *
 * Service Name - Lobby
 * Service Operation - GET_LOBBY_INSTANCES
 *
 * @param lobbyType The type of lobby to look for
 * @param criteriaJson A JSON string used to describe filter criteria.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getLobbyInstances:(NSString *)lobbyType
                    criteriaJson:(NSString *)criteriaJson
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
 * Gets a map keyed by rating of the visible lobby instances matching the given type and rating range.
 * Only lobby instances in the regions that satisfy the ping portion of the criteriaJson (based on the values provided in pingData) will be returned.
 *
 * Service Name - Lobby
 * Service Operation - GET_LOBBY_INSTANCES_WITH_PING_DATA
 *
 * @param lobbyType The type of lobby to look for
 * @param criteriaJson A JSON string used to describe filter criteria.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getLobbyInstancesWithPingData:(NSString *)lobbyType
                    criteriaJson:(NSString *)criteriaJson
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;


/* Retrieves the region settings for each of the given lobby types. Upon success or afterwards, call pingRegions to start retrieving appropriate data.
*
* Service Name - Lobby
* Service Operation - GetRegionsForLobbies
*
* @param roomTypes Ids of the lobby types.
*/
- (void)getRegionsForLobbies:(NSArray *)roomTypes
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/* Retrieves associated Ping Data averages to be used with all associated <>WithPingData APIs.
* Call anytime after GetRegionsForLobbies before proceeding.
* Once that completes, the associated region Ping Data is retrievable via getPingData and all associated <>WithPingData APIs are useable
*/
- (void)pingRegions:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

//Cancels this members find, join and search for lobbies
//available when rtt is supported.
//- (void)cancelFindRequest:(NSString *)lobbyId
//                     cxId:(NSString *)cxId
//          completionBlock:(BCCompletionBlock)cb
//     errorCompletionBlock:(BCErrorCompletionBlock)ecb
//                 cbObject:(BCCallbackObject)cbObject;

@end


#pragma clang diagnostic pop
