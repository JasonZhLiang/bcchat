//
//  BrainCloudFriend.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "BrainCloudFriend.hh"
#import "FriendPlatformObjc.hh"
#import "AuthenticationTypeObjc.hh"
#import "BrainCloudClient.hh"
#include "BrainCloudCallback.hh"
#include "TypeHelpers.hh"
#include "braincloud/BrainCloudClient.h"
#include "braincloud/FriendPlatform.h"
#include "braincloud/AuthenticationType.h"

@interface BrainCloudFriend ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end


@implementation BrainCloudFriend

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)getProfileInfoForCredential:(NSString *)externalId
                 authenticationType:(AuthenticationTypeObjc *)authenticationType
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->getProfileInfoForCredential(
        [externalId UTF8String], BrainCloud::AuthenticationType::fromString([[authenticationType toString] UTF8String]), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getProfileInfoForExternalAuthId:(NSString *)externalId
                      externalAuthType:(NSString *)externalAuthType
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->getProfileInfoForExternalAuthId(
        [externalId UTF8String], [externalAuthType UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getExternalIdForProfileId:(NSString *)profileId
               authenticationType:(NSString *)authenticationType
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->getExternalIdForProfileId(
        [profileId UTF8String], [authenticationType UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getSummaryDataForProfileId:(NSString *)profileId
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->getSummaryDataForProfileId(
        [profileId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readFriendEntity:(NSString *)entityId
                friendId:(NSString *)friendId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->readFriendEntity(
        [entityId UTF8String], [friendId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readFriendsEntities:(NSString *)entityType
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->readFriendsEntities(
        [entityType UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readFriendPlayerState:(NSString *)friendId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->readFriendUserState(
            [friendId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)readFriendUserState:(NSString *)friendId
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->readFriendUserState(
        [friendId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateSummaryFriendData:(NSString *)jsonSummaryData
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->updateSummaryFriendData(
        [jsonSummaryData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findUsersByExactName:(NSString *)searchText
                  maxResults:(int)maxResults
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->findUsersByExactName(
        [searchText UTF8String], maxResults, new BrainCloudCallback(cb, ecb, cbObject));
}
- (void)findUsersBySubstrName:(NSString *)searchText
                   maxResults:(int)maxResults
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->findUsersBySubstrName(
        [searchText UTF8String], maxResults, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findUserByExactUniversalId:(NSString *)searchText
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->findUserByExactUniversalId(
            [searchText UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findUsersByUniversalIdStartingWith:(NSString *)searchText
                                maxResults:(int)maxResults
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->findUsersByUniversalIdStartingWith(
            [searchText UTF8String], maxResults, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findUsersByNameStartingWith:(NSString *)searchText
                         maxResults:(int)maxResults
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->findUsersByNameStartingWith(
            [searchText UTF8String], maxResults, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)listFriends:(FriendPlatformObjc *)friendPlatform
      includeSummaryData:(bool)includeSummaryData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->listFriends(
        BrainCloud::FriendPlatform::fromString([[friendPlatform toString] UTF8String]), includeSummaryData,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)addFriends:(NSArray *)profileIds
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->addFriends(
        TypeHelpers::NSStringArrayToVector(profileIds), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)addFriendsFromPlatform:(FriendPlatformObjc *)friendPlatform
                          mode:(NSString *)mode
                   externalIds:(NSArray *)externalIds
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;
{
    _client->getFriendService()->addFriendsFromPlatform(
        BrainCloud::FriendPlatform::fromString([[friendPlatform toString] UTF8String]),
        [mode UTF8String],
        TypeHelpers::NSStringArrayToVector(externalIds),
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)removeFriends:(NSArray *)profileIds
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->removeFriends(
        TypeHelpers::NSStringArrayToVector(profileIds), new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getUsersOnlineStatus:(NSArray *)profileIds
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getFriendService()->getUsersOnlineStatus(
        TypeHelpers::NSStringArrayToVector(profileIds), new BrainCloudCallback(cb, ecb, cbObject));
}

@end
