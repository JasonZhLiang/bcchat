//
//  BrainCloudRelay.mm
//  BrainCloud
//
//  Created by David St-Louis on 2020-08-17.
//  Copyright © 2020 BitHeads Inc. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "braincloud/RelayConnectionType.h"
#include "BrainCloudRelayConnectCallback.hh"
#include "BrainCloudRelayCallback.hh"
#include "BrainCloudRelaySystemCallback.hh"
#import "BrainCloudRelay.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudRelay()
{
    BrainCloud::BrainCloudClient *_client;
    BrainCloudRelayConnectCallback _connectCallback;
    BrainCloudRelayCallback _relayCallback;
    BrainCloudRelaySystemCallback _systemCallback;
}
@end

@implementation BrainCloudRelay

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}


-(void) connect:(BCRelayConnectionType)connectionType
           host:(NSString*)host
           port:(int)port
       passcode:(NSString*)passcode
        lobbyId:(NSString*)lobbyId
 connectSuccess:(BCRelayConnectSuccessCompletionBlock)connectSuccess
 connectFailure:(BCRelayConnectFailureCompletionBlock)connectFailure
       cbObject:(BCCallbackObject)cbObject
{
    _connectCallback.setCompletionBlocks(connectSuccess, connectFailure, cbObject);
    _client->getRelayService()->connect((BrainCloud::eRelayConnectionType)connectionType,
                                        [host UTF8String],
                                        port,
                                        [passcode UTF8String],
                                        [lobbyId UTF8String],
                                        &_connectCallback);
}

-(void) disconnect
{
    _client->getRelayService()->disconnect();
}

-(void) endMatch:(NSString *)jsonPayload
{
    std::string cppJsonPayload;
    if (jsonPayload != nil) cppJsonPayload = [jsonPayload cStringUsingEncoding:NSUTF8StringEncoding];

    _client->getRelayService()->endMatch(cppJsonPayload);
}

-(void) setPingInterval:(int)intervalMS
{
    _client->getRelayService()->setPingInterval(intervalMS);
}

-(NSString*) getProfileIdForNetId:(int)netId
{
    const auto& profileId = _client->getRelayService()->getProfileIdForNetId(netId);
    return [NSString stringWithUTF8String:profileId.c_str()];
}

-(int) getNetIdForProfileId:(NSString*)profileId
{
    return _client->getRelayService()->getNetIdForProfileId([profileId UTF8String]);
}

-(NSString*) getCxIdForNetId:(int)netId
{
    const auto& cxId = _client->getRelayService()->getCxIdForNetId(netId);
    return [NSString stringWithUTF8String:cxId.c_str()];
}

-(int) getNetIdForCxId:(NSString*)cxId
{
    return _client->getRelayService()->getNetIdForCxId([cxId UTF8String]);
}

-(void) send:(NSData*)data
     toNetId:(uint64_t)toNetId
    reliable:(BOOL)reliable
     ordered:(BOOL)ordered
     channel:(int)channel
{
    _client->getRelayService()->send((const uint8_t*)[data bytes],
                                     (int)[data length],
                                     toNetId,
                                     reliable ? true : false,
                                     ordered ? true : false,
                                     (BrainCloud::eRelayChannel)channel);
}

 -(void) sendToPlayers:(NSData*)data
            playerMask:(uint64_t)playerMask
              reliable:(BOOL)reliable
               ordered:(BOOL)ordered
               channel:(int)channel
{
    _client->getRelayService()->sendToPlayers((const uint8_t*)[data bytes],
                                              (int)[data length],
                                              playerMask,
                                              reliable ? true : false,
                                              ordered ? true : false,
                                              (BrainCloud::eRelayChannel)channel);
}

 -(void) sendToAll:(NSData*)data
          reliable:(BOOL)reliable
           ordered:(BOOL)ordered
           channel:(int)channel
{
    _client->getRelayService()->sendToAll((const uint8_t*)[data bytes],
                                          (int)[data length],
                                          reliable ? true : false,
                                          ordered ? true : false,
                                          (BrainCloud::eRelayChannel)channel);
}

-(void) registerRelayCallback:(BCRelayEventBlock)eventBlock
                     cbObject:(BCCallbackObject)cbObject
{
    _relayCallback.setCompletionBlock(eventBlock, cbObject);
    _client->getRelayService()->registerRelayCallback(&_relayCallback);
}

-(void) deregisterRelayCallback
{
    _client->getRelayService()->deregisterRelayCallback();
    _relayCallback.setCompletionBlock(NULL, NULL);
}

-(void) registerSystemCallback:(BCRelaySystemEventBlock)eventBlock
                      cbObject:(BCCallbackObject)cbObject
{
    _systemCallback.setCompletionBlock(eventBlock, cbObject);
    _client->getRelayService()->registerSystemCallback(&_systemCallback);
}

-(void) deregisterSystemCallback
{
    _client->getRelayService()->deregisterSystemCallback();
    _systemCallback.setCompletionBlock(NULL, NULL);
}


#pragma mark - Properties

-(int) ping
{
    return _client->getRelayService()->getPing();
}

-(BOOL) isConnected
{
    return _client->getRelayService()->isConnected() ? YES : NO;
}

-(NSString*) ownerProfileId
{
    const auto& ownerId = _client->getRelayService()->getOwnerProfileId();
    return [NSString stringWithUTF8String:ownerId.c_str()];
}

-(NSString*) ownerCxId
{
    const auto& ownerCxId = _client->getRelayService()->getOwnerCxId();
    return [NSString stringWithUTF8String:ownerCxId.c_str()];
}

@end
