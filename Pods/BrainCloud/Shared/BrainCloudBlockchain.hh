//
//  BrainCloudBlockchain.h
//  brainCloudClientObjc
//
//  Copyright (c) 2022 bitHeads. All rights reserved.
//

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;
@interface BrainCloudBlockchain : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * @brief Retrieves the blockchain items owned by the caller.
 */
- (void)getBlockchainItems:(NSString *)in_integrationID
					contextJson:(NSString *)in_contextJson
                    completionBlock:(BCCompletionBlock)cb
					errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
 * @brief Retrieves the uniqs owned by the caller.
 */
- (void)getUniqs:(NSString *)in_integrationID
					contextJson:(NSString *)in_contextJson
					completionBlock:(BCCompletionBlock)cb
					errorCompletionBlock:(BCErrorCompletionBlock)ecb
					cbObject:(BCCallbackObject)cbObject;

@end
