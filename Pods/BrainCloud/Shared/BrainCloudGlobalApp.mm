//
//  BrainCloudGlobalApp.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "BrainCloudGlobalApp.hh"

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "BrainCloudClient.hh"
#import "TypeHelpers.hh"


@interface BrainCloudGlobalApp ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudGlobalApp

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)readProperties:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalAppService()->readProperties(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)readSelectedProperties:(NSArray *)propertyNames
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalAppService()->readSelectedProperties(
        TypeHelpers::NSStringArrayToVector(propertyNames),
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)readPropertiesInCategories:(NSArray *)categories
                   completionBlock:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalAppService()->readPropertiesInCategories(
        TypeHelpers::NSStringArrayToVector(categories),
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

@end
