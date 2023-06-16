//
//  BrainCloudAuthentication.hh
//  brainCloudClientObjc
//
//  Created by Ryan Homer on 8/4/2015.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"
#import "AuthenticationIdsObjc.hh"
#import "AuthenticationTypeObjc.hh"

@class BrainCloudClient;

extern NSString *const AUTH_FACEBOOK;

@interface BrainCloudAuthentication : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

@property(strong, nonatomic) NSString *anonymousID;
@property(strong, nonatomic) NSString *profileID;

// NOT an Objective-C designated initializer
/**
* Initialize - initializes the identity service with the saved
* anonymous installation id and most recently used profile id
*
* @param anonymousId  The anonymous installation id that was generated for this device
* @param profileId The id of the profile id that was most recently used by the app (on this device)
*/
- (void)initialize:(NSString *)profileID anonymousID:(NSString *)anonymousID;

/**
 * Used to create the anonymous installation id for the brainCloud profile.
 * @returns A unique Anonymous ID
 */
- (NSString *)generateAnonymousId;

/**
* Used to clear the saved profile id - to use in cases when the user is
* attempting to switch to a different app profile.
*/
- (void)clearSavedProfile;

/**
* Authenticate a user anonymously with brainCloud - used for apps that don't want to bother
* the user to login, or for users who are sensitive to their privacy
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param forceCreate  Should a new profile be created if it does not exist?
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*
*/
- (void)authenticateAnonymous:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject;

/**
* Authenticate the user with brainCloud using their Facebook Credentials
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param externalId The facebook id of the user
* @param authenticationToken The validated token from the Facebook SDK
*   (that will be further validated when sent to the bC service)
* @param forceCreate Should a new profile be created for this user if the account does not exist?
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*
*/
- (void)authenticateFacebook:(NSString *)externalID
         authenticationToken:(NSString *)authToken
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject;

/**
* Authenticate the user using their Game Center id
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param gameCenterId The player's game center id  (use the playerID property from the local GKPlayer object)
* @param forceCreate Should a new profile be created for this user if the account does not exist?
* @param success The method to call in event of successful login
* @param failure The method to call in the event of an error during authentication
*/
- (void)authenticateGameCenter:(NSString *)gameCenterID
                   forceCreate:(BOOL)forceCreate
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                      cbObject:(BCCallbackObject)cbObject;

/**
* Authenticate the user with a custom Email and Password.  Note that the client app
* is responsible for collecting (and storing) the e-mail and potentially password
* (for convenience) in the client data.  For the greatest security,
* force the user to re-enter their * password at each login.
* (Or at least give them that option).
*
* Note that the password sent from the client to the server is protected via SSL.
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param email  The e-mail address of the user
* @param password  The password of the user
* @param forceCreate Should a new profile be created for this user if the account does not exist?
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*
*/
- (void)authenticateEmailPassword:(NSString *)email
                         password:(NSString *)password
                      forceCreate:(BOOL)forceCreate
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                         cbObject:(BCCallbackObject)cbObject;

/**
* Authenticate the user using a userid and password (without any validation on the userid).
* Similar to AuthenticateEmailPassword - except that that method has additional features to
* allow for e-mail validation, password resets, etc.
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param email  The e-mail address of the user
* @param password  The password of the user
* @param forceCreate Should a new profile be created for this user if the account does not exist?
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*
*/
- (void)authenticateUniversal:(NSString *)userid
                     password:(NSString *)password
                  forceCreate:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject;


