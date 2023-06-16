//
//  BrainCloudAppStore.m
//  BrainCloud-iOS
//
//  Created by Ryan Ruth on 2018-09-21.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

#import "BrainCloudAppStore.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudAppStore ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudAppStore

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}

/**
 * Verifies that purchase was properly made at the store
 *
 * Service Name - AppStore
 * Service Operation - VERIFY_PURCHASE
 *
 * @param storeId the store platform. Valid: itunes, facebook, appworld, steam, windows, windowsPhone, googlePlay
 * @param receiptData the specific store data required
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void)verifyPurchase:(NSString *)storeId
          receiptData:(NSString *)receiptData
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getAppStoreService()->verifyPurchase(
         [storeId UTF8String], [receiptData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

/**
 * Returns the eligible promotions for the player
 *
 * Service Name - AppStore
 * Service Operation - ELIGIBLE_PROMOTIONS
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getEligiblePromotions:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getAppStoreService()->getEligiblePromotions(new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)refreshPromotions:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getAppStoreService()->refreshPromotions(new BrainCloudCallback(cb, ecb, cbObject));
}

/**
 * gets the active sales inventory for the passed in currencytype
 *
 * Service Name - AppStore
 * Service Operation - GET_INVENTORY
 *
 * @param storeId the store platform. Valid: itunes, facebook, appworld, steam, windows, windowsPhone, googlePlay
 * @param userCurrency the currency type to retrieve the inventory for
 * @param category product category
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getSalesInventory:(NSString *)storeId
             userCurrency:(NSString *)userCurrency
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getAppStoreService()->getSalesInventory([storeId UTF8String], [userCurrency UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

/**
 * gets the sales inventory fr passed in currency type
 *
 * Service Name - AppStore
 * Service Operation - Get_Inventory
 *
 * @param storeId the store platform. Valid: itunes, facebook, appworld, steam, windows, windowsPhone, googlePlay
 * @param userCurrency the currency type to retrieve the inventory for
 * @param category product category
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getSalesInventoryByCategory:(NSString *)storeId
                       userCurrency:(NSString *)userCurrency
                           category:(NSString *)category
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    _client->getAppStoreService()->getSalesInventoryByCategory(
         [storeId UTF8String], [userCurrency UTF8String], [category UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

/**
 * start a two staged purchase transaction
 *
 * Service Name - AppStore
 * Service Operation - START_PURCHASE
 *
 * @param storeId the store platform. Valid: itunes, facebook, appworld, steam, windows, windowsPhone, googlePlay
 * @param purchaseData the currency type to retrieve the inventory for
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)startPurchase:(NSString *)storeId
         purchaseData:(NSString *)purchaseData
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getAppStoreService()->startPurchase(
         [storeId UTF8String], [purchaseData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

/**
 * finalize a two staged purchase transaction
 *
 * Service Name - AppStore
 * Service Operation - FINALIZE_PURCHASE
 *
 * @param storeId the store platform. Valid: itunes, facebook, appworld, steam, windows, windowsPhone, googlePlay
 * @param transactionId returned from start purchase
 * @param transactionData specific datat for purchasing 2 staged purchase
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)finalizePurchase:(NSString *)storeId
           transactionId:(NSString *)transactionId
         transactionData:(NSString *)transactionData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getAppStoreService()->finalizePurchase(
         [storeId UTF8String], [transactionId UTF8String], [transactionData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

@end
