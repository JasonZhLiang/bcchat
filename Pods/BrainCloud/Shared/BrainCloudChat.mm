//
//  BrainCloudChat.m
//  BrainCloud-iOS
//
//  Created by Ryan Ruth on 2018-11-06.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

#import "BrainCloudChat.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudChat()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudChat

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}

-(void)channelConnect:(NSString *)channelId
            maxReturn:(int)maxReturn
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->channelConnect([channelId UTF8String], maxReturn, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)channelDisconnect:(NSString *)channelId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->channelDisconnect([channelId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteChatMessage:(NSString *)channelId
                 peerCode:(NSString *)msgId
                  version:(int)version
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->deleteChatMessage([channelId UTF8String], [msgId UTF8String], version, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getChannelId:(NSString *)channelType
        channelSubId:(NSString *)channelSubId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->getChannelId([channelType UTF8String], [channelSubId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getChannelInfo:(NSString *)channelId
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->getChannelInfo([channelId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getChatMessage:(NSString *)channelId
                 msgId:(NSString *)msgId
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->getChatMessage([channelId UTF8String], [msgId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getRecentChatMessages:(NSString *)channelId
                    maxReturn:(int)maxReturn
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->getRecentChatMessages([channelId UTF8String], maxReturn, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getSubscribedChannels:(NSString *)channelType
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->getSubscribedChannels([channelType UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postChatMessageSimple:(NSString *)channelId
                         text:(NSString *)plain
              recordInHistory:(bool)recordInHistory
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->postChatMessageSimple([channelId UTF8String], [plain UTF8String], recordInHistory,
                                                     new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postChatMessage:(NSString *)channelId
                content:(NSString *)jsonRich
        recordInHistory:(bool)recordInHistory
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->postChatMessage([channelId UTF8String], [jsonRich UTF8String], recordInHistory,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateChatMessage:(NSString *)channelId
                    msgId:(NSString *)msgId
                  version:(int)version
              jsonContent:(NSString *)jsonContent
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getChatService()->updateChatMessage([channelId UTF8String], [msgId UTF8String], version, [jsonContent UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}
@end
