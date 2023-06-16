//
//  BrainCloudPushNotification.hh
//  brainCloudClientObjc
//
//  Created by Ryan Homer on 2/5/2015.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@class PlatformObjc;
@interface BrainCloudPushNotification : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
 * Deregisters all device tokens currently registered to the profile.
 *
 * @param cb Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)deregisterAllPushNotificationDeviceTokens:(BCCompletionBlock)cb
                             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                         cbObject:(BCCallbackObject)cbObject;

/**
 * Deregisters the given device token from the server to disable this device
 * from receiving push notifications.
 *
 * @param platform The device platform being deregistered.
 * @param deviceToken The platform-dependant device token needed for push notifications.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */ -(void)deregisterPushNotificationDeviceToken
    : (PlatformObjc *)platform deviceToken : (NSString *)deviceToken completionBlock
                                             : (BCCompletionBlock)cb errorCompletionBlock
                                               : (BCErrorCompletionBlock)ecb cbObject : (BCCallbackObject)cbObject;

/**
* Registers the given device token with the server to enable this device
* to receive push notifications.
*
* @param deviceType The type of device
* @param deviceToken The platform-dependant device token needed for push notifications.
*   On IOS, this is obtained using the application:didRegisterForRemoteNotificationsWithDeviceToken callback
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)registerPushNotificationDeviceToken:(PlatformObjc *)platform
                                deviceToken:(NSString *)deviceToken
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject;

/**
 * Registers the given device token with the server to enable this device
 * to receive push notifications.
 *
 * @param deviceType The type of device
 * @param deviceToken The platform-dependant device token needed for push notifications.
 *   On IOS, this is obtained using the application:didRegisterForRemoteNotificationsWithDeviceToken callback
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)registerPushNotificationDeviceTokenData:(PlatformObjc *)platform
                                    deviceToken:(NSData *)deviceToken
                                completionBlock:(BCCompletionBlock)cb
                           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                       cbObject:(BCCallbackObject)cbObject;

/**
* Sends a simple push notification based on the passed in message.
* NOTE: It is possible to send a push notification to oneself.
*
* @param toProfileId The braincloud profileId of the user to receive the notification
* @param message Text of the push notification
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)sendSimplePushNotification:(NSString *)toProfileId
                           message:(NSString *)message
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject;

/**
* Sends a notification to a user based on a brainCloud portal configured notification template.
* NOTE: It is possible to send a push notification to oneself.
*
* @param toProfileId The braincloud profileId of the user to receive the notification
* @param notificationTemplateId Id of the notification template
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)sendRichPushNotification:(NSString *)toProfileId
          notificationTemplateId:(int)notificationTemplateId
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
* Sends a notification to a user based on a brainCloud portal configured notification template.
* Includes JSON defining the substitution params to use with the template.
* See the Portal documentation for more info.
* NOTE: It is possible to send a push notification to oneself.
*
* @param toProfileId The braincloud profileId of the user to receive the notification
* @param notificationTemplateId Id of the notification template
* @param substitutionJson JSON defining the substitution params to use with the template
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)sendRichPushNotificationWithParams:(NSString *)toProfileId
                    notificationTemplateId:(int)notificationTemplateId
                          substitutionJson:(NSString *)substitutionJson
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject;

/**
 * Sends a notification to a "group" of user based on a brainCloud portal configured notification template.
 * Includes JSON defining the substitution params to use with the template.
 * See the Portal documentation for more info.
 *
 * @param groupId Target group
 * @param notificationTemplateId Template to use
 * @param substitutionsJson Map of substitution positions to strings
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)sendTemplatedPushNotificationToGroup:(NSString *)groupId
                      notificationTemplateId:(int)notificationTemplateId
                           substitutionsJson:(NSString *)substitutionsJson
                             completionBlock:(BCCompletionBlock)cb
                        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                    cbObject:(BCCallbackObject)cbObject;

/**
 * Sends a notification to a "group" of user consisting of alert content and custom data.
 * See the Portal documentation for more info.
 *
 * @param groupId Target group
 * @param alertContentJson Body and title of alert
 * @param customDataJson Optional custom data
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)sendNormalizedPushNotificationToGroup:(NSString *)groupId
                             alertContentJson:(NSString *)alertContentJson
                               customDataJson:(NSString *)customDataJson
                              completionBlock:(BCCompletionBlock)cb
                         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                     cbObject:(BCCallbackObject)cbObject;

/**
 * Schedules raw notifications based on user local time.
 *
 * @param profileId The profileId of the user to receive the notification
 * @param fcmContent Valid Fcm data content
 * @param iosContent Valid ios data content
 * @param facebookContent Facebook template string
 * @param startTimeUTC UTC Start time of sending the push notification
 * @param callback The method to be invoked when the server response is received
 */
- (void)scheduleRawPushNotificationUTC:(NSString *)profileId
                            fcmContent:(NSString *)fcmContent
                            iosContent:(NSString *)iosContent
                       facebookContent:(NSString *)facebookContent
                             startTimeUTC:(int64_t)startTimeUTC
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject;

