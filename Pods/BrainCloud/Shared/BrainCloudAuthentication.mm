//
//  BrainCloudAuthentication.mm
//  brainCloudClientObjc
//
//  Created by Ryan Homer on 8/4/2015.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "BrainCloudAuthentication.hh"
#import "BrainCloudClient.hh"
#include "braincloud/AuthenticationIds.h"
#include "braincloud/ServiceName.h"
#include "braincloud/ServiceOperation.h"
#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

@interface BrainCloudAuthentication ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudAuthentication

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (NSString *)profileID
{
    const char* str = _client->getAuthenticationService()->getProfileId().c_str();
    
    return [NSString stringWithUTF8String:str];
}

- (NSString *)anonymousID
{
    const char* str = _client
    ->getAuthenticationService()
    ->getAnonymousId()
    .c_str();
    
    return [NSString stringWithUTF8String:str];
}

- (void)initialize:(NSString *)profileID anonymousID:(NSString *)anonymousID
{
    _client->getAuthenticationService()->initialize(
        [profileID UTF8String], [anonymousID UTF8String]);
}

- (NSString *)generateAnonymousId { return [[NSUUID UUID].UUIDString lowercaseString]; }

- (void)clearSavedProfile
{
    _client->getAuthenticationService()->clearSavedProfileId();
}

- (void)authenticateAnonymous:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getAuthenticationService()->authenticateAnonymous(
        forceCreate, new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject));
}

