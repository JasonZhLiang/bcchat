//
//  BrainCloudS3Handling.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-13.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudS3Handling : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Sends an array of file details and returns
* the details of any of those files that have changed
*
* Service Name - S3Handling
* Service Operation - GetUpdatedFiles
*
* @param category  Category of files on server to compare against
* @param fileDetailsJson  An array of file details
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getUpdatedFiles:(NSString *)category
            fileDetails:(NSString *)details
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject;

/**
* Retrieves the details of custom files stored on the server
*
* Service Name - S3Handling
* Service Operation - GetFileList
*
* @param category  Category of files to retrieve
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getFileList:(NSString *)category
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Returns the CDN url for a file object
 *
 * @param fileId ID of the file
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getCDNUrl:(NSString *)fileId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
