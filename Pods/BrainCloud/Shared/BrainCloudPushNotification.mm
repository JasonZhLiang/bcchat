//
//  BrainCloudPushNotification.mm
//  brainCloudClientObjc
//
//  Created by Ryan Homer on 2/5/2015.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "BrainCloudCallback.hh"
#import "BrainCloudPushNotification.hh"
#import "PlatformObjc.hh"
#include "braincloud/BrainCloudClient.h"
#include "braincloud/Platform.h"
#import "BrainCloudClient.hh"


@interface BrainCloudPushNotification ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudPushNotification

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)deregisterAllPushNotificationDeviceTokens:(BCCompletionBlock)cb
                             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                         cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    _client
        ->getPushNotificationService()
        ->deregisterAllPushNotificationDeviceTokens(brainCloudCallback);
}

- (void)deregisterPushNotificationDeviceToken:(PlatformObjc *)platform
                                  deviceToken:(NSString *)deviceToken
                              completionBlock:(BCCompletionBlock)cb
                         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                     cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string platformStr = [[platform toString] UTF8String];
    BrainCloud::Platform cppPlatform = BrainCloud::Platform::fromString(platformStr);
    _client->getPushNotificationService()->deregisterPushNotificationDeviceToken(
        cppPlatform, [deviceToken cStringUsingEncoding:NSUTF8StringEncoding], brainCloudCallback);
}

- (void)registerPushNotificationDeviceToken:(PlatformObjc *)platform
                                deviceToken:(NSString *)deviceToken
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    _client->getPushNotificationService()->registerPushNotificationDeviceToken(
        BrainCloud::Platform::fromString([[platform toString] UTF8String]),
        [deviceToken cStringUsingEncoding:NSUTF8StringEncoding], brainCloudCallback);
}

- (void)registerPushNotificationDeviceTokenData:(PlatformObjc *)platform
                                    deviceToken:(NSData *)deviceToken
                                completionBlock:(BCCompletionBlock)cb
                           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                       cbObject:(BCCallbackObject)cbObject
{
    const uint32_t *tokenBytes = (const uint32_t *)[deviceToken bytes];
    NSString *nsDeviceToken =
        [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x", ntohl(tokenBytes[0]), ntohl(tokenBytes[1]),
                                   ntohl(tokenBytes[2]), ntohl(tokenBytes[3]), ntohl(tokenBytes[4]),
                                   ntohl(tokenBytes[5]), ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    [self registerPushNotificationDeviceToken:platform
                                  deviceToken:nsDeviceToken
                              completionBlock:cb
                         errorCompletionBlock:ecb
                                     cbObject:cbObject];
}

- (void)sendSimplePushNotification:(NSString *)toProfileId
                           message:(NSString *)message
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    _client->getPushNotificationService()->sendSimplePushNotification(
        [toProfileId UTF8String], [message UTF8String], brainCloudCallback);
}

- (void)sendRichPushNotification:(NSString *)toProfileId
          notificationTemplateId:(int)notificationTemplateId
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    _client->getPushNotificationService()->sendRichPushNotification(
        [toProfileId UTF8String], notificationTemplateId, brainCloudCallback);
}

- (void)sendRichPushNotificationWithParams:(NSString *)toProfileId
                    notificationTemplateId:(int)notificationTemplateId
                          substitutionJson:(NSString *)substitutionJson
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    _client->getPushNotificationService()->sendRichPushNotificationWithParams(
        [toProfileId UTF8String], notificationTemplateId, [substitutionJson UTF8String], brainCloudCallback);
}

- (void)sendTemplatedPushNotificationToGroup:(NSString *)groupId
                      notificationTemplateId:(int)notificationTemplateId
                           substitutionsJson:(NSString *)substitutionsJson
                             completionBlock:(BCCompletionBlock)cb
                        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                    cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    _client->getPushNotificationService()->sendTemplatedPushNotificationToGroup(
        [groupId UTF8String], notificationTemplateId, [substitutionsJson UTF8String], brainCloudCallback);
}

- (void)sendNormalizedPushNotificationToGroup:(NSString *)groupId
                             alertContentJson:(NSString *)alertContentJson
                               customDataJson:(NSString *)customDataJson
                              completionBlock:(BCCompletionBlock)cb
                         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                     cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string custom;
    if (customDataJson != nil) custom = [customDataJson UTF8String];

    _client->getPushNotificationService()->sendNormalizedPushNotificationToGroup(
        [groupId UTF8String], [alertContentJson UTF8String], custom, brainCloudCallback);
}

- (void)scheduleRawPushNotificationUTC:(NSString *)profileId
                            fcmContent:(NSString *)fcmContent
                            iosContent:(NSString *)iosContent
                       facebookContent:(NSString *)facebookContent
                             startTimeUTC:(int64_t)startTimeUTC
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string fcm;
    if (fcmContent != nil) fcm = [fcmContent UTF8String];

    std::string ios;
    if (iosContent != nil) ios = [iosContent UTF8String];

    std::string facebook;
    if (facebookContent != nil) facebook = [facebookContent UTF8String];

    _client->getPushNotificationService()->scheduleRawPushNotificationUTC(
            [profileId UTF8String], fcm, ios, facebook, startTimeUTC, brainCloudCallback);
}

- (void)scheduleRawPushNotificationMinutes:(NSString *)profileId
                                fcmContent:(NSString *)fcmContent
                                iosContent:(NSString *)iosContent
                           facebookContent:(NSString *)facebookContent
                            minutesFromNow:(int)minutesFromNow
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string fcm;
    if (fcmContent != nil) fcm = [fcmContent UTF8String];

    std::string ios;
    if (iosContent != nil) ios = [iosContent UTF8String];

    std::string facebook;
    if (facebookContent != nil) facebook = [facebookContent UTF8String];

    _client->getPushNotificationService()->scheduleRawPushNotificationUTC(
            [profileId UTF8String], fcm, ios, facebook, minutesFromNow, brainCloudCallback);
}

