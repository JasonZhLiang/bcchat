
#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;

@interface BrainCloudUserItems : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Allows item(s) to be awarded to a user without collecting
 *  the purchase amount. If includeDef is true, response
 * includes associated itemDef with language fields limited
 *  to the current or default language.
 *
 * Service Name - userItems
 * Service Operation - AWARD_USER_ITEM
 *
 * @param defId
 * @param quantity
 * @param includeDef
 */
- (void)awardUserItem:(NSString *)defId
             quantity:(int)quantity
           includeDef:(bool)includeDef
      completionBlock:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Allows a quantity of a specified user item to be dropped,
 * without any recovery of the money paid for the item.
 * If any quantity of the user item remains, it will be returned,
 * potentially with the associated itemDef (with language fields
 * limited to the current or default language).
 *
 * Service Name - userItems
 * Service Operation - DROP_USER_ITEM
 *
 * @param defId
 * @param quantity
 * @param includeDef
 */
- (void)dropUserItem:(NSString *)itemId
            quantity:(int)quantity
          includeDef:(bool)includeDef
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves the page of user's items from the server
 * based on the context. If includeDef is true, response
 *  includes associated itemDef with each user item, with
 * language fields limited to the current or default language.
 *
 * Service Name - userItems
 * Service Operation - GET_USER_ITEMS_PAGE
 *
 * @param context
 * @param includeDef
 */
- (void)getUserItemsPage:(NSString *)context
              includeDef:(bool)includeDef
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves the page of user's items from the server
 *  based on the encoded context. If includeDef is true,
 * response includes associated itemDef with each user item,
 * with language fields limited to the current or default
 * language.
 *
 * Service Name - userItems
 * Service Operation - GET_USER_ITEMS_PAGE_OFFSET
 *
 * @param context
 * @param pageOffset
 * @param includeDef
 */
- (void)getUserItemsPageOffset:(NSString *)context
                    pageOffset:(int)pageOffset
                    includeDef:(bool)includeDef
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves the identified user item from the server.
 * If includeDef is true, response includes associated
 * itemDef with language fields limited to the current
 * or default language.
 *
 * Service Name - userItems
 * Service Operation - GET_USER_ITEM
 *
 * @param itemId
 * @param includeDef
 * @param callback The method to be invoked when the server response is received
 */

- (void)getUserItem:(NSString *)itemId
           includeDef:(bool)includeDef
      completionBlock:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject;

/**
 * Gifts item to the specified player.
 *
 * Service Name - userItems
 * Service Operation - GIVE_USER_ITEM_TO
 *
 * @param profileId
 * @param itemId
 * @param version
 * @param immediate
 */

- (void)giveUserItemTo:(NSString *)profileId
                itemId:(NSString *)itemId
               version:(int)version
             immediate:(bool)immediate
       completionBlock:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves the identified user item from the server.
 * If includeDef is true, response includes associated
 * itemDef with language fields limited to the current
 * or default language.
 *
 * Service Name - userItems
 * Service Operation - PURCHASE_USER_ITEM
 *
 * @param defId
 * @param quantity
 * @param shopId
 * @param includeDef
 */

- (void)purchaseUserItem:(NSString *)defId
                quantity:(int)quantity
                  shopId:(NSString *)shopId
              includeDef:(bool)includeDef
completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieves and transfers the gift item from
 * the specified player, who must have previously
 * called giveUserItemTo.
 *
 * Service Name - userItems
 * Service Operation - RECEVIE_USER_ITEM_FROM
 *
 * @param profileId
 * @param itemId
 */

- (void)receiveUserItemFrom:(NSString *)profileId
                     itemId:(NSString *)itemId
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Allows a quantity of a specified user item to be sold.
 * If any quantity of the user item remains, it will be returned,
 * potentially with the associated itemDef (with language fields
 * limited to the current or default language), along with the
 * currency refunded and currency balances.
 *
 * Service Name - userItems
 * Service Operation - SELL_USER_ITEM
 *
 * @param itemId
 * @param version
 * @param quantity
 * @param shopId
 * @param includeDef
 */

- (void)sellUserItem:(NSString *)itemId
             version:(int)version
            quantity:(int)quantity
              shopId:(NSString *)shopId
          includeDef:(bool)includeDef
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject;

/**
 * Updates the item data on the specified user item.
 *
 * Service Name - userItems
 * Service Operation - UPDATE_USER_ITEM_DATA
 *
 * @param itemId
 * @param version
 * @param newItemData
 */

- (void)updateUserItemData:(NSString *)itemId
                   version:(int)version
               newItemData:(NSString*)newItemData
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Uses the specified item, potentially consuming it.
 *
 * Service Name - userItems
 * Service Operation - USE_USER_ITEM
 *
 * @param itemId
 * @param version
 * @param newItemData
 * @param includeDef
 */

- (void)useUserItem:(NSString *)itemId
            version:(int)version
        newItemData:(NSString *)newItemData
         includeDef:(bool)includeDef
    completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
           cbObject:(BCCallbackObject)cbObject;

//RTT BLOCKCHAIN - will be available when RTT confirmed

/**
 * Publishes the specified item to the item management attached blockchain. Results are reported asynchronously via an RTT event.
 *
 * Service Name - userItems
 * Service Operation - PUBLISH_USER_ITEM_TO_BLOCKCHAIN
 *
 * @param itemId
 * @param version
 */
/**
- (void)publishUserItemToBlockchain:(NSString *)itemId
                            version:(int)version
                    completionBlock:(BCCompletionBlock)completionBlock
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject;
*/
/**
 * Syncs the caller's user items with the item management attached blockchain. Results are reported asynchronously via an RTT event.
 *
 * Service Name - userItems
 * Service Operation - REFRESH_BLOCKCHAIN_USER_ITEMS
 *
 */
/**
- (void)refreshBlockchainUserItems:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject;
*/
/**
 * Removes the specified item from the item management attached blockchain. Results are reported asynchronously via an RTT event.
 * Service Name - userItems
 * Service Operation - REMOVE_USER_ITEM_FROM_BLOCKCHAIN
 *
 * @param itemId
 * @param version
 */
/**
- (void)removeUserItemFromBlockchain:(NSString *)itemId
                             version:(int)version
                     completionBlock:(BCCompletionBlock)completionBlock
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject;
*/

@end

#pragma clang diagnostic pop
