//
//  BrainCloudRTT.hh
//  BrainCloud
//
//  Created by David St-Louis on 2020-01-07.
//  Copyright © 2020 BitHeads Inc. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

typedef NS_ENUM(NSUInteger, BCRTTConnectionStatus)
{
    BC_RTT_CONNECTION_STATUS_CONNETED = 0,
    BC_RTT_CONNECTION_STATUS_DISCONNETED = 1,
    BC_RTT_CONNECTION_STATUS_CONNETING  = 2,
    BC_RTT_CONNECTION_STATUS_DISCONNETING = 3
};

@class BrainCloudClient;

@interface BrainCloudRTT : NSObject

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
-(void) requestClientConnection:(BCCompletionBlock)completionBlock
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;

/**
 * Enables Real Time event for this session.
 * Real Time events are disabled by default. Usually events
 * need to be polled using GET_EVENTS. By enabling this, events will
 * be received instantly when they happen through a TCP connection to an Event Server.
 *
 * This function will first call requestClientConnection, then connect to the address
 *
 * @param sucessCompletionBlock Block to call on return of successful connect
 * @param failureCompletionBlock Block to call on return of unsuccessful connect, or RTT disconnect
 * @param cbObject User object sent to the completion blocks
 * @param useWebSocket Use web sockets instead of TCP for the internal connections. Default is true
 */
-(void)              enableRTT:(BCRTTConnectSuccessCompletionBlock)successCompletionBlock
        failureCompletionBlock:(BCRTTConnectFailureCompletionBlock)failureCompletionBlock
                      cbObject:(BCCallbackObject)cbObject;

-(void)              enableRTT:(BOOL)useWebSocket
        successCompletionBlock:(BCRTTConnectSuccessCompletionBlock)successCompletionBlock
        failureCompletionBlock:(BCRTTConnectFailureCompletionBlock)failureCompletionBlock
                      cbObject:(BCCallbackObject)cbObject;

/**
 * Disables Real Time event for this session.
 */
-(void) disableRTT;

/**
 *Checks if RTT is enabled
 */
-(void) getRTTEnabled;

/**
 * Get the rtt connection status
 */
-(BCRTTConnectionStatus) getConnectionStatus;

/**
 * Listen to real time events.
 * 
 * Notes: RTT must be enabled for this app, and enableRTT must have been successfully called.
 * Only one event callback can be registered at a time. Calling this a second time will override the previous callback.
 * 
 * @param eventBlock Block to call on RTT event
 * @param cbObject User object sent to the event block
 */
-(void) registerRTTEventCallback:(BCRTTEventBlock)eventBlock
                        cbObject:(BCCallbackObject)cbObject;
-(void) deregisterRTTEventCallback;

/**
 * Listen to real time chat messages.
 * 
 * Notes: RTT must be enabled for this app, and enableRTT must have been successfully called.
 * Only one chat callback can be registered at a time. Calling this a second time will override the previous callback.
 * 
 * @param eventBlock Block to call on RTT event
 * @param cbObject User object sent to the event block
 */
-(void) registerRTTChatCallback:(BCRTTEventBlock)eventBlock
                       cbObject:(BCCallbackObject)cbObject;
-(void) deregisterRTTChatCallback;

/**
 * Listen to real time messaging.
 * 
 * Notes: RTT must be enabled for this app, and enableRTT must have been successfully called.
 * Only one messaging callback can be registered at a time. Calling this a second time will override the previous callback.
 * 
 * @param eventBlock Block to call on RTT event
 * @param cbObject User object sent to the event block
 */
-(void) registerRTTMessagingCallback:(BCRTTEventBlock)eventBlock
                            cbObject:(BCCallbackObject)cbObject;
-(void) deregisterRTTMessagingCallback;

/**
 * Listen to real time lobby events.
 * 
 * Notes: RTT must be enabled for this app, and enableRTT must have been successfully called.
 * Only one lobby callback can be registered at a time. Calling this a second time will override the previous callback.
 * 
 * @param eventBlock Block to call on RTT event
 * @param cbObject User object sent to the event block
 */
-(void) registerRTTLobbyCallback:(BCRTTEventBlock)eventBlock
                        cbObject:(BCCallbackObject)cbObject;
-(void) deregisterRTTLobbyCallback;

/**
 * Listen to real time presence events.
 * 
 * Notes: RTT must be enabled for this app, and enableRTT must have been successfully called.
 * Only one presence callback can be registered at a time. Calling this a second time will override the previous callback.
 * 
 * @param eventBlock Block to call on RTT event
 * @param cbObject User object sent to the event block
 */
-(void) registerRTTPresenceCallback:(BCRTTEventBlock)eventBlock
                           cbObject:(BCCallbackObject)cbObject;
-(void) deregisterRTTPresenceCallback;

/**
 * Listen to real time blockchain events.
 * 
 * Notes: RTT must be enabled for this app, and enableRTT must have been successfully called.
 * Only one presence callback can be registered at a time. Calling this a second time will override the previous callback.
 * 
 * @param eventBlock Block to call on RTT event
 * @param cbObject User object sent to the event block
 */
-(void) registerRTTBlockchainRefresh:(BCRTTEventBlock)eventBlock
                            cbObject:(BCCallbackObject)cbObject;
-(void) deregisterRTTBlockchainRefresh;

/**
 * Clear all set RTT callbacks
 */
-(void) deregisterAllRTTCallbacks;

@property(readonly) BOOL rttEnabled;
@property(readonly) NSString* rttConnectionId;

@end


#pragma clang diagnostic pop
