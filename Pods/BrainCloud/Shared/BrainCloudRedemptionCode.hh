//
//  BrainCloudRedemptionCode.hh
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-10-26.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudRedemptionCode : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Redeem a code.
*
* Service Name - RedemptionCode
* Service Operation - REDEEM_CODE
*
* @param scanCode The code to redeem
* @param codeType The type of code
* @param jsonCustomRedemptionInfo Optional - A JSON string containing custom redemption data
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)redeemCode:(NSString*)scanCode
              codeType:(NSString*)codeType
  jsonCustomRedemptionInfo:(NSString*)jsonCustomRedemptionInfo
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
* Retrieve the codes already redeemed by player.
*
* Service Name - RedemptionCode
* Service Operation - GET_REDEEMED_CODES
*
* @param codeType Optional - The type of codes to retrieve. Returns all codes if left unspecified.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getRedeemedCodes:(NSString*)codeType
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;
@end

#pragma clang diagnostic pop
