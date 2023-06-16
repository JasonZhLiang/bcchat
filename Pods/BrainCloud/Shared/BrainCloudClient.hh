//
//  BrainCloudClient.hh
//  brainCloudClientObjc
//
//  Created by Ryan Homer on 7/4/2015.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudAsyncMatch.hh"
#import "BrainCloudAuthentication.hh"
#import "BrainCloudDataStream.hh"
#import "BrainCloudEntity.hh"
#import "BrainCloudEvent.hh"
#import "BrainCloudFile.hh"
#import "BrainCloudGlobalFile.hh"
#import "BrainCloudBlockchain.hh"
#import "BrainCloudFriend.hh"
#import "BrainCloudGamification.hh"
#import "BrainCloudGlobalApp.hh"
#import "BrainCloudGlobalEntity.hh"
#import "BrainCloudGlobalStatistics.hh"
#import "BrainCloudGroup.hh"
#import "BrainCloudGroupFile.hh"
#import "BrainCloudIdentity.hh"
#import "BrainCloudLeaderboard.hh"
#import "BrainCloudMail.hh"
#import "BrainCloudMessaging.hh"
#import "BrainCloudLobby.hh"
#import "BrainCloudChat.hh"
#import "BrainCloudMatchMaking.hh"
#import "BrainCloudOneWayMatch.hh"
#import "BrainCloudPlaybackStream.hh"
#import "BrainCloudPlayerState.hh"
#import "BrainCloudPlayerStatistics.hh"
#import "BrainCloudPlayerStatisticsEvent.hh"
#import "BrainCloudProfanity.hh"
#import "BrainCloudPushNotification.hh"
#import "BrainCloudRedemptionCode.hh"
#import "BrainCloudRelay.hh"
#import "BrainCloudRTT.hh"
#import "BrainCloudS3Handling.hh"
#import "BrainCloudScript.hh"
#import "BrainCloudTime.hh"
#import "BrainCloudTournament.hh"
#import "BrainCloudCustomEntity.hh"
#import "BrainCloudUserItems.hh"
#import "BrainCloudItemCatalog.hh"
#import "BrainCloudPresence.hh"
#import "BrainCloudVirtualCurrency.hh"
#import "BrainCloudAppStore.hh"
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BCBrainCloudUpdateType)
{
     BC_UPDATE_TYPE_ALL,
     BC_UPDATE_TYPE_REST,   // REST Api calls
     BC_UPDATE_TYPE_RTT,    // Real-time tech
     BC_UPDATE_TYPE_RS,     // Relay server
     BC_UPDATE_TYPE_PING    // Lobby Pings
};

/**
* This class is responsible for accumulating client requests, bundling
* them together and sending them off to the server...
*
* This class uses the ServerCall class to communicate with the server.
* Retrieve all outstanding calls, send them to the server, and callback
* any registered callbacks.
*
* The BrainCloudClient will have only one HTTP connection to a app server at a
* time (to make sure that data doesn't arrive out of order, and to make
* recovery of communication problems more simple).
*
*/
@interface BrainCloudClient : NSObject

/**
 * BrainCloudClient is a singleton object. This method gives the caller access
 * to the singleton object in order to use the class.
 *
 * @return BrainCloudClient * - pointer to the singleton BrainCloudClient object
 *
 * @deprecated Use of the *singleton* has been deprecated. We recommend that you create your own *variable* to hold an instance of the brainCloudWrapper. Explanation here: http://getbraincloud.com/apidocs/wrappers-clients-and-inconvenient-singletons/
 */
+ (BrainCloudClient *)getInstance;

/**
 * Internal method used by the brainCloud client to set the instance.
 *
 * @param BrainCloudClient * - pointer to the singleton BrainCloudClient object
 *
 * @deprecated Use of the *singleton* has been deprecated. We recommend that you create your own *variable* to hold an instance of the brainCloudWrapper. Explanation here: http://getbraincloud.com/apidocs/wrappers-clients-and-inconvenient-singletons/
 */
+ (void)setInstance: (BrainCloudClient *) instance;

/**
 * Disabling Singleton mode will ensure an error is thrown if the brainCloud Singleton is used
 *
 * @param state of singleton mode
 */
+ (void) setEnableSingletonMode: (bool) state;

/**
 * @return state of singleton mode
 */
+ (bool) getEnableSingletonMode;

/**
 * Initializes the brainCloud Client
 */
- (instancetype) init;

/**
 * Get a void pointer to the C++ brainCloud Client
 */
- (void *) getInternalClient;

/**
 * Call this method before initialize to disable the internal timer.
 * Once the timer is disabled, the brainCloud runCallbacks method will need to
 * be invoked manually to read/write from/to the network.
 */
- (void)disableInternalTimer;

