//
//  BrainCloudProduct.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-04.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudProfanity : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Checks supplied text for profanity.
 *
 * Service Name - Profanity
 * Service Operation - ProfanityCheck
 *
 * @param text The text to check
 * @param languages Optional comma delimited list of two character language codes
 * @param flagEmail Optional processing of email addresses
 * @param flagPhone Optional processing of phone numbers
 * @param flagUrls Optional processing of urls
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * Significant error codes:
 *
 * 40421 - WebPurify not configured
 * 40422 - General exception occurred
 * 40423 - WebPurify returned an error (Http status != 200)
 * 40424 - WebPurify not enabled
 */
- (void)profanityCheck:(NSString *)text
languages:(NSString *)languages
flagEmail:(BOOL)flagEmail
flagPhone:(BOOL)flagPhone
flagUrls:(BOOL)flagUrls
completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
cbObject:(BCCallbackObject)cbObject;


/**
 * Replaces the characters of profanity text with a passed character(s).
 *
 * Service Name - Profanity
 * Service Operation - ProfanityReplaceText
 *
 * @param in_text The text to check
 * @param in_replaceSymbol The text to replace individual characters of profanity text with
 * @param in_languages Optional comma delimited list of two character language codes
 * @param in_flagEmail Optional processing of email addresses
 * @param in_flagPhone Optional processing of phone numbers
 * @param in_flagUrls Optional processing of urls
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * Significant error codes:
 *
 * 40421 - WebPurify not configured
 * 40422 - General exception occurred
 * 40423 - WebPurify returned an error (Http status != 200)
 * 40424 - WebPurify not enabled
 */
- (void)profanityReplaceText:(NSString *)text
replaceSymbol:(NSString *)replaceSymbol
languages:(NSString *)languages
flagEmail:(BOOL)flagEmail
flagPhone:(BOOL)flagPhone
flagUrls:(BOOL)flagUrls
completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
cbObject:(BCCallbackObject)cbObject;


/**
 * Checks supplied text for profanity and returns a list of bad wors.
 *
 * Service Name - Profanity
 * Service Operation - ProfanityIdentifyBadWords
 *
 * @param text The text to check
 * @param languages Optional comma delimited list of two character language codes
 * @param flagEmail Optional processing of email addresses
 * @param flagPhone Optional processing of phone numbers
 * @param flagUrls Optional processing of urls
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * Significant error codes:
 *
 * 40421 - WebPurify not configured
 * 40422 - General exception occurred
 * 40423 - WebPurify returned an error (Http status != 200)
 * 40424 - WebPurify not enabled
 */
- (void)profanityIdentifyBadWords:(NSString *)text
languages:(NSString *)languages
flagEmail:(BOOL)flagEmail
flagPhone:(BOOL)flagPhone
flagUrls:(BOOL)flagUrls
completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
