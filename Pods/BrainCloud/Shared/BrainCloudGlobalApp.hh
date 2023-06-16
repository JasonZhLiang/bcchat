//
//  BrainCloudGlobalApp.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudGlobalApp : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Read game's global properties
*
* Service Name - GlobalApp
* Service Operation - ReadProperties
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)readProperties:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Returns a list of properties, identified by the property names provided.
 * If a property from the list isn't found, it just isn't returned (no error).
 *
 * Service Name - GlobalApp
 * Service Operation - READ_SELECTED_PROPERTIES
 * 
 * @param propertyNames Specifies which properties to return
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readSelectedProperties:(NSArray *)propertyNames
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
 * Returns a list of properties, identified by the categories provided.
 * If a category from the list isn't found, it just isn't returned (no error).
 *
 * Service Name - GlobalApp
 * Service Operation - READ_PROPERTIES_IN_CATEGORIES
 * 
 * @param categories Specifies which category to return
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)readPropertiesInCategories:(NSArray *)categories
                   completionBlock:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
