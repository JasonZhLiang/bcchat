//
//  BrainCloudVirtualCurrency.m
//  BrainCloud-iOS
//
//  Created by Ryan Ruth on 2018-09-21.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

#import "BrainCloudItemCatalog.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudItemCatalog()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudItemCatalog

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}

-(void)getCatalogItemDefinition:(NSString *)defId
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getItemCatalogService()->getCatalogItemDefinition(
                                                      [defId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

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
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getItemCatalogService()->getCatalogItemsPage(
                                                               [context UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

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
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getItemCatalogService()->getCatalogItemsPageOffset(
                                                          [context UTF8String],
                                                          pageOffset,
                                                          new BrainCloudCallback(cb, ecb, cbObject));
}

@end
