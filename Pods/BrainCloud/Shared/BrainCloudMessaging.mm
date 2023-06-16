//
//  BrainCloudMessaging.m
//  BrainCloud-iOS
//
//  Created by Ryan Ruth on 2018-10-30.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//
#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "TypeHelpers.hh"
#import "BrainCloudClient.hh"
#import "BrainCloudMessaging.hh"

@interface BrainCloudMessaging()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudMessaging

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}

- (void)deleteMessages:(NSString *)msgBox
                msgIds:(NSArray*)msgIds
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->deleteMessages(
        [msgBox UTF8String], TypeHelpers::NSStringArrayToVector(msgIds), new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)getMessageBoxes:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->getMessageboxes(
        new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)getMessageCounts:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->getMessageCounts(
        new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)getMessages:(NSString *)msgBox
             msgIds:(NSArray*)msgIds
         markAsRead:(bool)markAsRead
    completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
           cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->getMessages(
        [msgBox UTF8String], TypeHelpers::NSStringArrayToVector(msgIds), true, new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)getMessagesPage:(NSString *) context
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->getMessagesPage(
        [context UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)getMessagesPageOffset:(NSString *)context
                   pageOffset:(int)pageOffset
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->getMessagesPageOffset(
        [context UTF8String], pageOffset, new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)sendMessage:(NSArray *)toProfileIds
        contentJson:(NSString *)contentJson
    completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
           cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->sendMessage(
        TypeHelpers::NSStringArrayToVector(toProfileIds), [contentJson UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)sendMessageSimple:(NSArray *)toProfileIds
              messageText:(NSString *)messageText
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->sendMessageSimple(
        TypeHelpers::NSStringArrayToVector(toProfileIds), [messageText UTF8String],  new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)markMessagesRead:(NSString *)msgBox
                  msgIds:(NSArray *)msgIds
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getMessagingService()->markMessagesRead(
        [msgBox UTF8String], TypeHelpers::NSStringArrayToVector(msgIds), new BrainCloudCallback(cb, ecb, cbObject));
}

@end