/**
* Method initializes the BrainCloudClient.
*
* @param serverURL The url to the brainCloud server
* @param secretKey The secret key for your app
* @param appId The app id
* @param appVersion The version
*/

- (void)initialize:(NSString *)serverURL
         secretKey:(NSString *)secretKey
             appId:(NSString *)appId
        appVersion:(NSString *)appVersion;

/**
 * Method initializes the BrainCloudClient. Automatically uses  current serverURL
 * https://sharedprod.braincloudservers.com/dispatcherv2
 *
 * @param secretKey The secret key for your app
 * @param appId The app id
 * @param appVersion The version
 */

- (void)initialize:(NSString *)secretKey
             appId:(NSString *)appId
        appVersion:(NSString *)appVersion;

/**
* Method initializes the BrainCloudClient with a map of appid->secretkey
*
* @param serverURL The url to the brainCloud server
* @param defaultAppId The default app id to start with
* @param secretMap All app ids to secret keys used by this application
* @param appVersion The version
*/

- (void)initializeWithApps:(NSString *)serverURL
              defaultAppId:(NSString *)defaultAppId
                 secretMap:(NSDictionary *)secretMap
                appVersion:(NSString *)appVersion;

/**
 * Method initializes the BrainCloudClient with a map of appid->secretkey
 * Automatically uses current serverURL https://sharedprod.braincloudservers.com/dispatcherv2
 *
 * @param defaultAppId The default app id to start with
 * @param secretMap All app ids to secret keys used by this application
 * @param appVersion The version
 */

- (void)initializeWithApps:(NSString *)defaultAppId
                 secretMap:(NSDictionary *)secretMap
                appVersion:(NSString *)appVersion;

/**
* Initialize - initializes the identity service with the saved
* anonymous installation id and most recently used profile id
*
* @param anonymousId The anonymous installation id that was generated for this device
* @param profileId The profile id that was most recently used by the app (on this device)
*/
- (void)initializeIdentity:(NSString *)profileId anonymousId:(NSString *)anonymousId;

/**
 * Enables/disables the internal logging
 *
 * @param shouldEnable True if logging should be enabled, false otherwise.
 */
- (void)enableLogging:(bool)shouldEnable;

/**
 * Returns whether the client is initialized.
 * @return True if initialized, false otherwise.
 */
- (bool)isInitialized;

/**
 * Returns whether the client is authenticated with the brainCloud server.
 * @return True if authenticated, false otherwise.
 */
- (bool)isAuthenticated;

/**
 * Returns the list of packet timeouts.
 */
- (NSArray *)getPacketTimeouts;

/**
 * Sets the packet timeouts using a list of integers that
 * represent timeout values in seconds for each packet retry. The
 * first item in the list represents the timeout for the first packet
 * attempt, the second for the second packet attempt, and so on.
 *
 * The number of entries in this array determines how many packet
 * retries will occur.
 *
 * By default, the packet timeout array is {10, 10, 10}
 *
 * @param timeouts An array of packet timeouts.
 */
- (void)setPacketTimeouts:(NSArray *)timeouts;

/**
 * Sets the packet timeouts back to the default ie {10, 10, 10}
 */
- (void)setPacketTimeoutsToDefault;

/**
 * Gets the authentication packet timeout which is tracked separately
 * from all other packets. Note that authentication packets are never
 * retried and so this value represents the total time a client would
 * wait to receive a reply to an authentication api call. By default
 * this timeout is set to 15 seconds.
 *
 * @return The timeout in seconds
 */
- (int)getAuthenticationPacketTimeout;

/**
 * Sets the authentication packet timeout which is tracked separately
 * from all other packets. Note that authentication packets are never
 * retried and so this value represents the total time a client would
 * wait to receive a reply to an authentication api call. By default
 * this timeout is set to 15 seconds.
 *
 * @param timeoutSecs The timeout in seconds
 */
- (void)setAuthenticationPacketTimeout:(int)timeoutSecs;

/**
 * Sets the error callback to return the status message instead of the
 * error json string. This flag is used to conform to pre-2.17 client
 * behaviour.
 *
 * @param enabled If set to true, enable
 */
- (void)setOldStyleStatusMessageErrorCallback:(bool)enabled;

/**
 * Sets whether the error callback is triggered when a 202 status
 * is received from the server. By default this is true and should
 * only be set to false for backward compatibility.
 *
 * @param in_isError If set to true, 202 is treated as an error
 */
- (void)setErrorCallbackOn202Status:(bool)isError;

/**
* THIH METHOD IS FOR DEBUGGING USE ONLY
* Hearbeat interval is automatically set based on the session timeout setting
* in the brainCloud portal.
*
* @param intervalInMilliseconds The time between heartbeats in milliseconds
*/
- (void)setHeartbeatInterval:(int)intervalInMilliseconds;