/**
 * Schedules raw notifications based on user local time.
 *
 * @param profileId The profileId of the user to receive the notification
 * @param fcmContent Valid Fcm data content
 * @param iosContent Valid ios data content
 * @param facebookContent Facebook template string
 * @param minutesFromNow Minutes from now to send the push notification
 * @param callback The method to be invoked when the server response is received
 */
- (void)scheduleRawPushNotificationMinutes:(NSString *)profileId
                                fcmContent:(NSString *)fcmContent
                                iosContent:(NSString *)iosContent
                           facebookContent:(NSString *)facebookContent
                            minutesFromNow:(int)minutesFromNow
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject;

/**
 * Sends a raw push notification to a target user.
 *
 * @param toProfileId The profileId of the user to receive the notification
 * @param fcmContent Valid Fcm data content
 * @param iosContent Valid ios data content
 * @param facebookContent Facebook template string
 * @param callback The method to be invoked when the server response is received
 */
- (void)sendRawPushNotification:(NSString *)toProfileId
                     fcmContent:(NSString *)fcmContent
                     iosContent:(NSString *)iosContent
                facebookContent:(NSString *)facebookContent
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject;

/**
 * Sends a raw push notification to a target list of users.
 *
 * @param profileIds Collection of profile IDs to send the notification to
 * @param fcmContent Valid Fcm data content
 * @param iosContent Valid ios data content
 * @param facebookContent Facebook template string
 * @param callback The method to be invoked when the server response is received
 */
- (void)sendRawPushNotificationBatch:(NSArray *)profileIds
                          fcmContent:(NSString *)fcmContent
                          iosContent:(NSString *)iosContent
                     facebookContent:(NSString *)facebookContent
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject;

/**
 * Sends a raw push notification to a target group.
 *
 * @param groupId Target group
 * @param fcmContent Valid Fcm data content
 * @param iosContent Valid ios data content
 * @param facebookContent Facebook template string
 * @param callback The method to be invoked when the server response is received
 */
- (void)sendRawPushNotificationToGroup:(NSString *)groupId
                            fcmContent:(NSString *)fcmContent
                            iosContent:(NSString *)iosContent
                       facebookContent:(NSString *)facebookContent
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject;

/**
 * Schedules a normalized push notification to a user
 *
 * @param profileId The profileId of the user to receive the notification
 * @param alertContentJson Body and title of alert
 * @param customDataJson Optional custom data
 * @param startTimeUTC UTCStart time of sending the push notification
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)scheduleNormalizedPushNotificationUTC:(NSString *)toProfileId
                             alertContentJson:(NSString *)alertContentJson
                               customDataJson:(NSString *)customDataJson
                                    startTimeUTC:(int64_t)startTimeUTC
                              completionBlock:(BCCompletionBlock)cb
                         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                     cbObject:(BCCallbackObject)cbObject;

/**
 * Schedules a normalized push notification to a user
 *
 * @param profileId The profileId of the user to receive the notification
 * @param alertContentJson Body and title of alert
 * @param customDataJson Optional custom data
 * @param minutesFromNow Minutes from now to send the push notification
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)scheduleNormalizedPushNotificationMinutes:(NSString *)toProfileId
                                 alertContentJson:(NSString *)alertContentJson
                                   customDataJson:(NSString *)customDataJson
                                   minutesFromNow:(int)minutesFromNow
                                  completionBlock:(BCCompletionBlock)cb
                             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                         cbObject:(BCCallbackObject)cbObject;

/**
 * Schedules a rich push notification to a user
 *
 * @param profileId The profileId of the user to receive the notification
 * @param notificationTemplateId Body and title of alert
 * @param substitutionJson Map of substitution positions to strings
 * @param startTimeUTC UTC Start time of sending the push notification
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)scheduleRichPushNotificationUTC:(NSString *)toProfileId
                 notificationTemplateId:(int)notificationTemplateId
                       substitutionJson:(NSString *)substitutionJson
                              startTimeUTC:(int64_t)startTimeUTC
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject;

/**
 * Schedules a rich push notification to a user
 *
 * @param profileId The profileId of the user to receive the notification
 * @param notificationTemplateId Body and title of alert
 * @param substitutionJson Map of substitution positions to strings
 * @param minutesFromNow Minutes from now to send the push notification
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)scheduleRichPushNotificationMinutes:(NSString *)toProfileId
                     notificationTemplateId:(int)notificationTemplateId
                           substitutionJson:(NSString *)substitutionJson
                             minutesFromNow:(int)minutesFromNow
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject;

/**
 * Sends a notification to a user consisting of alert content and custom data.
 *
 * @param toProfileId The profileId of the user to receive the notification
 * @param alertContent Body and title of alert
 * @param customData Optional custom data
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)sendNormalizedPushNotification:(NSString *)profileId
                      alertContentJson:(NSString *)alertContentJson
                        customDataJson:(NSString *)customDataJson
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject;

/**
 * Sends a notification to multiple users consisting of alert content and custom data.
 *
 * @param profileIds Collection of profile IDs to send the notification to
 * @param alertContent Body and title of alert
 * @param customData Optional custom data
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)sendNormalizedPushNotificationBatch:(NSArray *)profileIds
                           alertContentJson:(NSString *)alertContentJson
                             customDataJson:(NSString *)customDataJson
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject;

@end

#pragma clang diagnostic pop
