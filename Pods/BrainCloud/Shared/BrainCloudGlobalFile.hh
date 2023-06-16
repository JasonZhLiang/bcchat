//
//  BrainCloudGlobalFile.hh
//  brainCloudClientObjc
//
//  Created by David St-Louis on 2020-04-24.
//  Copyright © 2020 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;

@interface BrainCloudGlobalFile : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Returns the complete info for the specified file given it’s fileId.
 *
 * @param fileId File ID
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getFileInfo:(NSString *)fileId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Given a path and filename, returns information about the corresponding file.
 *
 * @param folderPath path to the file
 * @param filename filename
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getFileInfoSimple:(NSString *)folderPath
                filename:(NSString *)filename
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Returns the CDN URL for the specified file.
 *
 * @param fileId File ID
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getGlobalCDNUrl:(NSString *)fileId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves the list of global files stored at the specified directory location.
 *
 * @param folderPath Directory location of the files. Use empty string or "/" for root.
 * @param recurse Whether to recurse into subdirectories
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getGlobalFileList:(NSString *)folderPath
                 recurse:(bool)recurse
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
