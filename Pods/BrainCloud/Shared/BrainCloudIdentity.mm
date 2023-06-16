
    
//
//  BrainCloudIdentity.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-13.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#include "braincloud/AuthenticationType.h"
#include "braincloud/AuthenticationIds.h"
#import "BrainCloudClient.hh"
#import "BrainCloudIdentity.hh"

@interface BrainCloudIdentity ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudIdentity

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)attachFacebookIdentity:(NSString *)facebookId
           authenticationToken:(NSString *)token
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachFacebookIdentity(
        [facebookId UTF8String], [token UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeFacebookIdentity:(NSString *)facebookId
          authenticationToken:(NSString *)token
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeFacebookIdentity(
        [facebookId UTF8String], [token UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachFacebookIdentity:(NSString *)facebookId
                  continueAnon:(bool)continueAnon
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachFacebookIdentity(
        [facebookId UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachGameCenterIdentity:(NSString *)gameCenterId
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachGameCenterIdentity(
        [gameCenterId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeGameCenterIdentity:(NSString *)gameCenterId
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeGameCenterIdentity(
        [gameCenterId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachGameCenterIdentity:(NSString *)gameCenterId
                    continueAnon:(bool)continueAnon
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachGameCenterIdentity(
        [gameCenterId UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachEmailIdentity:(NSString *)email
        authenticationToken:(NSString *)password
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachEmailIdentity(
        [email UTF8String], [password UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeEmailIdentity:(NSString *)email
       authenticationToken:(NSString *)password
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeEmailIdentity(
        [email UTF8String], [password UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachEmailIdentity:(NSString *)email
               continueAnon:(bool)continueAnon
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachEmailIdentity(
        [email UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachUniversalIdentity:(NSString *)userId
            authenticationToken:(NSString *)password
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachUniversalIdentity(
        [userId UTF8String], [password UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeUniversaIdentity:(NSString *)userId
          authenticationToken:(NSString *)password
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeUniversalIdentity(
        [userId UTF8String], [password UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachUniversalIdentity:(NSString *)userId
                   continueAnon:(bool)continueAnon
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachUniversalIdentity(
        [userId UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachSteamIdentity:(NSString *)steamId
        authenticationToken:(NSString *)sessionTicket
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachSteamIdentity(
        [steamId UTF8String], [sessionTicket UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeSteamIdentity:(NSString *)steamId
       authenticationToken:(NSString *)sessionTicket
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeSteamIdentity(
        [steamId UTF8String], [sessionTicket UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachSteamIdentity:(NSString *)steamId
               continueAnon:(bool)continueAnon
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachSteamIdentity(
        [steamId UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachUltraIdentity:(NSString *)ultraUsername
               ultraIdToken:(NSString *)ultraIdToken
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachUltraIdentity(
        [ultraUsername UTF8String], [ultraIdToken UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeUltraIdentity:(NSString *)ultraUsername
              ultraIdToken:(NSString *)ultraIdToken
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeUltraIdentity(
        [ultraUsername UTF8String], [ultraIdToken UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachUltraIdentity:(NSString *)ultraUsername
               continueAnon:(bool)continueAnon
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachUltraIdentity(
        [ultraUsername UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachGoogleIdentity:(NSString *)googleId
         authenticationToken:(NSString *)token
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachGoogleIdentity(
        [googleId UTF8String], [token UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeGoogleIdentity:(NSString *)googleId
        authenticationToken:(NSString *)token
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeGoogleIdentity(
        [googleId UTF8String], [token UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachGoogleIdentity:(NSString *)googleId
                continueAnon:(bool)continueAnon
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachGoogleIdentity(
        [googleId UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachGoogleOpenIdIdentity:(NSString *)googleUserAccountEmail
                     IdToken:(NSString *)IdToken
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachGoogleOpenIdIdentity(
        [googleUserAccountEmail UTF8String], [IdToken UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeGoogleOpenIdIdentity:(NSString *)googleUserAccountEmail
                    IdToken:(NSString *)IdToken
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeGoogleOpenIdIdentity(
        [googleUserAccountEmail UTF8String], [IdToken UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachGoogleOpenIdIdentity:(NSString *)googleUserAccountEmail
                continueAnon:(bool)continueAnon
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachGoogleOpenIdIdentity(
        [googleUserAccountEmail UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachAppleIdentity:(NSString *)appleUserId
                     identityToken:(NSString *)identityToken
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachAppleIdentity(
        [appleUserId UTF8String], [identityToken UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeAppleIdentity:(NSString *)appleUserId
                    identityToken:(NSString *)identityToken
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeAppleIdentity(
        [appleUserId UTF8String], [identityToken UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachAppleIdentity:(NSString *)appleUserId
                continueAnon:(bool)continueAnon
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachAppleIdentity(
        [appleUserId UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)attachTwitterIdentity:(NSString *)twitterId
          authenticationToken:(NSString *)token
                       secret:(NSString *)secret
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachTwitterIdentity(
        [twitterId UTF8String], [token UTF8String], [secret UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeTwitterIdentity:(NSString *)twitterId
         authenticationToken:(NSString *)token
                      secret:(NSString *)secret
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeTwitterIdentity(
        [twitterId UTF8String], [token UTF8String], [secret UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachTwitterIdentity:(NSString *)twitterId
                 continueAnon:(bool)continueAnon
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachTwitterIdentity(
        [twitterId UTF8String], continueAnon, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachAdvancedIdentity:(AuthenticationTypeObjc *)authenticationType
             authenticationIds:(AuthenticationIdsObjc *)authenticationIds
                     extraJson:(NSString *)extraJson
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    // Translate the IDs struct
    BrainCloud::AuthenticationIds cppIds;
    if (authenticationIds)
    {
        if ([authenticationIds externalId]) 
            cppIds.externalId = [[authenticationIds externalId] cStringUsingEncoding:NSUTF8StringEncoding];
        if ([authenticationIds authenticationToken]) 
            cppIds.authenticationToken = [[authenticationIds authenticationToken] cStringUsingEncoding:NSUTF8StringEncoding];
        if ([authenticationIds authenticationSubType]) 
            cppIds.authenticationSubType = [[authenticationIds authenticationSubType] cStringUsingEncoding:NSUTF8StringEncoding];
    }

    std::string cppExtraJson;
    if (extraJson != nil) cppExtraJson = [extraJson cStringUsingEncoding:NSUTF8StringEncoding];

    _client->getIdentityService()->attachAdvancedIdentity(
        BrainCloud::AuthenticationType::fromString([[authenticationType toString] UTF8String]),
        cppIds,
        cppExtraJson,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeAdvancedIdentity:(AuthenticationTypeObjc *)authenticationType
            authenticationIds:(AuthenticationIdsObjc *)authenticationIds
                    extraJson:(NSString *)extraJson
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    // Translate the IDs struct
    BrainCloud::AuthenticationIds cppIds;
    if (authenticationIds)
    {
        if ([authenticationIds externalId]) 
            cppIds.externalId = [[authenticationIds externalId] cStringUsingEncoding:NSUTF8StringEncoding];
        if ([authenticationIds authenticationToken]) 
            cppIds.authenticationToken = [[authenticationIds authenticationToken] cStringUsingEncoding:NSUTF8StringEncoding];
        if ([authenticationIds authenticationSubType]) 
            cppIds.authenticationSubType = [[authenticationIds authenticationSubType] cStringUsingEncoding:NSUTF8StringEncoding];
    }

    std::string cppExtraJson;
    if (extraJson != nil) cppExtraJson = [extraJson cStringUsingEncoding:NSUTF8StringEncoding];

    _client->getIdentityService()->mergeAdvancedIdentity(
        BrainCloud::AuthenticationType::fromString([[authenticationType toString] UTF8String]),
        cppIds,
        cppExtraJson,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachAdvancedIdentity:(AuthenticationTypeObjc *)authenticationType
             authenticationIds:(NSString *)externalId
                  continueAnon:(bool)continueAnon
                     extraJson:(NSString *)extraJson
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    std::string cppExtraJson;
    if (extraJson != nil) cppExtraJson = [extraJson cStringUsingEncoding:NSUTF8StringEncoding];

    _client->getIdentityService()->detachAdvancedIdentity(
        BrainCloud::AuthenticationType::fromString([[authenticationType toString] UTF8String]),
        [externalId UTF8String],
        continueAnon, 
        cppExtraJson,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachParseIdentity:(NSString *)parseId
        authenticationToken:(NSString *)token
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachParseIdentity(
        [parseId UTF8String], [token UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)mergeParseIdentity:(NSString *)parseId
       authenticationToken:(NSString *)token
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->mergeParseIdentity(
        [parseId UTF8String], [token UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachParseIdentity:(NSString *)parseId
               continueAnon:(bool)continueAnon
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachParseIdentity(
        [parseId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)switchToChildProfile:(NSString *)childProfileId
                  childAppId:(NSString *)childAppId
                 forceCreate:(bool)forceCreate
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->switchToChildProfile(
        [childProfileId UTF8String], [childAppId UTF8String], forceCreate, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)switchToSingletonChildProfile:(NSString *)childAppId
                          forceCreate:(bool)forceCreate
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->switchToSingletonChildProfile(
        [childAppId UTF8String], forceCreate, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)switchToParentProfile:(NSString *)parentLevelName
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->switchToParentProfile(
        [parentLevelName UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getChildProfiles:(bool)includeSummaryData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->getChildProfiles(
        includeSummaryData, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachParent:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachParent(new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachParentWithIdentity:(NSString *)externalId
             authenticationToken:(NSString *)token
              authenticationType:(AuthenticationTypeObjc *)type
                externalAuthName:(NSString *)externalAuthName
                     forceCreate:(bool)forceCreate
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachParentWithIdentity(
        [externalId UTF8String], [token UTF8String],
        BrainCloud::AuthenticationType::fromString([[type toString] UTF8String]),
        [externalAuthName UTF8String], forceCreate, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getIdentities:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->getIdentities(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getExpiredIdentities:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->getExpiredIdentities(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)refreshIdentity:(NSString *)externalId
     authenticationToken:(NSString *)token
      authenticationType:(AuthenticationTypeObjc *)type
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->refreshIdentity(
        [externalId UTF8String], [token UTF8String],
        BrainCloud::AuthenticationType::fromString([[type toString] UTF8String]),
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)changeEmailIdentity:(NSString *)oldEmailAddress
                   password:(NSString *)password
            newEmailAddress:(NSString *)newEmailAddress
         updateContactEmail:(bool)updateContactEmail
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->changeEmailIdentity(
            [oldEmailAddress UTF8String],
            [password UTF8String],
            [newEmailAddress UTF8String],
            updateContactEmail,
            new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachPeerProfile:(NSString *)peer
               externalId:(NSString *)externalId
      authenticationToken:(NSString *)token
       authenticationType:(AuthenticationTypeObjc *)type
         externalAuthName:(NSString *)externalAuthName
              forceCreate:(bool)forceCreate
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachPeerProfile([peer UTF8String],
        [externalId UTF8String], [token UTF8String],
        BrainCloud::AuthenticationType::fromString([[type toString] UTF8String]),
        [externalAuthName UTF8String], forceCreate, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)detachPeer:(NSString *)peer
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachPeer(

        [peer UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPeerProfiles:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->getPeerProfiles(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)attachNonLoginUniversalId:(NSString *)externalId
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachNonLoginUniversalId(
        [externalId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateUniversalIdLogin:(NSString*)externalId
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->updateUniversalIdLogin(
        [externalId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

//Commented until RTT confirmed supported
/**
 * Attaches the given block chain public key identity to the current profile.
 *
 * Service Name - identity
 * Service Operation - ATTACH_BLOCKCHAIN_IDENTITY
 *
 * @param blockchainConfig
 * @param publicKey
 * @param callback The method to be invoked when the server response is received
 */
/**
 - (void)attachBlockchainIdentity:(NSString*)blockchainConfig
 publicKey:(NSString*)publicKey
 completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
 cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->attachBlockchainIdentity(
                                                          [blockchainConfig UTF8String],
                                                          [publicKey UTF8String],
                                                          new BrainCloudCallback(cb, ecb, cbObject));
}
 */

/**
 * Detaches the blockchain identity to the current profile.
 * Service Name - identity
 * Service Operation - DETACH_BLOCKCHAIN_IDENTITY
 *
 * @param blockchainConfig
 * @param publicKey
 * @param callback The method to be invoked when the server response is received
 */
/**
 - (void)detachBlockchainIdentity:(NSString*)blockchainConfig
 completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
 cbObject:(BCCallbackObject)cbObject
{
    _client->getIdentityService()->detachBlockchainIdentity(
                                                            [blockchainConfig UTF8String],
                                                            new BrainCloudCallback(cb, ecb, cbObject));
}
 */


@end

