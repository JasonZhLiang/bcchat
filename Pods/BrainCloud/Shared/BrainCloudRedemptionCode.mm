//
//  BrainCloudRedemptionCode.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-10-26.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "BrainCloudRedemptionCode.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudRedemptionCode ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudRedemptionCode

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)redeemCode:(NSString*)scanCode
              codeType:(NSString*)codeType
  jsonCustomRedemptionInfo:(NSString*)jsonCustomRedemptionInfo
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getRedemptionCodeService()->redeemCode(
        [scanCode UTF8String], [codeType UTF8String], [jsonCustomRedemptionInfo UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getRedeemedCodes:(NSString*)codeType
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getRedemptionCodeService()->getRedeemedCodes(
        [codeType UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

@end
