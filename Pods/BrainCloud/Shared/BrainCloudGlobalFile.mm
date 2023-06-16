//
//  BrainCloudGlobalFile.mm
//  brainCloudClientObjc
//
//  Created by David St-Louis on 2020-04-24.
//  Copyright © 2020 bitHeads. All rights reserved.
//

#import "BrainCloudGlobalFile.hh"
#import "BrainCloudClient.hh"
#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

@interface BrainCloudGlobalFile ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudGlobalFile

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)getFileInfo:(NSString *)fileId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalFileService()->getFileInfo(
        [fileId UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getFileInfoSimple:(NSString *)folderPath
                filename:(NSString *)filename
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalFileService()->getFileInfoSimple(
        [folderPath UTF8String],
        [filename UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalCDNUrl:(NSString *)fileId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalFileService()->getGlobalCDNUrl(
        [fileId UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalFileList:(NSString *)folderPath
                 recurse:(bool)recurse
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getGlobalFileService()->getGlobalFileList(
        [folderPath UTF8String],
        recurse,
        new BrainCloudCallback(cb, ecb, cbObject));
}

@end