/**
* Clears any pending messages from communication library.
*/
- (void)resetCommunication;

/**
 * Sets a callback handler for any out of band event messages that come from
 * brainCloud.
 *
 * @param ecb A completion block which takes a json string as it's only parameter.
 * The json format looks like the following:
 * {
 *   "events": [{
 *      "fromPlayerId": "178ed06a-d575-4591-8970-e23a5d35f9df",
 *      "eventId": 3967,
 *      "createdAt": 1441742105908,
 *      "gameId": "123",
 *      "toPlayerId": "178ed06a-d575-4591-8970-e23a5d35f9df",
 *      "eventType": "test",
 *      "eventData": {"testData": 117}
 *    }],
 *    ]
 *  }
 */
- (void)registerEventCallback:(BCEventCompletionBlock)ecb;

/**
 * Deregisters the event callback
 */
- (void)deregisterEventCallback;

/**
 * Sets a callback handler for any out of band event messages that come from
 * brainCloud.
 *
 * @param completedBlock A completion block run when a file is successfully uploaded
 * @param failedBlock A completion block run when a file fails to upload
 */
- (void)registerFileUploadCallback:(BCFileUploadCompletedCompletionBlock)completedBlock
                       failedBlock:(BCFileUploadFailedCompletionBlock)failedBlock;

/**
 * Deregisters the event callback
 */
- (void)deregisterFileUploadCallback;

/**
 * Sets a reward handler for any api call results that return rewards.
 *
 * @param rcb The reward callback handler.
 * @see The brainCloud apidocs site for more information on the return JSON
 */
- (void)registerRewardCallback:(BCRewardCompletionBlock)rcb;

/**
 * Deregisters the reward callback
 */
- (void)deregisterRewardCallback;

/**
 * Registers a callback that is invloked for all errors generated
 *
 * @param ecb The global error callback handler.
 */
- (void)registerGlobalErrorCallback:(BCErrorCompletionBlock)ecb;

/**
 * Deregisters the global error callback
 */
- (void)deregisterGlobalErrorCallback;

/**
 * Registers a callback that is invloked for network errors.
 * Note this is only called if enableNetworkErrorMessageCaching
 * has been set to true.
 *
 * @param ecb The network error callback handler.
 */
- (void)registerNetworkErrorCallback:(BCNetworkErrorCompletionBlock)ecb;

/**
 * Deregisters the network error callback
 */
- (void)deregisterNetworkErrorCallback;

/**
* Run callbacks, to be called once per frame from your main thread
*/
- (void)runCallBacks;
- (void)runCallBacks:(BCBrainCloudUpdateType)updateType;

/**
 * Returns the low transfer rate timeout in secs
 *
 * @returns The low transfer rate timeout in secs
 */
- (int)getUploadLowTransferRateTimeout;

/**
 * Sets the timeout in seconds of a low speed upload
 * (ie transfer rate which is underneath the low transfer rate threshold).
 * By default this is set to 120 secs. Setting this value to 0 will
 * turn off the timeout.
 *
 * @param in_timeoutSecs The timeout in secs
 */
- (void)setUploadLowTransferRateTimeout:(int)in_timeoutSecs;

/**
 * Returns the low transfer rate threshold in bytes/sec
 *
 * @returns The low transfer rate threshold in bytes/sec
 */
- (int)getUploadLowTransferRateThreshold;

/**
 * Sets the low transfer rate threshold of an upload in bytes/sec.
 * If the transfer rate dips below the given threshold longer
 * than the specified timeout, the transfer will fail.
 * By default this is set to 50 bytes/sec. Note that this setting
 * only works on platforms that use libcurl (non-windows and win32 but
 * not windows store or phone apps).
 *
 * @param in_bytesPerSec The low transfer rate threshold in bytes/sec
 */
- (void)setUploadLowTransferRateThreshold:(int)in_bytesPerSec;

/**
 * Enables the message caching upon network error, which is disabled by default.
 * Once enabled, if a client side network error is encountered
 * (i.e. brainCloud server is unreachable presumably due to the client
 * network being down) the sdk will do the following:
 *
 * 1 - cache the currently queued messages to brainCloud
 * 2 - call the network error callback
 * 3 - then expect the app to call either:
 *     a) retryCachedMessages() to retry sending to brainCloud
 *     b) flushCachedMessages() to dump all messages in the queue.
 *
 * Between steps 2 & 3, the app can prompt the user to retry connecting
 * to brainCloud to determine whether to follow path 3a or 3b.
 *
 * Note that if path 3a is followed, and another network error is encountered,
 * the process will begin all over again from step 1.
 *
 * WARNING - the brainCloud sdk will cache *all* api calls sent
 * when a network error is encountered if this mechanism is enabled.
 * This effectively freezes all communication with brainCloud.
 * Apps must call either retryCachedMessages() or flushCachedMessages()
 * for the brainCloud SDK to resume sending messages.
 * resetCommunication() will also clear the message cache.
 *
 * @param in_enabled True if message should be cached on timeout
 */
