//
//  BrainCloudMessaging.hh
//  BrainCloudClientObjC
//
//  Created by Ryan Ruth on 2018-10-30.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;

@interface BrainCloudMessaging : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Deletes Specified user messages on the server.
 *
 * Service Name - messages
 * Service Operation - DELETE_MESSAGES
 *
 * @param msgBox
 * @param msgIds Arrays of message ids to delete
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)deleteMessages:(NSString *)msgBox
                msgIds:(NSArray*)msgIds
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve users message boxes, including 'inbox', 'sent', etc.
 *
 * Service Name - messaging
 * Service Operation - GET_MESSAGE_BOXES
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)getMessageBoxes:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Returns count of user's 'total' messges and their unread messages
 *
 * Service Name - messages
 * Service Operation - GET_MESSAGE_COUNTS
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)getMessageCounts:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves list of specified messages
 *
 * Service Name - messages
 * Service Operation - GET_MESSAGES
 *
 * @param msgBox
 * @param msgIds Arrays of message ids to delete
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)getMessages:(NSString *)msgBox
                msgIds:(NSArray*)msgIds
            markAsRead:(bool)markAsRead
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * retrieves a page of messages
 *
 * Service Name - messaging
 * Service Operation - GET_MESSAGES_PAGE
 *
 * @param context
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)getMessagesPage:(NSString *) context
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Returns count of user's 'total' messges and their unread messages
 *
 * Service Name - messaging
 * Service Operation - GET_MESSAGES_PAGE_OFFSET
 *
 * @param context
 * @param pageOffset
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)getMessagesPageOffset:(NSString *)context
                   pageOffset:(int)pageOffset
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Sends message to profiles
 *
 * Service Name - messaging
 * Service Operation - SEND_MESSAGE
 *
 * @param toProfileIds
 * @param contentJson
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)sendMessage:(NSArray *)toProfileIds
         contentJson:(NSString *)contentJson
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Sends message to profiles
 *
 * Service Name - messaging
 * Service Operation - SEND_MESSAGE_SIMPLE
 *
 * @param toProfileIds
 * @param messageText
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)sendMessageSimple:(NSArray *)toProfileIds
              messageText:(NSString *)messageText
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Marks list of user messages as read on the server
 *
 * Service Name - messaging
 * Service Operation - MARK_MESSAGES_READ
 *
 * @param msgBox
 * @param msgIds
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)markMessagesRead:(NSString *)msgBox
                  msgIds:(NSArray *)msgIds
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
