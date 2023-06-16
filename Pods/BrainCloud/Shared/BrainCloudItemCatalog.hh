//
//  BrainCloudVirtualCurrency.h
//  BrainCloud
//
//  Created by Ryan Ruth on 2018-09-21.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudItemCatalog : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Reads an existing item definition from the server, with language fields
 * limited to the current or default language
 *
 * Service Name - itemCatalog
 * Service Operation - GET_CATALOG_ITEM_DEFINITION
 *
 * @param defId
 */
-(void)getCatalogItemDefinition:(NSString *)defId
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve page of catalog items from the server, with language fields limited to the
 * text for the current or default language.
 *
 * Service Name - itemCatalog
 * Service Operation - GET_CATALOG_ITEMS_PAGE
 *
 * @param context
 */
-(void)getCatalogItemsPage:(NSString *)context
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the page of catalog items from the server based ont he encoded
 * context and specified page offset, with language fields limited to the
 * text fir the current or default language
 *
 * Service Name - itemCatalog
 * Service Operation - GET_CATALOG_ITEMS_PAGE_OFFSET
 *
 * @param context
 * @param pageOffset
 */

-(void)getCatalogItemsPageOffset:(NSString *)context
                      pageOffset:(int)pageOffset
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
