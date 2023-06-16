#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudScript.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudScript ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudScript

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)runScript:(NSString *)scriptName
          jsonScriptData:(NSString *)jsonScriptData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;
{
    _client->getScriptService()->runScript(
        [scriptName cStringUsingEncoding:NSUTF8StringEncoding],
        [jsonScriptData cStringUsingEncoding:NSUTF8StringEncoding], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)scheduleRunScriptUTC:(NSString *)scriptName
              jsonScriptData:(NSString *)jsonScriptData
              startDateLocal:(NSDate *)startDateLocal
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    time_t time = [startDateLocal timeIntervalSince1970];
    struct tm *timeStruct = localtime(&time);

    _client->getScriptService()->scheduleRunScriptUTC(
        [scriptName UTF8String], [jsonScriptData UTF8String], timeStruct, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)scheduleRunScriptMillisUTC:(NSString *)scriptName
              jsonScriptData:(NSString *)jsonScriptData
              startDateUTC:(int64_t)startDateUTC
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->scheduleRunScriptMillisUTC(
    [scriptName UTF8String], [jsonScriptData UTF8String], startDateUTC, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)scheduleRunScriptMinutes:(NSString *)scriptName
                  jsonScriptData:(NSString *)jsonScriptData
                  minutesFromNow:(int)minutesFromNow
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->scheduleRunScriptMinutes(
        [scriptName UTF8String], [jsonScriptData UTF8String], minutesFromNow,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)runParentScript:(NSString *)scriptName
         jsonScriptData:(NSString *)jsonScriptData
        parentLevelName:(NSString *)parentLevelName
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->runParentScript(
        [scriptName UTF8String], [jsonScriptData UTF8String], [parentLevelName UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)cancelScheduledScript:(NSString *)jobId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->cancelScheduledScript(
        [jobId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)runPeerScript:(NSString *)scriptName
          jsonScriptData:(NSString *)jsonScriptData
                    peer:(NSString *)peer
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->runPeerScript(
        [scriptName cStringUsingEncoding:NSUTF8StringEncoding],
        [jsonScriptData cStringUsingEncoding:NSUTF8StringEncoding], [peer UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)runPeerScriptAsync:(NSString *)scriptName
            jsonScriptData:(NSString *)jsonScriptData
                      peer:(NSString *)peer
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->runPeerScriptAsync(
        [scriptName cStringUsingEncoding:NSUTF8StringEncoding],
        [jsonScriptData cStringUsingEncoding:NSUTF8StringEncoding], [peer UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

/**
 * Retrieves scripts scheduled to run up to and including the specified start time (UTC in ms).
 *
 * Service Name - Script
 * Service Operation - GET_SCHEDULED_CLOUD_SCRIPTS
 *
 * @param startDateUTC the date time
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getScheduledCloudScripts:(NSDate *)startDateUTC
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    time_t time = [startDateUTC timeIntervalSince1970];
    struct tm *timeStruct = localtime(&time);

    _client->getScriptService()->getScheduledCloudScripts(timeStruct, new BrainCloudCallback(cb, ecb, cbObject));
}

/**
 * Retrieves scripts currently running or queued.
 *
 * Service Name - Script
 * Service Operation - GET_RUNNING_OR_QUEUED_SCRIPTS
 *
 * @param startDateUTC the date time
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getRunningOrQueuedCloudScripts:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
        _client->getScriptService()->getRunningOrQueuedCloudScripts(new BrainCloudCallback(cb, ecb, cbObject));
}

@end
