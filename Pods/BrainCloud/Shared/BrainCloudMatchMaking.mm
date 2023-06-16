//
//  BrainCloudMatchMaking.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "BrainCloudClient.hh"
#import "BrainCloudMatchMaking.hh"

@interface BrainCloudMatchMaking ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudMatchMaking

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)read:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->read(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)setPlayerRating:(int)rating
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->setPlayerRating(
        rating, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)resetPlayerRating:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->resetPlayerRating(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)incrementPlayerRating:(int)increment
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->incrementPlayerRating(
        increment, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)decrementPlayerRating:(int)decrement
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->decrementPlayerRating(
        decrement, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)turnShieldOn:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->turnShieldOn(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)turnShieldOnFor:(int)minutes
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->turnShieldOnFor(
        minutes, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)turnShieldOff:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->turnShieldOff(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)incrementShieldOnFor:(int) minutes
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->incrementShieldOnFor(minutes,
            new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getShieldExpiry:(NSString *)playerId
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->getShieldExpiry(
        [playerId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findPlayers:(int)rangeDelta
         numMatches:(int)numMatches
    completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
           cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->findPlayers(
        rangeDelta, numMatches, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findPlayersWithAttributes:(int)rangeDelta
                       numMatches:(int)numMatches
                   jsonAttributes:(NSString *)jsonAttributes
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->findPlayersWithAttributes(
        rangeDelta, numMatches, [jsonAttributes UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findPlayersUsingFilter:(int)rangeDelta
                    numMatches:(int)numMatches
               jsonExtraParams:(NSString *)jsonExtraParams
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()
        ->findPlayersUsingFilter(rangeDelta, numMatches, [jsonExtraParams UTF8String],
                                     new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findPlayersWithAttributesUsingFilter:(int)rangeDelta
                                  numMatches:(int)numMatches
                              jsonAttributes:(NSString *)jsonAttributes
                             jsonExtraParams:(NSString *)jsonExtraParams
                             completionBlock:(BCCompletionBlock)cb
                        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                    cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->findPlayersWithAttributesUsingFilter(
        rangeDelta, numMatches, [jsonAttributes UTF8String], [jsonExtraParams UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)enableMatchMaking:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->enableMatchMaking(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)disableMatchMaking:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getMatchmakingService()->disableMatchMaking(
        new BrainCloudCallback(cb, ecb, cbObject));
}

@end
