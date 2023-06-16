//
//  BrainCloudMail.hh
//  brainCloudClientObjc
//
//  Created by Brad Hill on 12/10/2016.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;

@interface BrainCloudMail : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Sends a simple text email to the specified user
 *
 * Service Name - mail
 * Service Operation - SEND_BASIC_EMAIL
 *
 * @param profileId The user to send the email to
 * @param subject The email subject
 * @param body The email body
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)sendBasicEmail:(NSString *)profileId
               subject:(NSString *)subject
                  body:(NSString *)body
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Sends an advanced email to the specified user
 *
 * Service Name - mail
 * Service Operation - SEND_ADVANCED_EMAIL
 *
 * @param in_profileId The user to send the email to
 * @param in_jsonServiceParams Parameters to send to the email service. See the documentation for
 *	a full list. http://getbraincloud.com/apidocs/apiref/#capi-mail
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)sendAdvancedEmail:(NSString *)profileId
        jsonServiceParams:(NSString *)jsonServiceParams
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;


/**
 * Sends an advanced email to the email address
 *
 * Service Name - mail
 * Service Operation - SEND_ADVANCED_EMAIL_BY_ADDRESS
 *
 * @param in_emailAddress The address to send the email to
 * @param in_jsonServiceParams Parameters to send to the email service. See the documentation for
 *	a full list. http://getbraincloud.com/apidocs/apiref/#capi-mail
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 * @see The API documentation site for more details on cloud code
 */
- (void)sendAdvancedEmailByAddress:(NSString *)emailAddress
        jsonServiceParams:(NSString *)jsonServiceParams
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
