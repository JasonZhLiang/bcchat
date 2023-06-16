//
//  BrainCloudS3Handling.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-13.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudS3Handling.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudS3Handling ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudS3Handling

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}

- (void)getUpdatedFiles:(NSString *)category
            fileDetails:(NSString *)details
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getS3HandlingService()->getUpdatedFiles(
        [category UTF8String], [details UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getFileList:(NSString *)category
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getS3HandlingService()->getFileList(
        [category UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getCDNUrl:(NSString *)fileId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getS3HandlingService()->getCDNUrl(
        [fileId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

@end
