//
//  BrainCloudPresence.m
//  BrainCloud-iOS
//
//  Created by Ryan Ruth on 2018-09-13.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "TypeHelpers.hh"
#import "BrainCloudPresence.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudPresence ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudPresence

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}

- (void)forcePush:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->forcePush(new BrainCloudCallback(cb, ecb, cbObject));
}
//TypeHelpers::NSStringArrayToVector(playerStats)
- (void)getPresenceOfFriends:(NSString *)platform
              includeOffline:(bool)includeOffline
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->getPresenceOfFriends(
        [platform UTF8String], includeOffline, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPresenceOfGroup:(NSString *)groupId
            includeOffline:(bool)includeOffline
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->getPresenceOfGroup(
        [groupId UTF8String],includeOffline, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPresenceOfUsers:(NSArray *)profileIds
            includeOffline:(bool)includeOffline
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->getPresenceOfUsers(
        TypeHelpers::NSStringArrayToVector(profileIds), includeOffline, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)registerListenersForFriends:(NSString *)platform
                      bidirectional:(bool)bidirectional
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->registerListenersForFriends(
        [platform UTF8String], bidirectional, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)registerListenersForGroup:(NSString *)groupId
                    bidirectional:(bool)bidirectional
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->registerListenersForGroup(
        [groupId UTF8String], bidirectional, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)registerListenersForProfiles:(NSArray *)profileIds
                       bidirectional:(bool)bidirectional
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->registerListenersForProfiles(
        TypeHelpers::NSStringArrayToVector(profileIds), bidirectional, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)setVisibility:(bool)visible
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->setVisibility(
        visible, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)stopListening:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getPresenceService()->stopListening(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateActivity:(NSString *)jsonActivity
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;
{
    _client->getPresenceService()->updateActivity(
        [jsonActivity UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

@end