/**
* A generic Authenticate method that translates to the same as calling a specific one, except it takes an extraJson
* that will be passed along to pre- or post- hooks.
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param authenticationType Universal, Email, Facebook, etc
* @param ids Auth IDs structure
* @param forceCreate Should a new profile be created for this user if the account does not exist?
* @param extraJson Additional to piggyback along with the call, to be picked up by pre- or post- hooks. Leave empty string for no extraJson.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)authenticateAdvanced:(AuthenticationTypeObjc *)authenticationType
           authenticationIds:(AuthenticationIdsObjc *)authenticationIds
                 forceCreate:(BOOL)forceCreate
                   extraJson:(NSString *)extraJson
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user for Ultra.
 *
 * Service Name - Authenticate
 * Server Operation - Authenticate
 *
 * @param ultraUsername it's what the user uses to log into the Ultra endpoint initially
 * @param ultraIdToken The "id_token" taken from Ultra's JWT.
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)authenticateUltra:(NSString *)ultraUsername
             ultraIdToken:(NSString *)ultraIdToken
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject;

/**
* Authenticate the user using a steam userid and session ticket (without any validation on the userid).
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param userid  String representation of 64 bit steam id
* @param sessionticket  The session ticket of the user (hex encoded)
* @param forceCreate Should a new profile be created for this user if the account does not exist?
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)authenticateSteam:(NSString *)userID
            sessionTicket:(NSString *)sessionticket
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user using a google userid(email address) and google authentication token.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param appleUserId  this can be the userId or the email for the user of this account.
 * @param identityToken  the token confirming the users identity
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)authenticateApple:(NSString *)appleUserId
            identityToken:(NSString *)identityToken
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject;

/**
* Authenticate the user using a google userid(email address) and google authentication token.
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param googleUserId  String representation of google userId. Gotten with calls like requestUserId
* @param serverAuthCode  The server suth code derived via the google apis. Calls like RequestServerAuthCode
* @param forceCreate Should a new profile be created for this user if the account does not exist?
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)authenticateGoogle:(NSString *)googleUserId
            serverAuthCode:(NSString *)serverAuthCode
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user using a google openId
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param googleUserAccountEmail  The email associated with the google user
 * @param idToken  The account idToken. Gotten with calls like requestIdToken
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)authenticateGoogleOpenId:(NSString *)googleUserAccountEmail
                         idToken:(NSString *)idToken
                     forceCreate:(BOOL)forceCreate
                 completionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject;


/**
* Authenticate the user using a Twitter userid, authentication token, and secret from Twitter.
*
* Service Name - Authenticate
* Service Operation - Authenticate
*
* @param userid  String representation of Twitter userid
* @param token  The authentication token derived via the Twitter apis.
* @param secret  The secret given when attempting to link with Twitter
* @param forceCreate Should a new profile be created for this user if the account does not exist?
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)authenticateTwitter:(NSString *)userID
                      token:(NSString *)token
                     secret:(NSString *)secret
                forceCreate:(BOOL)forceCreate
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/*
 * Authenticate the user using a Pase userid and authentication token
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param userId String representation of Parse userid
 * @param token The authentication token
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)authenticateParse:(NSString *)userID
                    token:(NSString *)token
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/*
 * Authenticate the user using a handoffId and authentication token
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param handoffId
 * @param securityToken The authentication token
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)authenticateHandoff:(NSString *)handoffId
              securityToken:(NSString *)securityToken
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/*
 * Authenticate the user with a handoffCode
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param handoffCode
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)authenticateSettopHandoff:(NSString *)handoffCode
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
* Reset Email password - Sends a password reset email to the specified address
*
* Service Name - Authenticate
* Operation - ResetEmailPassword
*
* @param externalId The email address to send the reset email to.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*
* Note the follow error reason codes:
* SECURITY_ERROR (40209) - If the email address cannot be found.
*/
- (void)resetEmailPassword:(NSString *)email
       withCompletionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Reset Email password with service parameters - Sends a password reset email to the specified address
 *
 * Service Name - Authenticate
 * Operation - ResetEmailPasswordAdvanced
 *
 * @param appId the application Id
 * @param externalId The email address to send the reset email to.
 * @param serviceParams parameters to send to the email service. See the doc for
 * a full list http:/getbraincloud.com/apidocs/apiref/#capi-mail
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * Note the follow error reason codes:
 * SECURITY_ERROR (40209) - If the email address cannot be found.
 */
- (void)resetEmailPasswordAdvanced:(NSString *)email
                     serviceParams:(NSString *)serviceParams
               withCompletionBlock:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                          cbObject:(BCCallbackObject)cbObject;

