//
//  BrainCloudGroup.mm
//  brainCloudClientObjc
//
//  Created by Joanne Hoar on 2023-03-03.
//  Copyright © 2023 BitHeads Inc. All rights reserved.
//

#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudGroupFile.hh"
#import "TypeHelpers.hh"

@interface BrainCloudGroupFile ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudGroupFile

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}

- (void) checkFilenameExists:(NSString *)groupId
                  folderPath:(NSString *)folderPath
                    fileName:(NSString *)fileName
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->checkFilenameExists(
                                                        [groupId UTF8String], [folderPath UTF8String], [fileName UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void) checkFullpathFilenameExists:(NSString *)groupId
                    fullPathFilename:(NSString *)fullPathFilename
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->checkFullpathFilenameExists(
                                                                [groupId UTF8String], [fullPathFilename UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void) copyFile:(NSString *)groupId
           fileId:(NSString *)fileId
          version:(int)version
        newTreeId:(NSString *)newTreeId
      treeVersion:(int)treeVersion
      newFilename:(NSString *)newFilename
overwriteIfPresent:(bool)overwriteIfPresent
  completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
         cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->copyFile(
                                             [groupId UTF8String], [fileId UTF8String], version, [newTreeId UTF8String], treeVersion, [newFilename UTF8String], overwriteIfPresent, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void) deleteFile:(NSString *)groupId
             fileId:(NSString *)fileId
            version:(int)version
        newFilename:(NSString *)newFilename
    completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
           cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->deleteFile(
                                               [groupId UTF8String], [fileId UTF8String], version, [newFilename UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void) getFileInfo:(NSString *)groupId
              fileId:(NSString *)fileId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->getFileInfo(
                                                [groupId UTF8String], [fileId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}


- (void) getCDNUrl:(NSString *)groupId
            fileId:(NSString *)fileId
   completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
          cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->getCDNUrl(
                                              [groupId UTF8String], [fileId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
    
}

- (void) getFileInfoSimple:(NSString *)groupId
                folderPath:(NSString *)folderPath
                  fileName:(NSString *)fileName
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->getFileInfoSimple(
                                                      [groupId UTF8String], [folderPath UTF8String], [fileName UTF8String],  new BrainCloudCallback(cb, ecb, cbObject));
    
}


- (void) getFileList:(NSString *)groupId
          folderPath:(NSString *)folderPath
             recurse:(bool)recurse
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->getFileList(
                                                [groupId UTF8String], [folderPath UTF8String], recurse,  new BrainCloudCallback(cb, ecb, cbObject));
}

- (void) moveFile:(NSString *)groupId
           fileId:(NSString *)fileId
          version:(int)version
        newTreeId:(NSString *)newTreeId
      treeVersion:(int)treeVersion
      newFilename:(NSString *)newFilename
overwriteIfPresent:(bool)overwriteIfPresent
  completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
         cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->moveFile([groupId UTF8String], [fileId UTF8String], version, [newTreeId UTF8String], treeVersion, [newFilename UTF8String], overwriteIfPresent, new BrainCloudCallback(cb, ecb, cbObject));
}


- (void) moveUserToGroupFile:(NSString *)userCloudPath
           userCloudFilename:(NSString *)userCloudFilename
                     groupId:(NSString *)groupId
                 groupTreeId:(NSString *)groupTreeId
               groupFilename:(NSString *)groupFilename
                groupFileAcl:(NSString *)groupFileAcl
          overwriteIfPresent:(bool)overwriteIfPresent
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->moveUserToGroupFile([userCloudPath UTF8String], [userCloudFilename UTF8String], [groupId UTF8String], [groupTreeId UTF8String], [groupFilename UTF8String], [groupFileAcl UTF8String], overwriteIfPresent, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void) updateFileInfo:(NSString *)groupId
                 fileId:(NSString *)fileId
                version:(int)version
            newFilename:(NSString *)newFilename
                 newAcl:(NSString *)newAcl
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;
{
    _client->getGroupFileService()->updateFileInfo([groupId UTF8String], [fileId UTF8String], version, [newFilename UTF8String], [newAcl UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

@end
