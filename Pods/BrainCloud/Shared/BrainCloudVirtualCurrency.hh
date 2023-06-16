//
//  BrainCloudVirtualCurrency.h
//  BrainCloud
//
//  Created by Ryan Ruth on 2018-09-21.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudVirtualCurrency : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Retrieve the user's currency account. Optional parameters: vcId (if retrieving all currencies)
 *
 * Service Name - virtual currency
 * Service Operation - GET_PLAYER_VC
 *
 * @param vcId the id of the purchase
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)getCurrency:(NSString *)vcId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve the parent user's currency account.
 *
 * Service Name - virtual currency
 * Service Operation - GET_PARENT_VC
 *
 * @param vcId the id of the purchase
 * @param levelName the level of the app
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getParentCurrency:(NSString *)vcId
              levelName:(NSString *)levelName
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve the peer user's currency account. vcId is optional if retrieving all currencies
 *
 * Service Name - virtual currency
 * Service Operation - GET_PEER_VC
 *
 * @param vcId id for purchase
 * @param peerCode peer name
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getPeerCurrency:(NSString *)vcId
               peerCode:(NSString *)peerCode
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * For security reasons, calling this API from the client is not recommended, and is rejected at the server by default
 *
 * Service Name - virtual currency
 * Service Operation - AWARD_VC
 *
 * @param currencyType whatever the currency
 * @param amount amount of currency
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)awardCurrency:(NSString *)currencyType
               amount:(int)amount
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * For security reasons, calling this API from the client is not recommended, and is rejected at the server by default
 *
 * Service Name - virtual currency
 * Service Operation - CONSUME_VC
 *
 * @param currencyType whatever the currency
 * @param amount amount of currency
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)consumeCurrency:(NSString *)currencyType
                 amount:(int)amount
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
 * Resets player's currency to 0
 *
 * Service Name - virtual currency
 * Service Operation - RESET_PLAYER_VC
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)resetCurrency:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
