//
//  BrainCloudRTT.hh
//  BrainCloud
//
//  Created by David St-Louis on 2020-08-17.
//  Copyright © 2020 BitHeads Inc. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

static const uint64_t BC_ALL_PLAYERS_MASK = 0x000000FFFFFFFFFF;

typedef NS_ENUM(NSUInteger, BCRelayConnectionType)
{
    BC_CONNECTION_TYPE_UDP = 0, /* User Datagram Protocol */
    BC_CONNECTION_TYPE_TCP = 1, /* Transmission Control Protocol */
    BC_CONNECTION_TYPE_WS  = 2, /* WebSocket */
    BC_CONNECTION_TYPE_WSS = 3  /* WebSocket Secure */
};

@class BrainCloudClient;

@interface BrainCloudRelay : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Requests the event server address
 *
 * Service Name - RTTRegistration
 * Service Operation - REQUEST_CLIENT_CONNECTION
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
-(void) connect:(BCRelayConnectionType)connectionType
           host:(NSString*)host
           port:(int)port
       passcode:(NSString*)passcode
        lobbyId:(NSString*)lobbyId
 connectSuccess:(BCRelayConnectSuccessCompletionBlock)connectSuccess
 connectFailure:(BCRelayConnectFailureCompletionBlock)connectFailure
       cbObject:(BCCallbackObject)cbObject;

/**
 * Disconnects from the relay server
 */
-(void) disconnect;

/**
 * Terminate the match instance by the owner.
 */
-(void) endMatch:(NSString *)jsonPayload;

/**
 * Set the ping interval. Ping allows to keep the connection
 * alive, but also inform the player of his current ping.
 * The default is 1000 miliseconds interval. (1 seconds)
 */
-(void) setPingInterval:(int)intervalMS;

/**
 * Returns the profileId associated with a netId.
 */
-(NSString*) getProfileIdForNetId:(int)netId;

/**
 * Returns the netId associated with a profileId.
 */
-(int) getNetIdForProfileId:(NSString*)profileId;

/**
 * Returns the RTT connection id associated with a netId.
 */
-(NSString*) getCxIdForNetId:(int)netId;

/**
 * Returns the netId associated with an RTT connection id.
 */
-(int) getNetIdForCxId:(NSString*)cxId;

/**
 * Send a packet to peer(s)
 *
 * @param data Byte array for the data to send
 * @param toNetId The net id to send to, BC_ALL_PLAYERS_MASK to relay to all.
 * @param reliable Send this reliable or not.
 * @param ordered Receive this ordered or not.
 * @param channel 0, 1, 2 or 3
 */
-(void) send:(NSData*)data
     toNetId:(uint64_t)toNetId
    reliable:(BOOL)reliable
     ordered:(BOOL)ordered
     channel:(int)channel;

 /**
  * Send a packet to any players by using a mask
  *
  * @param data Byte array for the data to send
  * @param playerMask Mask of the players to send to. 0001 = netId 0, 0010 = netId 1, etc. If you pass BC_ALL_PLAYERS_MASK you will be included and you will get an echo for your message. Use sendToAll instead, you will be filtered out. You can manually filter out by : BC_ALL_PLAYERS_MASK &= ~(1 << myNetId)
  * @param reliable Send this reliable or not.
  * @param ordered Receive this ordered or not.
  * @param channel 0, 1, 2 or 3
  */
 -(void) sendToPlayers:(NSData*)data
            playerMask:(uint64_t)playerMask
              reliable:(BOOL)reliable
               ordered:(BOOL)ordered
               channel:(int)channel;

 /**
  * Send a packet to all except yourself
  *
  * @param data Byte array for the data to send
  * @param reliable Send this reliable or not.
  * @param ordered Receive this ordered or not.
  * @param channel 0, 1, 2 or 3
  */
 -(void) sendToAll:(NSData*)data
          reliable:(BOOL)reliable
           ordered:(BOOL)ordered
           channel:(int)channel;

/**
 * Register callback for relay messages coming from peers.
 *
 * @param eventBlock Block to call on Relay message
 * @param cbObject User object sent to the event block
 */
-(void) registerRelayCallback:(BCRelayEventBlock)eventBlock
                     cbObject:(BCCallbackObject)cbObject;
-(void) deregisterRelayCallback;

/**
 * Register callback for RelayServer system messages.
 *
 * # CONNECT
 * Received when a new member connects to the server.
 * {
 *   op: "CONNECT",
 *   profileId: "...",
 *   ownerId: "...",
 *   netId: #
 * }
 *
 * # NET_ID
 * Receive the Net Id assossiated with a profile Id. This is
 * sent for each already connected members once you
 * successfully connected.
 * {
 *   op: "NET_ID",
 *   profileId: "...",
 *   netId: #
 * }
 *
 * # DISCONNECT
 * Received when a member disconnects from the server.
 * {
 *   op: "DISCONNECT",
 *   profileId: "..."
 * }
 *
 * # MIGRATE_OWNER
 * If the owner left or never connected in a timely manner,
 * the relay-server will migrate the role to the next member
 * with the best ping. If no one else is currently connected
 * yet, it will be transferred to the next member in the
 * lobby members' list. This last scenario can only occur if
 * the owner connected first, then quickly disconnected.
 * Leaving only unconnected lobby members.
 * {
 *   op: "MIGRATE_OWNER",
 *   profileId: "..."
 * }
 *
 * @param eventBlock Called whenever a system message was received. function(json)
 * @param cbObject User object sent to the event block
 */
-(void) registerSystemCallback:(BCRelaySystemEventBlock)eventBlock
                      cbObject:(BCCallbackObject)cbObject;
-(void) deregisterSystemCallback;

@property(readonly) int ping;
@property(readonly) BOOL isConnected;
@property(readonly) NSString* ownerProfileId;
@property(readonly) NSString* ownerCxId;

@end

#pragma clang diagnostic pop
