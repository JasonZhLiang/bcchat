//
//  BrainCloudChat.h
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

@interface BrainCloudChat : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Registers a listener for incoming events form <channelId>
 * Also returns a list of <maxReturn> recent messages from history
 *
 * Service Name - Chat
 * Service Operation - CHANNEL_CONNECT
 *
 * @param channelId the id of the chat channel to return history from
 * @param maxReturn maximum number of messages to return
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)channelConnect:(NSString *)channelId
            maxReturn:(int)maxReturn
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Unregisters a listener for incoming events form <channelId>
 *
 * Service Name - Chat
 * Service Operation - CHANNEL_DISCONNECT
 *
 * @param channelId the id of the chat channel to unsubscribe from
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)channelDisconnect:(NSString *)channelId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Delete a chat message <version> must match the latest or pass -1 to bypass check
 *
 * Service Name - Chat
 * Service Operation - DELETE_CHAT_MESSAGE
 *
 * @param channelId id of the chat channel
 * @param msgId message id to delete
 * @param version version of message. -1 will bypass the version check
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)deleteChatMessage:(NSString *)channelId
                 peerCode:(NSString *)msgId
                  version:(int)version
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the channel Id for the given <channelType> and <channelSubId> Channel type must be one of "gl" or "gr"
 *
 * Service Name - Chat
 * Service Operation - GET_CHANNEL_ID
 *
 * @param channelType channel must be one of "gl" or "gr" for global or group
 * @param channelSubId the subId of the channel
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getChannelId:(NSString *)channelType
        channelSubId:(NSString *)channelSubId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Gets description info and activity stats for channel <channelId>
 * Note that numMsgs and listeners only returned for non-global groups
 * Only callable for channels the user is a member of
 *
 * Service Name - CHAT
 * Service Operation - GET_CHANNEL_INFO
 *
 * @param channelId id of the channel to receive the info from
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getChannelInfo:(NSString *)channelId
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Gets a populated chat object (normally for editing)
 *
 * Service Name - CHAT
 * Service Operation - GET_CHAT_MESSAGE
 *
 * @param channelId id of the channel to receive the info from
 * @param msgId of the message to read
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getChatMessage:(NSString *)channelId
                 msgId:(NSString *)msgId
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Gets a list of <maxReturn> messages form history of channel <channelId>
 *
 * Service Name - CHAT
 * Service Operation - GET_RECENT_CHAT_MESSAGES
 *
 * @param channelId id of the channel to receive the info from
 * @param maxReturn mazimum message count to return
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getRecentChatMessages:(NSString *)channelId
                    maxReturn:(int)maxReturn
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * get list of channel types the user has access to. Type must be gl, gr or all
 *
 * Service Name - CHAT
 * Service Operation - GET_SUBSCRIBED_CHANNELS
 *
 * @param channelId id of the channel to receive the info from
 * @param maxReturn mazimum message count to return
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getSubscribedChannels:(NSString *)channelType
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Send a chat message
 *
 * Service Name - CHAT
 * Service Operation - POST_CHAT_MESSAGE_SIMPLE
 *
 * @param channelId id of the channel to receive the info from
 * @param plain the text message
 * @param recordInHistory true if the message persists in history
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)postChatMessageSimple:(NSString *)channelId
                         text:(NSString *)plain
              recordInHistory:(bool)recordInHistory
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Send a potentially rich chat message
 *
 * Service Name - CHAT
 * Service Operation - POST_CHAT_MESSAGE
 *
 * @param channelId id of the channel to receive the info from
 * @param plain the text message
 * @param rich custom data
 * @param recordInHistory true if the message persists in history
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)postChatMessage:(NSString *)channelId
                content:(NSString *)jsonRich
        recordInHistory:(bool)recordInHistory
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Update a chat message
 * <content> must contain at least a "plain: field for plain-text messaging
 * <version> must match the latest or pass -1 to bypass check
 *
 * Service Name - CHAT
 * Service Operation - UPDATE_CHAT_MESSAGE
 *
 * @param channelId id of the channel to receive the info from
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)updateChatMessage:(NSString *)channelId
                    msgId:(NSString *)msgId
                  version:(int)version
              jsonContent:(NSString *)jsonContent
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
