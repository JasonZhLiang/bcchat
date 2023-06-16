
#include "BrainCloudCallback.hh"
#import "TypeHelpers.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudUserItems.hh"

@interface BrainCloudUserItems ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudUserItems

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)awardUserItem:(NSString *)defId
             quantity:(int)quantity
           includeDef:(bool)includeDef
      completionBlock:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->awardUserItem(
                                                    [defId UTF8String],
                                                    quantity,
                                                    includeDef,
                                                    new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)dropUserItem:(NSString *)itemId
            quantity:(int)quantity
          includeDef:(bool)includeDef
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->dropUserItem(
                                                  [itemId UTF8String],
                                                  quantity,
                                                  includeDef,
                                                  new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getUserItemsPage:(NSString *)context
              includeDef:(bool)includeDef
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->getUserItemsPage(
                                                 [context UTF8String],
                                                 includeDef,
                                                 new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getUserItemsPageOffset:(NSString *)context
                    pageOffset:(int)pageOffset
                    includeDef:(bool)includeDef
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->getUserItemsPageOffset(
                                                 [context UTF8String],
                                                 pageOffset,
                                                 includeDef,
                                                 new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getUserItem:(NSString *)itemId
         includeDef:(bool)includeDef
    completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
           cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->getUserItem(
                                                           [itemId UTF8String],
                                                           includeDef,
                                                           new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)giveUserItemTo:(NSString *)profileId
                itemId:(NSString *)itemId
               version:(int)version
             immediate:(bool)immediate
       completionBlock:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject;
{
    _client->getUserItemsService()->giveUserItemTo(
                                                           [profileId UTF8String],
                                                           [itemId UTF8String],
                                                           version,
                                                           immediate,
                                                           new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)purchaseUserItem:(NSString *)defId
                quantity:(int)quantity
                  shopId:(NSString *)shopId
              includeDef:(bool)includeDef
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->purchaseUserItem(
                                                   [defId UTF8String],
                                                   quantity,
                                                   [shopId UTF8String],
                                                   includeDef,
                                                   new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)receiveUserItemFrom:(NSString *)profileId
                     itemId:(NSString *)itemId
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->receiveUserItemFrom(
                                                     [profileId UTF8String],
                                                     [itemId UTF8String],
                                                     new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)sellUserItem:(NSString *)itemId
             version:(int)version
            quantity:(int)quantity
              shopId:(NSString *)shopId
          includeDef:(bool)includeDef
     completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->sellUserItem(
                                                        [itemId UTF8String],
                                                        version,
                                                        quantity,
                                                        [shopId UTF8String],
                                                        includeDef,
                                                        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateUserItemData:(NSString *)itemId
                   version:(int)version
               newItemData:(NSString *)newItemData
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->updateUserItemData(
                                                 [itemId UTF8String],
                                                 version,
                                                 [newItemData UTF8String],
                                                 new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)useUserItem:(NSString *)itemId
            version:(int)version
        newItemData:(NSString *)newItemData
         includeDef:(bool)includeDef
    completionBlock:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
           cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->useUserItem(
                                                       [itemId UTF8String],
                                                       version,
                                                       [newItemData UTF8String],
                                                       includeDef,
                                                       new BrainCloudCallback(completionBlock, ecb, cbObject));
}

//BLOCKCHAIN CALLS WILL BE AVAILABLE WHEN RTT IS CONFIRMED
/**
- (void)publishUserItemToBlockchain:(NSString *)itemId
                            version:(int)version
                    completionBlock:(BCCompletionBlock)completionBlock
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->publishUserItemToBlockchain(
                                                [itemId UTF8String],
                                                version,
                                                new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)refreshBlockchainUserItems:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->refreshBlockchainUserItems(
                                                                new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)removeUserItemFromBlockchain:(NSString *)itemId
                             version:(int)version
                     completionBlock:(BCCompletionBlock)completionBlock
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject
{
    _client->getUserItemsService()->removeUserItemFromBlockchain(
                                                                 [itemId UTF8String],
                                                                 version,
                                                                 new BrainCloudCallback(completionBlock, ecb, cbObject));
}
 */

@end
