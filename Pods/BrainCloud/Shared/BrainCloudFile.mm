//
//  BrainCloudFile.m
//  brainCloudClientObjc
//
//  Created by Preston Jennings on 2016-01-21.
//  Copyright © 2016 bitHeads. All rights reserved.
//

#import "BrainCloudFile.hh"
#import "BrainCloudClient.hh"
#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

@interface BrainCloudFile ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudFile

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (bool)uploadFile:(NSString *)cloudPath
     cloudFilename:(NSString *)cloudFilename
         shareable:(bool)shareable
   replaceIfExists:(bool)replaceIfExists
         localPath:(NSString *)localPath
   completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
          cbObject:(BCCallbackObject)cbObject;
{
    BrainCloudCallback * bcb = new BrainCloudCallback(cb, ecb, cbObject);
    bool res = _client->
    getFileService()->uploadFile(
                                 [cloudPath UTF8String],
                                 [cloudFilename UTF8String],
                                 shareable,
                                 replaceIfExists,
                                 [localPath UTF8String],
                                 bcb);
    if (!res)
    {
        delete bcb;
        bcb = NULL;
    }
    return res;
}

- (void)listUserFiles:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->
    getFileService()->listUserFiles(new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)listUserFiles:(NSString *)cloudPath
              recurse:(bool)recurse
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->
    getFileService()->listUserFiles([cloudPath UTF8String], recurse, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteUserFile:(NSString *)cloudPath
         cloudFilename:(NSString *)cloudFilename
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->
    getFileService()->deleteUserFile([cloudPath UTF8String], [cloudFilename UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteUserFiles:(NSString *)cloudPath
                recurse:(bool)recurse
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->
    getFileService()->deleteUserFiles([cloudPath UTF8String], recurse, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getCDNUrl:(NSString *)cloudPath
    cloudFileName:(NSString *)cloudFileName
  completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
         cbObject:(BCCallbackObject)cbObject
{
    _client->
    getFileService()->getCDNUrl([cloudPath UTF8String], [cloudFileName UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void) cancelUpload:(NSString *)uploadId
{
    _client->
    getFileService()->cancelUpload([uploadId UTF8String]);
}

- (double) getUploadProgress:(NSString *)uploadId
{
    return _client->
    getFileService()->getUploadProgress([uploadId UTF8String]);
}

- (NSInteger) getUploadBytesTransferred:(NSString *)uploadId
{
    return (NSInteger)_client->getFileService()->getUploadBytesTransferred([uploadId UTF8String]);
}


- (NSInteger) getUploadTotalBytesToTransfer:(NSString *)uploadId
{
    return (NSInteger)_client->getFileService()->getUploadTotalBytesToTransfer([uploadId UTF8String]);
}

@end
