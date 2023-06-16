#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudMail.hh"

@interface BrainCloudMail ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudMail

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)sendBasicEmail:(NSString *)profileId
               subject:(NSString *)subject
                  body:(NSString *)body
       completionBlock:(BCCompletionBlock)cb
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getMailService()->sendBasicEmail(
        [profileId cStringUsingEncoding:NSUTF8StringEncoding], [subject cStringUsingEncoding:NSUTF8StringEncoding],
        [body cStringUsingEncoding:NSUTF8StringEncoding], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)sendAdvancedEmail:(NSString *)profileId
        jsonServiceParams:(NSString *)jsonServiceParams
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getMailService()->sendAdvancedEmail(
        [profileId cStringUsingEncoding:NSUTF8StringEncoding],
        [jsonServiceParams cStringUsingEncoding:NSUTF8StringEncoding], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)sendAdvancedEmailByAddress:(NSString *)emailAddress
                 jsonServiceParams:(NSString *)jsonServiceParams
                   completionBlock:(BCCompletionBlock)cb
              errorCompletionBlock:(BCErrorCompletionBlock)ecb
                          cbObject:(BCCallbackObject)cbObject
{
    _client->getMailService()->sendAdvancedEmailByAddress(
            [emailAddress cStringUsingEncoding:NSUTF8StringEncoding],
            [jsonServiceParams cStringUsingEncoding:NSUTF8StringEncoding], new BrainCloudCallback(cb, ecb, cbObject));
}

@end
