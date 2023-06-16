//
//  BrainCloudRTT.mm
//  BrainCloud
//
//  Created by David St-Louis on 2020-01-07.
//  Copyright © 2020 BitHeads Inc. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "braincloud/BrainCloudRTT.h"
#include "BrainCloudCallback.hh"
#include "BrainCloudRTTCallback.hh"
#include "BrainCloudRTTConnectCallback.hh"
#include "TypeHelpers.hh"
#import "BrainCloudRTT.hh"
#import "BrainCloudClient.hh"

@interface BrainCloudRTT()
{
    BrainCloud::BrainCloudClient *_client;
    BrainCloudRTTConnectCallback _connectCallback;
    BrainCloudRTTCallback _eventRTTCallback;
    BrainCloudRTTCallback _chatRTTCallback;
    BrainCloudRTTCallback _messagingRTTCallback;
    BrainCloudRTTCallback _lobbyRTTCallback;
    BrainCloudRTTCallback _presenceRTTCallback;
    BrainCloudRTTCallback _blockchainRefreshRTTCallback;
}
@end

@implementation BrainCloudRTT

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}


-(void) requestClientConnection:(BCCompletionBlock)completionBlock
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;
{
    _client->getRTTService()->requestClientConnection(new BrainCloudCallback(completionBlock, ecb, cbObject));
}

-(void) enableRTT:(BCRTTConnectSuccessCompletionBlock)successCompletionBlock
        failureCompletionBlock:(BCRTTConnectFailureCompletionBlock)failureCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    [self enableRTT:YES successCompletionBlock:successCompletionBlock failureCompletionBlock:failureCompletionBlock cbObject:cbObject];
}
-(void) enableRTT:(BOOL)useWebSocket
        successCompletionBlock:(BCRTTConnectSuccessCompletionBlock)successCompletionBlock
        failureCompletionBlock:(BCRTTConnectFailureCompletionBlock)failureCompletionBlock
                      cbObject:(BCCallbackObject)cbObject
{
    _connectCallback.setCompletionBlocks(successCompletionBlock, failureCompletionBlock, cbObject);
    _client->getRTTService()->enableRTT(&_connectCallback, useWebSocket == YES ? true : false);
}

-(void) disableRTT
{
    _connectCallback.setCompletionBlocks(nil, nil, nil);
    _client->getRTTService()->disableRTT();
}

-(void) getRTTEnabled
{
    _client->getRTTService()->getRTTEnabled();
}

-(BCRTTConnectionStatus) getConnectionStatus
{
    return (BCRTTConnectionStatus)_client->getRTTService()->getConnectionStatus();
}

-(void) registerRTTEventCallback:(BCRTTEventBlock)eventBlock
                        cbObject:(BCCallbackObject)cbObject
{
    _eventRTTCallback.setEventBlock(eventBlock, cbObject);
    _client->getRTTService()->registerRTTEventCallback(&_eventRTTCallback);
}
-(void) deregisterRTTEventCallback
{
    _client->getRTTService()->deregisterRTTEventCallback();
    _eventRTTCallback.setEventBlock(nil, nil);
}

-(void) registerRTTChatCallback:(BCRTTEventBlock)eventBlock
                       cbObject:(BCCallbackObject)cbObject
{
    _chatRTTCallback.setEventBlock(eventBlock, cbObject);
    _client->getRTTService()->registerRTTChatCallback(&_chatRTTCallback);
}
-(void) deregisterRTTChatCallback
{
    _client->getRTTService()->deregisterRTTChatCallback();
    _chatRTTCallback.setEventBlock(nil, nil);
}

-(void) registerRTTMessagingCallback:(BCRTTEventBlock)eventBlock
                            cbObject:(BCCallbackObject)cbObject
{
    _messagingRTTCallback.setEventBlock(eventBlock, cbObject);
    _client->getRTTService()->registerRTTMessagingCallback(&_messagingRTTCallback);
}
-(void) deregisterRTTMessagingCallback
{
    _client->getRTTService()->deregisterRTTMessagingCallback();
    _messagingRTTCallback.setEventBlock(nil, nil);
}

-(void) registerRTTLobbyCallback:(BCRTTEventBlock)eventBlock
                        cbObject:(BCCallbackObject)cbObject
{
    _lobbyRTTCallback.setEventBlock(eventBlock, cbObject);
    _client->getRTTService()->registerRTTLobbyCallback(&_lobbyRTTCallback);
}
-(void) deregisterRTTLobbyCallback
{
    _client->getRTTService()->deregisterRTTLobbyCallback();
    _lobbyRTTCallback.setEventBlock(nil, nil);
}

-(void) registerRTTPresenceCallback:(BCRTTEventBlock)eventBlock
                           cbObject:(BCCallbackObject)cbObject
{
    _presenceRTTCallback.setEventBlock(eventBlock, cbObject);
    _client->getRTTService()->registerRTTPresenceCallback(&_presenceRTTCallback);
}
-(void) deregisterRTTPresenceCallback
{
    _client->getRTTService()->deregisterRTTPresenceCallback();
    _presenceRTTCallback.setEventBlock(nil, nil);
}

-(void) registerRTTBlockchainRefresh:(BCRTTEventBlock)eventBlock
                            cbObject:(BCCallbackObject)cbObject
{
    _blockchainRefreshRTTCallback.setEventBlock(eventBlock, cbObject);
    _client->getRTTService()->registerRTTBlockchainRefresh(&_blockchainRefreshRTTCallback);
}
-(void) deregisterRTTBlockchainRefresh
{
    _client->getRTTService()->deregisterRTTBlockchainRefresh();
    _blockchainRefreshRTTCallback.setEventBlock(nil, nil);
}

-(void) deregisterAllRTTCallbacks
{
    _client->getRTTService()->deregisterAllRTTCallbacks();
    _eventRTTCallback.setEventBlock(nil, nil);
    _chatRTTCallback.setEventBlock(nil, nil);
    _messagingRTTCallback.setEventBlock(nil, nil);
    _lobbyRTTCallback.setEventBlock(nil, nil);
    _presenceRTTCallback.setEventBlock(nil, nil);
    _blockchainRefreshRTTCallback.setEventBlock(nil, nil);
}

#pragma mark - Properties

- (BOOL)rttEnabled
{
    return _client->getRTTService()->getRTTEnabled() ? YES : NO;
}

- (NSString*)rttConnectionId
{
    return [NSString stringWithUTF8String:_client->getRTTService()->getRTTConnectionId().c_str()];
}

@end