- (void)sendRawPushNotification:(NSString *)toProfileId
                     fcmContent:(NSString *)fcmContent
                     iosContent:(NSString *)iosContent
                facebookContent:(NSString *)facebookContent
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string fcm;
    if (fcmContent != nil) fcm = [fcmContent UTF8String];

    std::string ios;
    if (iosContent != nil) ios = [iosContent UTF8String];

    std::string facebook;
    if (facebookContent != nil) facebook = [facebookContent UTF8String];

    _client->getPushNotificationService()->sendRawPushNotification(
            [toProfileId UTF8String], fcm, ios, facebook, brainCloudCallback);
}

- (void)sendRawPushNotificationBatch:(NSArray *)profileIds
                          fcmContent:(NSString *)fcmContent
                          iosContent:(NSString *)iosContent
                     facebookContent:(NSString *)facebookContent
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::vector<std::string> lbIds;
    for (NSString *nsid in profileIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }

    std::string fcm;
    if (fcmContent != nil) fcm = [fcmContent UTF8String];

    std::string ios;
    if (iosContent != nil) ios = [iosContent UTF8String];

    std::string facebook;
    if (facebookContent != nil) facebook = [facebookContent UTF8String];

    _client->getPushNotificationService()->sendRawPushNotificationBatch(
            lbIds, fcm, ios, facebook, brainCloudCallback);
}

- (void)sendRawPushNotificationToGroup:(NSString *)groupId
                            fcmContent:(NSString *)fcmContent
                            iosContent:(NSString *)iosContent
                       facebookContent:(NSString *)facebookContent
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string fcm;
    if (fcmContent != nil) fcm = [fcmContent UTF8String];

    std::string ios;
    if (iosContent != nil) ios = [iosContent UTF8String];

    std::string facebook;
    if (facebookContent != nil) facebook = [facebookContent UTF8String];

    _client->getPushNotificationService()->sendRawPushNotificationToGroup(
            [groupId UTF8String], fcm, ios, facebook, brainCloudCallback);
}

- (void)scheduleNormalizedPushNotificationUTC:(NSString *)toProfileId
                             alertContentJson:(NSString *)alertContentJson
                               customDataJson:(NSString *)customDataJson
                                    startTimeUTC:(int64_t)startTimeUTC
                              completionBlock:(BCCompletionBlock)cb
                         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                     cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string custom;
    if (customDataJson != nil) custom = [customDataJson UTF8String];

    _client->getPushNotificationService()->scheduleNormalizedPushNotificationUTC(
            [toProfileId UTF8String], [alertContentJson UTF8String], custom, startTimeUTC, brainCloudCallback);
}

- (void)scheduleNormalizedPushNotificationMinutes:(NSString *)toProfileId
                                 alertContentJson:(NSString *)alertContentJson
                                   customDataJson:(NSString *)customDataJson
                                   minutesFromNow:(int)minutesFromNow
                                  completionBlock:(BCCompletionBlock)cb
                             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                         cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string custom;
    if (customDataJson != nil) custom = [customDataJson UTF8String];


    _client->getPushNotificationService()->scheduleNormalizedPushNotificationMinutes(
            [toProfileId UTF8String], [alertContentJson UTF8String], custom, minutesFromNow, brainCloudCallback);
}

- (void)scheduleRichPushNotificationUTC:(NSString *)toProfileId
                 notificationTemplateId:(int)notificationTemplateId
                       substitutionJson:(NSString *)substitutionJson
                              startTimeUTC:(int64_t)startTimeUTC
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string substitutions;
    if (substitutionJson != nil) substitutions = [substitutionJson UTF8String];

    _client->getPushNotificationService()->scheduleRichPushNotificationUTC(
            [toProfileId UTF8String], notificationTemplateId, substitutions, startTimeUTC, brainCloudCallback);
}

- (void)scheduleRichPushNotificationMinutes:(NSString *)toProfileId
                     notificationTemplateId:(int)notificationTemplateId
                           substitutionJson:(NSString *)substitutionJson
                             minutesFromNow:(int)minutesFromNow
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string substitutions;
    if (substitutionJson != nil) substitutions = [substitutionJson UTF8String];

    _client->getPushNotificationService()->scheduleRichPushNotificationMinutes(
            [toProfileId UTF8String], notificationTemplateId, substitutions, minutesFromNow, brainCloudCallback);
}

- (void)sendNormalizedPushNotification:(NSString *)profileId
                      alertContentJson:(NSString *)alertContentJson
                        customDataJson:(NSString *)customDataJson
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string custom;
    if (customDataJson != nil) custom = [customDataJson UTF8String];

    _client->getPushNotificationService()->sendNormalizedPushNotification(
        [profileId UTF8String], [alertContentJson UTF8String], custom, brainCloudCallback);
}

- (void)sendNormalizedPushNotificationBatch:(NSArray *)profileIds
                           alertContentJson:(NSString *)alertContentJson
                             customDataJson:(NSString *)customDataJson
                            completionBlock:(BCCompletionBlock)cb
                       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                   cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback = new BrainCloudCallback(cb, ecb, cbObject);

    std::string custom;
    if (customDataJson != nil) custom = [customDataJson UTF8String];

    std::vector<std::string> lbIds;
    for (NSString *nsid in profileIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }

    _client->getPushNotificationService()->sendNormalizedPushNotificationBatch(
        lbIds, [alertContentJson UTF8String], custom, brainCloudCallback);
}

@end