- (void)enableNetworkErrorMessageCaching:(bool)in_enabled;

/** Attempts to resend any cached messages. If no messages are in the cache,
 * this method does nothing.
 */
- (void)retryCachedMessages;

/**
 * Flushes the cached messages to resume api call processing. This will dump
 * all of the cached messages in the queue.
 *
 * @param in_sendApiErrorCallbacks If set to true API error callbacks will
 * be called for every cached message with statusCode CLIENT_NETWORK_ERROR
 * and reasonCode CLIENT_NETWORK_ERROR_TIMEOUT.
 */
- (void)flushCachedMessages:(bool)in_sendApiErrorCallbacks;

/**
 * Inserts a marker which will tell the brainCloud comms layer
 * to close the message bundle off at this point. Any messages queued
 * before this method was called will likely be bundled together in
 * the next send to the server.
 *
 * To ensure that only a single message is sent to the server you would
 * do something like this:
 *
 * InsertEndOfMessageBundleMarker()
 * SomeApiCall()
 * InsertEndOfMessageBundleMarker()
 *
 */
- (void)insertEndOfMessageBundleMarker;

/**
 * Sets the country code sent to brainCloud when a user authenticates.
 * Will override any auto detected country.
 * @param countryCode ISO 3166-1 two-letter country code
 */
- (void)overrideCountryCode:(NSString *)countryCode;

/**
 * Sets the language code sent to brainCloud when a user authenticates.
 * If the language is set to a non-ISO 639-1 standard value the app default will be used instead.
 * Will override any auto detected language.
 * @param languageCode ISO 639-1 two-letter language code
 */
- (void)overrideLanguageCode:(NSString *)languageCode;

@property(readonly) const char *sessionId;
@property(readonly) BrainCloudAuthentication *authenticationService;
@property(readonly) BrainCloudScript *scriptService;
@property(readonly) BrainCloudPushNotification *pushNotificationService;
@property(readonly) BrainCloudPlayerState *playerStateService;
@property(readonly) BrainCloudPlayerStatistics *playerStatisticsService;
@property(readonly) BrainCloudGlobalStatistics *globalStatisticsService;
@property(readonly) BrainCloudEntity *entityService;
@property(readonly) BrainCloudGlobalEntity *globalEntityService;
@property(readonly) BrainCloudLeaderboard *leaderboardService;
@property(readonly) BrainCloudGlobalApp *globalAppService;
@property(readonly) BrainCloudFriend *friendService;
@property(readonly) BrainCloudBlockchain *blockchainService;
@property(readonly) BrainCloudMail *mailService;
@property(readonly) BrainCloudMessaging *messagingService;
@property(readonly) BrainCloudLobby *lobbyService;
@property(readonly) BrainCloudRelay *relayService;
@property(readonly) BrainCloudRTT *rttService;
@property(readonly) BrainCloudChat *chatService;
@property(readonly) BrainCloudMatchMaking *matchMakingService;
@property(readonly) BrainCloudAsyncMatch *asyncMatchService;
@property(readonly) BrainCloudOneWayMatch *oneWayMatchService;
@property(readonly) BrainCloudPlaybackStream *playbackStreamService;
@property(readonly) BrainCloudGamification *gamificationService;
@property(readonly) BrainCloudEvent *eventService;
@property(readonly) BrainCloudPlayerStatisticsEvent *playerStatisticsEventService;
@property(readonly) BrainCloudTime *timeService;
@property(readonly) BrainCloudTournament *tournamentService;
@property(readonly) BrainCloudCustomEntity *customEntityService;
@property(readonly) BrainCloudUserItems *userItemsService;
@property(readonly) BrainCloudItemCatalog *itemCatalogService;
@property(readonly) BrainCloudPresence *presenceService;
@property(readonly) BrainCloudVirtualCurrency *virtualCurrencyService;
@property(readonly) BrainCloudAppStore *appStoreService;
@property(readonly) BrainCloudS3Handling *s3HandlingService;
@property(readonly) BrainCloudIdentity *identityService;
@property(readonly) BrainCloudRedemptionCode *redemptionCodeService;
@property(readonly) BrainCloudDataStream *dataStreamService;
@property(readonly) BrainCloudProfanity *profanityService;
@property(readonly) BrainCloudFile *fileService;
@property(readonly) BrainCloudGlobalFile *globalFileService;
@property(readonly) BrainCloudGroup *groupService;
@property(readonly) BrainCloudGroupFile *groupFileService;
@property NSInteger frameInterval;

@end

#pragma clang diagnostic pop