- (void)authenticateFacebook:(NSString *)externalID
         authenticationToken:(NSString *)authToken
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateFacebook(
        [externalID cStringUsingEncoding:NSUTF8StringEncoding],
        [authToken cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateGameCenter:(NSString *)gameCenterID
                   forceCreate:(BOOL)forceCreate
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                      cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateGameCenter(
        [gameCenterID cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateEmailPassword:(NSString *)email
                         password:(NSString *)password
                      forceCreate:(BOOL)forceCreate
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                         cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client
        ->getAuthenticationService()
        ->authenticateEmailPassword([email cStringUsingEncoding:NSUTF8StringEncoding],
                                    [password cStringUsingEncoding:NSUTF8StringEncoding],
                                    forceCreate, brainCloudCallback);
}

- (void)authenticateUniversal:(NSString *)userid
                     password:(NSString *)password
                  forceCreate:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateUniversal(
        [userid cStringUsingEncoding:NSUTF8StringEncoding],
        [password cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateAdvanced:(AuthenticationTypeObjc *)authenticationType
           authenticationIds:(AuthenticationIdsObjc *)authenticationIds
                 forceCreate:(BOOL)forceCreate
                   extraJson:(NSString *)extraJson
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);

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
    
    _client->getAuthenticationService()->authenticateAdvanced(
        BrainCloud::AuthenticationType::fromString([[authenticationType toString] UTF8String]), 
        cppIds,
        forceCreate, 
        cppExtraJson,
        brainCloudCallback);
}

- (void)authenticateUltra:(NSString *)ultraUsername
             ultraIdToken:(NSString *)ultraIdToken
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateUltra(
        [ultraUsername cStringUsingEncoding:NSUTF8StringEncoding],
        [ultraIdToken cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateSteam:(NSString *)userID
            sessionTicket:(NSString *)sessionticket
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateSteam(
        [userID cStringUsingEncoding:NSUTF8StringEncoding],
        [sessionticket cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateApple:(NSString *)appleUserId
            identityToken:(NSString *)identityToken
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
    new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateApple(
                                                            [appleUserId cStringUsingEncoding:NSUTF8StringEncoding],
                                                            [identityToken cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateGoogle:(NSString *)googleUserId
            serverAuthCode:(NSString *)serverAuthCode
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateGoogle(
        [googleUserId cStringUsingEncoding:NSUTF8StringEncoding],
        [serverAuthCode cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateGoogleOpenId:(NSString *)googleUserAccountEmail
                         idToken:(NSString *)idToken
                     forceCreate:(BOOL)forceCreate
                 completionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
    new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateGoogleOpenId([googleUserAccountEmail UTF8String], [idToken UTF8String], forceCreate, brainCloudCallback);
}

- (void)authenticateTwitter:(NSString *)userID
                      token:(NSString *)token
                     secret:(NSString *)secret
                forceCreate:(BOOL)forceCreate
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getAuthenticationService()->authenticateTwitter(
        [userID UTF8String], [token UTF8String], [secret UTF8String], forceCreate,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)authenticateParse:(NSString *)userID
                    token:(NSString *)token
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getAuthenticationService()->authenticateParse(
        [userID UTF8String], [token UTF8String], forceCreate,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)authenticateHandoff:(NSString *)handoffId
              securityToken:(NSString *)securityToken
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getAuthenticationService()->authenticateHandoff(
        [handoffId UTF8String], [securityToken UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)authenticateSettopHandoff:(NSString *)handoffCode
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getAuthenticationService()->authenticateSettopHandoff(
                [handoffCode UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)resetEmailPassword:(NSString *)email
       withCompletionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->resetEmailPassword(
        [email cStringUsingEncoding:NSUTF8StringEncoding], brainCloudCallback);
}

- (void)resetEmailPasswordAdvanced:(NSString *)email
                     serviceParams:(NSString *)serviceParams
               withCompletionBlock:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                          cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
    new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->resetEmailPasswordAdvanced(
    [email cStringUsingEncoding:NSUTF8StringEncoding],[serviceParams UTF8String], brainCloudCallback);
}

- (void)resetEmailPasswordWithExpiry:(NSString *)email
         tokenTtlInMinutes:(int)tokenTtlInMinutes
       withCompletionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->resetEmailPasswordWithExpiry(
        [email cStringUsingEncoding:NSUTF8StringEncoding], tokenTtlInMinutes, brainCloudCallback);
}

- (void)resetEmailPasswordAdvancedWithExpiry:(NSString *)email
                     serviceParams:(NSString *)serviceParams
                 tokenTtlInMinutes:(int)tokenTtlInMinutes
               withCompletionBlock:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                          cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
    new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->resetEmailPasswordAdvancedWithExpiry(
    [email cStringUsingEncoding:NSUTF8StringEncoding],[serviceParams UTF8String],tokenTtlInMinutes, brainCloudCallback);
}


- (void)resetUniversalIdPassword:(NSString *)universalId
             withCompletionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->resetUniversalIdPassword([universalId cStringUsingEncoding:NSUTF8StringEncoding], brainCloudCallback);
}

- (void)resetUniversalIdPasswordAdvanced:(NSString *)universalId
                           serviceParams:(NSString *)serviceParams
                     withCompletionBlock:(BCCompletionBlock)completionBlock
                    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->resetUniversalIdPasswordAdvanced([universalId cStringUsingEncoding:NSUTF8StringEncoding],[serviceParams UTF8String], brainCloudCallback);
}

- (void)resetUniversalIdPasswordWithExpiry:(NSString *)universalId
               tokenTtlInMinutes:(int)tokenTtlInMinutes
             withCompletionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject
{
        BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
        _client->getAuthenticationService()->resetUniversalIdPasswordWithExpiry([universalId cStringUsingEncoding:NSUTF8StringEncoding], tokenTtlInMinutes, brainCloudCallback);
}

- (void)resetUniversalIdPasswordAdvancedWithExpiry:(NSString *)universalId
                           serviceParams:(NSString *)serviceParams
                       tokenTtlInMinutes:(int)tokenTtlInMinutes
                     withCompletionBlock:(BCCompletionBlock)completionBlock
                    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->resetUniversalIdPasswordAdvancedWithExpiry([universalId cStringUsingEncoding:NSUTF8StringEncoding], [serviceParams UTF8String], tokenTtlInMinutes, brainCloudCallback);
}

- (void)authenticateExternal:(NSString *)userID
         authenticationToken:(NSString *)authToken
  externalAuthenticationName:(NSString *)externalAuthName
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateExternal(
        [userID cStringUsingEncoding:NSUTF8StringEncoding],
        [authToken cStringUsingEncoding:NSUTF8StringEncoding],
        [externalAuthName cStringUsingEncoding:NSUTF8StringEncoding], forceCreate,
        brainCloudCallback);
}

@end
