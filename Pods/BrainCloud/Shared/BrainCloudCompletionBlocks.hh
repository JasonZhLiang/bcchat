//
//  BrainCloudCompletionBlocks.h
//  brainCloudClientObjc
//
//  Created by Ryan Homer on 30/4/2015.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#ifndef brainCloudClientObjc_BrainCloudCompletionBlocks_h
#define brainCloudClientObjc_BrainCloudCompletionBlocks_h
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <Foundation/Foundation.h>

typedef NSObject *BCCallbackObject;

/**
 * Completion block called when an api completes successfully.
 *
 * @param serviceName The service name of the api call (see ServiceName.hh)
 * @param serviceOperation The service operation of the api call (see ServiceOperation.hh)
 * @param jsonData The returned JSON data from the api call.
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCCompletionBlock)(NSString *serviceName, NSString *serviceOperation,
                                  NSString *jsonData, BCCallbackObject cbObject);

/**
 * Completion block called when an api call returns an error.
 *
 * @param serviceName The service name of the api call.
 * @param serviceOperation The service operation of the api call.
 * @param statusCode The status code of the error (see StatusCodes.hh)
 * @param reasonCode The reason code of the error (see ReasonCodes.hh)
 * @param jsonError The returned JSON data from the api call.
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCErrorCompletionBlock)(NSString *serviceName, NSString *serviceOperation,
                                       NSInteger statusCode, NSInteger reasonCode,
                                       NSString *jsonError, BCCallbackObject cbObject);

/**
 * Completion block called when an event is returned from brainCloud
 *
 * @param jsonData Returned data from the server
 */
typedef void (^BCEventCompletionBlock)(NSString *jsonData);

/**
 * Completion block called whenever an api call returns rewards data.
 *
 * @param jsonData The rewards JSON data. The format is as follows:
 * {
 *   "status": 200,
 *   "apiRewards": [
 *     {
 *       "service": "authenticationV2",
 *       "operation": "AUTHENTICATE",
 *       "rewards": {
 *         "rewardDetails": {
 *           // the reward depending on type (see docs)
 *         }
 *       }
 *     }
 *   ]
 * }
 */
typedef void (^BCRewardCompletionBlock)(NSString *jsonData);

/**
 * Completion block called when a file upload has completed.
 *
 * @param in_fileUploadId The file upload id
 * @param in_jsonResponse The json response describing the file details similar to this
 * {
 *  "status": 200,
 *  "data": {
 *   "fileList": [
 *    {
 *     "updatedAt": 1452603368201,
 *     "uploadedAt": null,
 *     "fileSize": 85470,
 *     "shareable": true,
 *     "createdAt": 1452603368201,
 *     "profileId": "bf8a1433-62d2-448e-b396-f3dbffff44",
 *     "gameId": "99999",
 *     "path": "test2",
 *     "filename": "testup.dat",
 *     "downloadUrl": "https://sharedprod.braincloudservers.com/s3/bc/g/99999/u/bf8a1433-62d2-448e-b396-f3dbffff44/f/test2/testup.dat"
 *     "cloudLocation": "bc/g/99999/u/bf8a1433-62d2-448e-b396-f3dbffff44/f/test2/testup.dat"
 *    }
 *   ]
 *  }
 * }
 */
typedef void (^BCFileUploadCompletedCompletionBlock)(NSString *fileUploadId, NSString *json);

/**
 * Completion block called when a file upload has failed.
 *
 * @param in_fileUploadId The file upload id
 * @param in_statusCode The http status of the operation (see StatusCode.hh)
 * @param in_reasonCode The reason code of the operation (see ReasonCodes.hh)
 * @param in_jsonResponse The json response describing the failure. This uses the usual brainCloud error
 * format similar to this:
 * {
 *   "status": 403,
 *   "reason_code": 40300,
 *   "status_message": "Message describing failure",
 *   "severity": "ERROR"
 * }
 */
typedef void (^BCFileUploadFailedCompletionBlock)(NSString *fileUploadId, NSInteger statusCode, NSInteger returnCode, NSString *json);

/**
 * The networkError method is invoked whenever a network error is encountered
 * communicating to the brainCloud server.
 *
 * Note this method is *not* invoked when FlushCachedMessages(true) is called.
 */
typedef void (^BCNetworkErrorCompletionBlock)(void);

/**
 * Completion block called when RTT connected successfully.
 *
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCRTTConnectSuccessCompletionBlock)(BCCallbackObject cbObject);

/**
 * Completion block called when RTT disconnected or failed to connect.
 *
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCRTTConnectFailureCompletionBlock)(NSString* errorMessage, BCCallbackObject cbObject);

/**
 * Event block called when receiving an RTT event.
 *
 * @param jsonData The returned JSON data from the RTT event.
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCRTTEventBlock)(NSString *jsonData, BCCallbackObject cbObject);

/**
 * Completion block called when Relay connected successfully.
 *
 * @param jsonData The returned JSON data from the Relay connect result.
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCRelayConnectSuccessCompletionBlock)(NSString* jsonData, BCCallbackObject cbObject);

/**
 * Completion block called when Relay disconnected or failed to connect.
 *
 * @param errorMessage The error message.
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCRelayConnectFailureCompletionBlock)(NSString* errorMessage, BCCallbackObject cbObject);

/**
 * Event block called when receiving a Relay message.
 *
 * @param netId Net Id of the member thism essage is from..
 * @param data Data received
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCRelayEventBlock)(int netId, NSData* data, BCCallbackObject cbObject);

/**
 * Event block called when receiving a Relay message.
 *
 * @param jsonResponse System message in json string.
 * @param cbObject The passed in callback object. If nil is passed in to the api, nil will
 * be returned in the completion block.
 */
typedef void (^BCRelaySystemEventBlock)(NSString* jsonResponse, BCCallbackObject cbObject);

#pragma clang diagnostic pop

#endif
