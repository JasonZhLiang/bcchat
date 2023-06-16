//
//  BrainCloudAsyncMatch.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "BrainCloudAsyncMatch.hh"
#import "BrainCloudClient.hh"
#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

@interface BrainCloudAsyncMatch ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudAsyncMatch

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)createMatch:(NSString *)jsonOpponentIds
    pushNotificationMessage:(NSString *)pushMessage
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{


    _client->getAsyncMatchService()->createMatch(
        [jsonOpponentIds UTF8String], [pushMessage UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)createMatchWithInitialTurn:(NSString *)jsonOpponentIds
                    jsonMatchState:(NSString *)matchState
           pushNotificationMessage:(NSString *)pushMessage
                        nextPlayer:(NSString *)nextPlayer
                       jsonSummary:(NSString *)summary
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->createMatchWithInitialTurn(
        [jsonOpponentIds UTF8String], [matchState UTF8String], [pushMessage UTF8String],
        [nextPlayer UTF8String], [summary UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)submitTurn:(NSString *)ownerId
                    matchId:(NSString *)matchId
                    version:(uint64_t)version
             jsonMatchState:(NSString *)matchState
    pushNotificationMessage:(NSString *)pushMessage
                 nextPlayer:(NSString *)nextPlayer
                jsonSummary:(NSString *)summary
             jsonStatistics:(NSString *)stats
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->submitTurn(
        [ownerId UTF8String], [matchId UTF8String], version, [matchState UTF8String],
        [pushMessage UTF8String], [nextPlayer UTF8String], [summary UTF8String], [stats UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateMatchSummaryData:(NSString *)ownerId
                       matchId:(NSString *)matchId
                       version:(uint64_t)version
                   jsonSummary:(NSString *)summary
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->updateMatchSummaryData(
        [ownerId UTF8String], [matchId UTF8String], version, [summary UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)completeMatch:(NSString *)ownerId
              matchId:(NSString *)matchId
      completionBlock:(BCCompletionBlock)cb
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->completeMatch(
        [ownerId UTF8String], [matchId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readMatch:(NSString *)ownerId
                 matchId:(NSString *)matchId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->readMatch(
        [ownerId UTF8String], [matchId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)abandonMatch:(NSString *)ownerId
             matchId:(NSString *)matchId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->abandonMatch(
        [ownerId UTF8String], [matchId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)deleteMatch:(NSString *)ownerId
                 matchId:(NSString *)matchId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->deleteMatch(
        [ownerId UTF8String], [matchId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)readMatchHistory:(NSString *)ownerId
                 matchId:(NSString *)matchId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->readMatchHistory(
        [ownerId UTF8String], [matchId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findMatches:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->findMatches(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)findCompleteMatches:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->findCompleteMatches(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)completeMatchWithSummaryData:(NSString *)ownerId
                             matchId:(NSString *)matchId
                         pushContent:(NSString *)pushContent
                             summary:(NSString *)summary
                                  cb:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->completeMatchWithSummaryData(
                                                      [ownerId UTF8String],
                                                      [matchId UTF8String],
                                                      [pushContent UTF8String],
                                                      [summary UTF8String],
                                                      new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)abandonMatchWithSummaryData:(NSString *)ownerId
                            matchId:(NSString *)matchId
                        pushContent:(NSString *)pushContent
                            summary:(NSString *)summary
                                 cb:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    _client->getAsyncMatchService()->abandonMatchWithSummaryData(
                                                                  [ownerId UTF8String],
                                                                  [matchId UTF8String],
                                                                  [pushContent UTF8String],
                                                                  [summary UTF8String],
                                                                  new BrainCloudCallback(cb, ecb, cbObject));
}

@end