/**
* Reset Email password with Expiry - Sends a password reset email to the specified address
*
* Service Name - Authenticate
* Operation - ResetEmailPasswordWithExpiry
*
* @param externalId The email address to send the reset email to.
* @param tokenTtlInMinutes the tokery value
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*
* Note the follow error reason codes:
* SECURITY_ERROR (40209) - If the email address cannot be found.
*/
- (void)resetEmailPasswordWithExpiry:(NSString *)email
         tokenTtlInMinutes:(int)tokenTtlInMinutes
       withCompletionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Reset Email password with service parameters - Sends a password reset email to the specified address
 *
 * Service Name - Authenticate
 * Operation - ResetEmailPasswordAdvancedWithExpiry
 *
 * @param appId the application Id
 * @param externalId The email address to send the reset email to.
 * @param serviceParams parameters to send to the email service. See the doc for
 * a full list http:/getbraincloud.com/apidocs/apiref/#capi-mail
 * @param tokenTtlInMinutes the tokery value
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * Note the follow error reason codes:
 * SECURITY_ERROR (40209) - If the email address cannot be found.
 */
- (void)resetEmailPasswordAdvancedWithExpiry:(NSString *)email
                     serviceParams:(NSString *)serviceParams
                 tokenTtlInMinutes:(int)tokenTtlInMinutes
               withCompletionBlock:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                          cbObject:(BCCallbackObject)cbObject;

/**
 * Reset UniversalId password
 *
 * Service Name - Authenticate
 * Operation - ResetUniversalIdPassword
 *
 * @param universalId The email address to send the reset email to.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 */
- (void)resetUniversalIdPassword:(NSString *)universalId
             withCompletionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject;

/**
 * Reset UniversalId password with template options
 *
 * Service Name - Authenticate
 * Operation - ResetUniversalIdPasswordAdvanced
 *
 * @param appId the application Id
 * @param universalId The universalId who's password you want to change.
 * @param serviceParams parameters to send to the email service. See the doc for
 * a full list http:/getbraincloud.com/apidocs/apiref/#capi-mail
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * Note the follow error reason codes:
 * SECURITY_ERROR (40209) - If the email address cannot be found.
 */
- (void)resetUniversalIdPasswordAdvanced:(NSString *)universalId
                           serviceParams:(NSString *)serviceParams
                     withCompletionBlock:(BCCompletionBlock)completionBlock
                    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                cbObject:(BCCallbackObject)cbObject;
/**
 * Reset UniversalId password
 *
 * Service Name - Authenticate
 * Operation - ResetUniversalIdPassword
 *
 * @param universalId The email address to send the reset email to.
 * @param tokenTtlInMinutes the tokery value
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 */
- (void)resetUniversalIdPasswordWithExpiry:(NSString *)universalId
               tokenTtlInMinutes:(int)tokenTtlInMinutes
             withCompletionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject;

/**
 * Reset UniversalId password with template options
 *
 * Service Name - Authenticate
 * Operation - ResetUniversalIdPasswordAdvanced
 *
 * @param appId the application Id
 * @param universalId The universalId who's password you want to change.
 * @param serviceParams parameters to send to the email service. See the doc for
 * a full list http:/getbraincloud.com/apidocs/apiref/#capi-mail
 * @param tokenTtlInMinutes the tokery value
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * Note the follow error reason codes:
 * SECURITY_ERROR (40209) - If the email address cannot be found.
 */
- (void)resetUniversalIdPasswordAdvancedWithExpiry:(NSString *)universalId
                           serviceParams:(NSString *)serviceParams
                       tokenTtlInMinutes:(int)tokenTtlInMinutes
                     withCompletionBlock:(BCCompletionBlock)completionBlock
                    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                cbObject:(BCCallbackObject)cbObject;


/**
* Authenticate the user via cloud code (which in turn validates the supplied credentials against an external system).
* This allows the developer to extend brainCloud authentication to support other backend authentication systems.
*
* Service Name - Authenticate
* Server Operation - Authenticate
*
* @param userid The user id
* @param token The user token (password etc)
* @param externalAuthName The name of the cloud script to call for external authentication
* @param forceCreate Should a new profile be created for this user if the account does not exist?
*/
- (void)authenticateExternal:(NSString *)userID
         authenticationToken:(NSString *)authToken
  externalAuthenticationName:(NSString *)externalAuthName
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
