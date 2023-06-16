//
//  BrainCloudBlockchain.m
//  brainCloudClientObjc
//
//  Copyright (c) 2022 bitHeads. All rights reserved.
//

#import "BrainCloudBlockchain.hh"
#import "BrainCloudClient.hh"
#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"

@interface BrainCloudBlockchain ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end


@implementation BrainCloudBlockchain

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)getBlockchainItems:(NSString *)in_integrationID
					contextJson:(NSString *)in_contextJson
					completionBlock:(BCCompletionBlock)cb
					errorCompletionBlock:(BCErrorCompletionBlock)ecb
					cbObject:(BCCallbackObject)cbObject;
{
    _client->getBlockchainService()->GetBlockchainItems(
					[in_integrationID UTF8String],
					[in_contextJson UTF8String],
					new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getUniqs:(NSString *)in_integrationID
					contextJson:(NSString *)in_contextJson
					completionBlock:(BCCompletionBlock)cb
					errorCompletionBlock:(BCErrorCompletionBlock)ecb
					cbObject:(BCCallbackObject)cbObject;
{
	_client->getBlockchainService()->GetUniqs(
					[in_integrationID UTF8String],
					[in_contextJson UTF8String],
					new BrainCloudCallback(cb, ecb, cbObject));
}


@end
