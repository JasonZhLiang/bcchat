#import "BrainCloudWrapper.hh"
#import "BrainCloudSaveDataHelper.h"

@interface BrainCloudWrapper ()

@property (strong, nonatomic) BrainCloudSaveDataHelper *helper;

@property (copy, nonatomic) NSString *lastAppId;
@property (copy, nonatomic) NSString *lastAppVersion;
@property (copy, nonatomic) NSString *lastSecretKey;
@property (strong, nonatomic) NSString *lastServerUrl;

@property (copy, nonatomic) NSString *wrapperName;

@property (copy) BCCompletionBlock authSuccessCompletionBlock;
@property (copy) BCErrorCompletionBlock authErrorCompletionBlock;

@property (strong, nonatomic) BrainCloudClient *bcClient;

@end

@interface AuthenticationCallbackObject : NSObject
@property (strong, nonatomic) BCCompletionBlock completionBlock;
@property (strong, nonatomic) BCErrorCompletionBlock errorCompletionBlock;
@property (strong, nonatomic) BCCallbackObject cbObject;
@end

@implementation AuthenticationCallbackObject
@end

@implementation BrainCloudWrapper

NSString * const kAuthenticationAnonymous          = @"anonymous";
NSString * const kPersistenceKeyAnonymousId        = @"anonymousId";
NSString * const kPersistenceKeyAuthenticationType = @"authenticationType";
NSString * const kPersistenceKeyProfileId          = @"profileId";


#pragma mark - Getters & Setters

static BrainCloudWrapper *sharedWrapper = nil;

+ (BrainCloudWrapper *) getInstance
{
    NSAssert([BrainCloudClient getEnableSingletonMode], @"Singleton usage is disabled. If called by mistake, use your own variable that holds an instance of the bcWrapper/bcClient.");
    
    @synchronized(self) {
        if(sharedWrapper == nil) {
            sharedWrapper = [[self alloc] init];
            
            [sharedWrapper setupCallBacks];
            
            [BrainCloudClient setInstance:[sharedWrapper getBCClient]];
        }
    }

    return sharedWrapper;
}

-(void) setupCallBacks
{
    self.alwaysAllowProfileSwitch = YES;
    
	__typeof__(self) __weak weakSelf = self;
	
    // the generic authentication completion blocks
    self.authSuccessCompletionBlock = ^(NSString *serviceName, NSString *serviceOperation, NSString *jsonData, BCCallbackObject cbObject)
    {
        NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
		
		weakSelf.storedProfileId = [(NSDictionary *)[jsonObj objectForKey:@"data"] objectForKey:@"profileId"];

        AuthenticationCallbackObject *aco = (AuthenticationCallbackObject*) cbObject;
        if (aco.completionBlock != nil)
        {
            aco.completionBlock(serviceName, serviceOperation, jsonData, aco.cbObject);
        }
    };
    
    self.authErrorCompletionBlock = ^(NSString *serviceName, NSString *serviceOperation, NSInteger statusCode, NSInteger returnCode, NSString *jsonError, BCCallbackObject cbObject)
    {
        AuthenticationCallbackObject *aco = (AuthenticationCallbackObject*) cbObject;
        if (aco.errorCompletionBlock != nil)
        {
            aco.errorCompletionBlock(serviceName, serviceOperation, statusCode, returnCode, jsonError, aco.cbObject);
        }
    };

}

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        self.wrapperName = @"";
        _bcClient = [[BrainCloudClient alloc] init];
        [self setupCallBacks];
    }

    return self;
}



- (instancetype) init: (NSString*) wrapperName
{
    self = [super init];
    
    if(self)
    {
        self.wrapperName = wrapperName;
        _bcClient = [[BrainCloudClient alloc] init];
        [self setupCallBacks];
    }
    
    return self;
}

+ (BrainCloudClient *) getBC
{
    return [[self getInstance] getBCClient];
}

- (BrainCloudClient *) getBCClient
{
    return _bcClient;
}

- (NSString *) makePrefixedName: (NSString*) name
{
    NSString *prefix = _wrapperName == nil || [_wrapperName isEqualToString:@""] ? @"" : [_wrapperName stringByAppendingString:@"."];
    return [prefix stringByAppendingString:name];

}

- (void)setStoredAnonymousId:(NSString *)storedAnonymousId
{
    [self.helper saveString:storedAnonymousId forKey:[self makePrefixedName:kPersistenceKeyAnonymousId]];
}

- (NSString *)storedAnonymousId
{
    return [self.helper stringForKey:[self makePrefixedName:kPersistenceKeyAnonymousId]];
}

- (void)setStoredAuthenticationType:(NSString *)storedAuthenticationType
{
    [self.helper saveString:storedAuthenticationType forKey:[self makePrefixedName:kPersistenceKeyAuthenticationType]];
}

- (NSString *)storedAuthenticationType
{
    return [self.helper stringForKey:[self makePrefixedName:kPersistenceKeyAuthenticationType]];
}

- (void)setStoredProfileId:(NSString *)storedProfileId
{
    [self.helper saveString:storedProfileId forKey:[self makePrefixedName:kPersistenceKeyProfileId]];
}

- (NSString *)storedProfileId
{
    return [self.helper stringForKey:[self makePrefixedName:kPersistenceKeyProfileId]];
}

#pragma mark - C++ Initialization


- (void)initialize:(NSString *)serverUrl
         secretKey:(NSString *)secretKey
            gameId:(NSString *)appId
       gameVersion:(NSString *)appVersion
       companyName:(NSString *)companyName
          gameName:(NSString *)appName
{
    self.lastAppId      = appId;
    self.lastAppVersion = appVersion;
    self.lastSecretKey   = secretKey;
    self.lastServerUrl   = serverUrl;

    [_bcClient initialize:serverUrl
                                     secretKey:secretKey
                                         appId:appId
                                    appVersion:appVersion];

    self.helper = [[BrainCloudSaveDataHelper alloc] initWithCompanyName:companyName appName:appName];
}

- (void)initialize:(NSString *)serverUrl
         secretKey:(NSString *)secretKey
            appId:(NSString *)appId
       version:(NSString *)appVersion
       companyName:(NSString *)companyName
          appName:(NSString *)appName
{
    self.lastAppId      = appId;
    self.lastAppVersion = appVersion;
    self.lastSecretKey   = secretKey;
    self.lastServerUrl   = serverUrl;

    [_bcClient initialize:serverUrl
                                     secretKey:secretKey
                                         appId:appId
                                    appVersion:appVersion];

    self.helper = [[BrainCloudSaveDataHelper alloc] initWithCompanyName:companyName appName:appName];
}



- (void)initialize:(NSString *)serverUrl
         secretKey:(NSString *)secretKey
             appId:(NSString *)appId
        appVersion:(NSString *)appVersion
       companyName:(NSString *)companyName
           appName:(NSString *)appName
{
    self.lastAppId      = appId;
    self.lastAppVersion = appVersion;
    self.lastSecretKey   = secretKey;
    self.lastServerUrl   = serverUrl;

    [_bcClient initialize:serverUrl
                                     secretKey:secretKey
                                         appId:appId
                                    appVersion:appVersion];
        
    self.helper = [[BrainCloudSaveDataHelper alloc] initWithCompanyName:companyName appName:appName];
}

- (void)initializeWithApps:(NSString *)serverUrl
              defaultAppId:(NSString *)defaultAppId
                 secretMap:(NSDictionary *)secretMap
                appVersion:(NSString *)appVersion
               companyName:(NSString *)companyName
                   appName:(NSString *)appName;
{
    self.lastAppId       = defaultAppId;
    self.lastAppVersion  = appVersion;
    self.lastSecretKey   = [secretMap objectForKey:defaultAppId];
    self.lastServerUrl   = serverUrl;

    [_bcClient initializeWithApps:serverUrl
                     defaultAppId:defaultAppId
                        secretMap:secretMap
                       appVersion:appVersion];
        
    self.helper = [[BrainCloudSaveDataHelper alloc] initWithCompanyName:companyName appName:appName];
}

- (void)_initializeIdentity:(BOOL) isAnonymousAuth
{
    NSString *profileId = self.storedProfileId;
    NSString *anonymousId = self.storedAnonymousId;
    if (profileId != nil && [profileId length] == 0)
    {
        profileId = nil;
    }
    if (anonymousId != nil && [anonymousId length] == 0)
    {
        anonymousId = nil;
    }
    
    if (nil == self.storedAnonymousId || (nil != self.storedAnonymousId && nil == self.storedProfileId))
    {
        anonymousId= [[_bcClient authenticationService] generateAnonymousId];
        profileId = @"";
        self.storedAnonymousId = anonymousId;
        self.storedProfileId = profileId;
    }
    
    NSString *profileIdToAuthenticateWith = profileId;
    if (!isAnonymousAuth && self.alwaysAllowProfileSwitch)
    {
        profileIdToAuthenticateWith = @"";
    }
    self.storedAuthenticationType = isAnonymousAuth ? kAuthenticationAnonymous : @"";
    
    // send our IDs to brainCloud
    [_bcClient initializeIdentity:profileIdToAuthenticateWith anonymousId:anonymousId];
}

- (void)authenticateAnonymous:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    [self authenticateAnonymous:completionBlock errorCompletionBlock:errorCompletionBlock cbObject:cbObject forceCreate:TRUE];

}

- (void)authenticateAnonymous:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
                  forceCreate:(BOOL)forceCreate
{
    [self _initializeIdentity:TRUE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateAnonymous:forceCreate
                                             completionBlock:self.authSuccessCompletionBlock
                                        errorCompletionBlock:self.authErrorCompletionBlock
                                                    cbObject:aco];
}

- (void)authenticateEmailPassword:(NSString *)email
                         password:(NSString *)password
                      forceCreate:(BOOL)forceCreate
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                         cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateEmailPassword:email
                                                        password:password
                                                     forceCreate:forceCreate
                                                 completionBlock:self.authSuccessCompletionBlock
                                            errorCompletionBlock:self.authErrorCompletionBlock
                                                                             cbObject:aco];
}

- (void)authenticateExternal:(NSString *)userId
         authenticationToken:(NSString *)authToken
  externalAuthenticationName:(NSString *)externalAuthName
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateExternal:userId
                                        authenticationToken:authToken
                                 externalAuthenticationName:externalAuthName
                                                forceCreate:forceCreate
                                            completionBlock:self.authSuccessCompletionBlock
                                       errorCompletionBlock:self.authErrorCompletionBlock
                                                   cbObject:aco];

}

- (void)authenticateFacebook:(NSString *)fbUserId
         authenticationToken:(NSString *)fbAuthToken
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateFacebook:fbUserId
                                        authenticationToken:fbAuthToken
                                                forceCreate:forceCreate
                                            completionBlock:self.authSuccessCompletionBlock
                                       errorCompletionBlock:self.authErrorCompletionBlock
                                                   cbObject:aco];
    
}

- (void)authenticateGameCenter:(NSString *)gameCenterId
                   forceCreate:(BOOL)forceCreate
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                      cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateGameCenter:gameCenterId
                                                  forceCreate:forceCreate
                                              completionBlock:self.authSuccessCompletionBlock
                                         errorCompletionBlock:self.authErrorCompletionBlock
                                                     cbObject:aco];
    
}

- (void)authenticateGoogle:(NSString *)googleUserId
                     token:(NSString *)serverAuthCode
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateGoogle:googleUserId
                                           serverAuthCode:serverAuthCode
                                              forceCreate:forceCreate
                                          completionBlock:self.authSuccessCompletionBlock
                                     errorCompletionBlock:self.authErrorCompletionBlock
                                                 cbObject:aco];
}

- (void)authenticateGoogleOpenId:(NSString *)googleUserAccountEmail
                         idToken:(NSString *)idToken
                     forceCreate:(BOOL)forceCreate
                 completionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateGoogleOpenId:googleUserAccountEmail
                                                        idToken:idToken
                                                    forceCreate:forceCreate
                                                completionBlock:self.authSuccessCompletionBlock
                                           errorCompletionBlock:self.authErrorCompletionBlock
                                                       cbObject:aco];
}

- (void)authenticateApple:(NSString *)appleUserId
            identityToken:(NSString *)identityToken
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateApple:appleUserId
                                                  identityToken:identityToken
                                                    forceCreate:forceCreate
                                                completionBlock:self.authSuccessCompletionBlock
                                           errorCompletionBlock:self.authErrorCompletionBlock
                                                       cbObject:aco];
}


- (void)authenticateSteam:(NSString *)userId
            sessionTicket:(NSString *)sessionticket
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateSteam:userId
                                           sessionTicket:sessionticket
                                             forceCreate:forceCreate
                                         completionBlock:self.authSuccessCompletionBlock
                                    errorCompletionBlock:self.authErrorCompletionBlock
                                                cbObject:aco];
}

- (void)authenticateUltra:(NSString *)ultraUsername
			 ultraIdToken:(NSString *)ultraIdToken
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateUltra:ultraUsername
                                            ultraIdToken:ultraIdToken
                                             forceCreate:forceCreate
                                         completionBlock:self.authSuccessCompletionBlock
                                    errorCompletionBlock:self.authErrorCompletionBlock
                                                cbObject:aco];
}

- (void)authenticateTwitter:(NSString *)userId
                      token:(NSString *)token
                     secret:(NSString *)secret
                forceCreate:(BOOL)forceCreate
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                   cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateTwitter:userId
                                                     token:token
                                                    secret:secret
                                               forceCreate:forceCreate
                                           completionBlock:self.authSuccessCompletionBlock
                                      errorCompletionBlock:self.authErrorCompletionBlock
                                                  cbObject:aco];
}

- (void)authenticateUniversal:(NSString *)userId
                     password:(NSString *)password
                  forceCreate:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateUniversal:userId
                                                    password:password
                                                 forceCreate:forceCreate
                                             completionBlock:self.authSuccessCompletionBlock
                                        errorCompletionBlock:self.authErrorCompletionBlock
                                                    cbObject:aco];
}


- (void)authenticateAdvanced:(AuthenticationTypeObjc *)authenticationType
           authenticationIds:(AuthenticationIdsObjc *)authenticationIds
                 forceCreate:(BOOL)forceCreate
                   extraJson:(NSString *)extraJson
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;
    
    [[_bcClient authenticationService] authenticateAdvanced:authenticationType
                                          authenticationIds:authenticationIds
                                                forceCreate:forceCreate
                                                  extraJson:extraJson
                                            completionBlock:self.authSuccessCompletionBlock
                                       errorCompletionBlock:self.authErrorCompletionBlock
                                                   cbObject:aco];
}




- (void)smartSwitchAuthenticateEmailPassword:(NSString *)email
                                    password:(NSString *)password
                                 forceCreate:(BOOL)forceCreate
                             completionBlock:(BCCompletionBlock)completionBlock
                        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                    cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    BCSmartSwitchCompletionBlock authCallback = ^() {
        
        AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
        aco.completionBlock = completionBlock;
        aco.errorCompletionBlock = errorCompletionBlock;
        aco.cbObject = cbObject;
        
		[[self->_bcClient authenticationService] authenticateEmailPassword:email
                                                            password:password
                                                         forceCreate:forceCreate
                                                     completionBlock:self.authSuccessCompletionBlock
                                                errorCompletionBlock:self.authErrorCompletionBlock
                                                            cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}


- (void)smartSwitchAuthenticateExternal:(NSString *)userId
         authenticationToken:(NSString *)authToken
  externalAuthenticationName:(NSString *)externalAuthName
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
    
    BCSmartSwitchCompletionBlock authCallback = ^() {

    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateExternal:userId
                                        authenticationToken:authToken
                                 externalAuthenticationName:externalAuthName
                                                forceCreate:forceCreate
                                            completionBlock:self.authSuccessCompletionBlock
                                       errorCompletionBlock:self.authErrorCompletionBlock
                                                   cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}

- (void)smartSwitchAuthenticateFacebook:(NSString *)fbUserId
         authenticationToken:(NSString *)fbAuthToken
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^() {
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateFacebook:fbUserId
                                        authenticationToken:fbAuthToken
                                                forceCreate:forceCreate
                                            completionBlock:self.authSuccessCompletionBlock
                                       errorCompletionBlock:self.authErrorCompletionBlock
                                                   cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}

- (void)smartSwitchAuthenticateGameCenter:(NSString *)gameCenterId
                   forceCreate:(BOOL)forceCreate
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                      cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^() {
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateGameCenter:gameCenterId
                                                  forceCreate:forceCreate
                                              completionBlock:self.authSuccessCompletionBlock
                                         errorCompletionBlock:self.authErrorCompletionBlock
                                                     cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}

- (void)smartSwitchAuthenticateGoogle:(NSString *)userID
            token:(NSString *)token
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^() {
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateGoogle:userID
                                           serverAuthCode:token
                                              forceCreate:forceCreate
                                          completionBlock:self.authSuccessCompletionBlock
                                     errorCompletionBlock:self.authErrorCompletionBlock
                                                 cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}

- (void)smartSwitchAuthenticateGoogleOpenId:(NSString *)googleUserAccountEmail
                                token:(NSString *)idToken
                          forceCreate:(BOOL)forceCreate
                      completionBlock:(BCCompletionBlock)completionBlock
                 errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                             cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^() {
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateGoogleOpenId:googleUserAccountEmail
                                           idToken:idToken
                                              forceCreate:forceCreate
                                          completionBlock:self.authSuccessCompletionBlock
                                     errorCompletionBlock:self.authErrorCompletionBlock
                                                 cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}

- (void)smartSwitchAuthenticateApple:(NSString *)appleUserId
                                token:(NSString *)identityToken
                          forceCreate:(BOOL)forceCreate
                      completionBlock:(BCCompletionBlock)completionBlock
                 errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                             cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^() {
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateApple:appleUserId
                                           identityToken:identityToken
                                              forceCreate:forceCreate
                                          completionBlock:self.authSuccessCompletionBlock
                                     errorCompletionBlock:self.authErrorCompletionBlock
                                                 cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}


- (void)smartSwitchAuthenticateSteam:(NSString *)userId
            sessionTicket:(NSString *)sessionticket
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^() {
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateSteam:userId
                                           sessionTicket:sessionticket
                                             forceCreate:forceCreate
                                         completionBlock:self.authSuccessCompletionBlock
                                    errorCompletionBlock:self.authErrorCompletionBlock
                                                cbObject:aco];
        
    };
    
    [self smartSwitchAuthentication:authCallback];
}

- (void)smartSwitchAuthenticateUltra:(NSString *)ultraUsername
                       ultraIdToken:(NSString *)ultraIdToken
                         forceCreate:(BOOL)forceCreate
                     completionBlock:(BCCompletionBlock)completionBlock
                errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                            cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^() {
        AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
        aco.completionBlock = completionBlock;
        aco.errorCompletionBlock = errorCompletionBlock;
        aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateUltra:ultraUsername
                                                ultraIdToken:ultraIdToken
                                                 forceCreate:forceCreate
                                             completionBlock:self.authSuccessCompletionBlock
                                        errorCompletionBlock:self.authErrorCompletionBlock
                                                    cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}

- (void)smartSwitchAuthenticateTwitter:(NSString *)userId
                      token:(NSString *)token
                     secret:(NSString *)secret
                forceCreate:(BOOL)forceCreate
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                   cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^() {
    
    AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
    aco.completionBlock = completionBlock;
    aco.errorCompletionBlock = errorCompletionBlock;
    aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateTwitter:userId
                                                     token:token
                                                    secret:secret
                                               forceCreate:forceCreate
                                           completionBlock:self.authSuccessCompletionBlock
                                      errorCompletionBlock:self.authErrorCompletionBlock
                                                  cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}



- (void)smartSwitchAuthenticateAdvanced:(AuthenticationTypeObjc *)authenticationType
                      authenticationIds:(AuthenticationIdsObjc *)authenticationIds
                            forceCreate:(BOOL)forceCreate
                              extraJson:(NSString *)extraJson
                        completionBlock:(BCCompletionBlock)completionBlock
                   errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                               cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];

    BCSmartSwitchCompletionBlock authCallback = ^()
    {
        AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
        aco.completionBlock = completionBlock;
        aco.errorCompletionBlock = errorCompletionBlock;
        aco.cbObject = cbObject;

		[[self->_bcClient authenticationService] authenticateAdvanced:authenticationType
                                              authenticationIds:authenticationIds
                                                    forceCreate:forceCreate
                                                      extraJson:extraJson
                                                completionBlock:self.authSuccessCompletionBlock
                                           errorCompletionBlock:self.authErrorCompletionBlock
                                                       cbObject:aco];
    };
    
    [self smartSwitchAuthentication:authCallback];
}


- (void)smartSwitchAuthenticateUniversal:(NSString *)userId
                     password:(NSString *)password
                  forceCreate:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    [self _initializeIdentity:FALSE];
	
	BCSmartSwitchCompletionBlock authCallback = ^() {
        [self _initializeIdentity:TRUE];
        
        AuthenticationCallbackObject *aco = [[AuthenticationCallbackObject alloc] init];
        aco.completionBlock = completionBlock;
        aco.errorCompletionBlock = errorCompletionBlock;
        aco.cbObject = cbObject;
        
		[[self->_bcClient authenticationService] authenticateUniversal:userId
                                                        password:password
                                                     forceCreate:forceCreate
                                                 completionBlock:completionBlock
                                            errorCompletionBlock:errorCompletionBlock
                                                        cbObject:cbObject];
    };
    
    [self smartSwitchAuthentication:authCallback];
}

- (void)smartSwitchAuthentication:(BCSmartSwitchCompletionBlock)authCallback {
    if([[self getBCClient] isAuthenticated]) {
        
        [[[self getBCClient] identityService]
         getIdentities:^(NSString *serviceName, NSString *serviceOperation, NSString *jsonData, BCCallbackObject cbObject) {
             
             NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
             
             NSError *jsonError;
             NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
             NSDictionary *identities = jsonObject[@"data"][@"identities"];
             NSInteger identityCount = [identities count];
             
             if(identityCount == 0) {
                 [[[self getBCClient] playerStateService]
                  deleteUser:^(NSString *serviceName, NSString *serviceOperation, NSString *jsonData, BCCallbackObject cbObject) {
                      authCallback();
                      
                  }
                  errorCompletionBlock:^(NSString *serviceName, NSString *serviceOperation, NSInteger statusCode, NSInteger reasonCode, NSString *jsonError, BCCallbackObject cbObject) {
                      authCallback();
                  }
                  cbObject:NULL];
             } else {
                 [[[self getBCClient] playerStateService]
                  logout:^(NSString *serviceName, NSString *serviceOperation, NSString *jsonData, BCCallbackObject cbObject) {
                      authCallback();
                  }
                  errorCompletionBlock:^(NSString *serviceName, NSString *serviceOperation, NSInteger statusCode, NSInteger reasonCode, NSString *jsonError, BCCallbackObject cbObject) {
                      authCallback();
                      
                  } cbObject:NULL];
             }
             
         }
         errorCompletionBlock:^(NSString *serviceName, NSString *serviceOperation, NSInteger statusCode, NSInteger reasonCode, NSString *jsonError, BCCallbackObject cbObject) {
             
                authCallback();
         }
         cbObject:NULL];
        
    } else {
        authCallback();
    }
}

- (void)resetEmailPassword:(NSString *)email
       withCompletionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    [[_bcClient authenticationService]resetEmailPassword:email
                                     withCompletionBlock:completionBlock
                                    errorCompletionBlock:errorCompletionBlock
                                                cbObject:cbObject];
}

- (void)resetEmailPasswordAdvanced:(NSString *)email
                     serviceParams:(NSString *)serviceParams
               withCompletionBlock:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                          cbObject:(BCCallbackObject)cbObject
{
    [[_bcClient authenticationService]resetEmailPasswordAdvanced:email
                                                   serviceParams:serviceParams
                                             withCompletionBlock:completionBlock
                                            errorCompletionBlock:errorCompletionBlock
                                                        cbObject:cbObject];
}

- (void)resetEmailPasswordWithExpiry:(NSString *)email
         tokenTtlInMinutes:(int)tokenTtlInMinutes
       withCompletionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    [[_bcClient authenticationService]resetEmailPasswordWithExpiry:email
                                                   tokenTtlInMinutes:tokenTtlInMinutes
                                             withCompletionBlock:completionBlock
                                            errorCompletionBlock:errorCompletionBlock
                                                        cbObject:cbObject];
}

- (void)resetEmailPasswordAdvancedWithExpiry:(NSString *)email
                     serviceParams:(NSString *)serviceParams
                 tokenTtlInMinutes:(int)tokenTtlInMinutes
               withCompletionBlock:(BCCompletionBlock)completionBlock
              errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                          cbObject:(BCCallbackObject)cbObject
{
    [[_bcClient authenticationService]resetEmailPasswordAdvancedWithExpiry:email
                                                    serviceParams:serviceParams
                                                   tokenTtlInMinutes:tokenTtlInMinutes
                                             withCompletionBlock:completionBlock
                                            errorCompletionBlock:errorCompletionBlock
                                                        cbObject:cbObject];
}


- (void)resetUniversalIdPassword:(NSString *)universalId
             withCompletionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject
{
    [[_bcClient authenticationService]resetUniversalIdPassword:universalId
                                     withCompletionBlock:completionBlock
                                    errorCompletionBlock:errorCompletionBlock
                                                cbObject:cbObject];
}

- (void)resetUniversalIdPasswordAdvanced:(NSString *)universalId
                           serviceParams:(NSString *)serviceParams
                     withCompletionBlock:(BCCompletionBlock)completionBlock
                    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                cbObject:(BCCallbackObject)cbObject
{
    [[_bcClient authenticationService]resetUniversalIdPasswordAdvanced:universalId
                                                   serviceParams:serviceParams
                                             withCompletionBlock:completionBlock
                                            errorCompletionBlock:errorCompletionBlock
                                                        cbObject:cbObject];
}

- (void)resetUniversalIdPasswordWithExpiry:(NSString *)universalId
               tokenTtlInMinutes:(int)tokenTtlInMinutes
             withCompletionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject
{
    [[_bcClient authenticationService]resetUniversalIdPasswordWithExpiry:universalId
                                                   tokenTtlInMinutes:tokenTtlInMinutes
                                             withCompletionBlock:completionBlock
                                            errorCompletionBlock:errorCompletionBlock
                                                        cbObject:cbObject];
}

- (void)resetUniversalIdPasswordAdvancedWithExpiry:(NSString *)universalId
                           serviceParams:(NSString *)serviceParams
                       tokenTtlInMinutes:(int)tokenTtlInMinutes
                     withCompletionBlock:(BCCompletionBlock)completionBlock
                    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                cbObject:(BCCallbackObject)cbObject
{
    [[_bcClient authenticationService]resetUniversalIdPasswordAdvancedWithExpiry:universalId
                                                    serviceParams:serviceParams
                                                   tokenTtlInMinutes:tokenTtlInMinutes
                                             withCompletionBlock:completionBlock
                                            errorCompletionBlock:errorCompletionBlock
                                                        cbObject:cbObject];
}


- (void)reconnect:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
            cbObject:(BCCallbackObject)cbObject
{
    [self authenticateAnonymous:completionBlock errorCompletionBlock:errorCompletionBlock cbObject:cbObject forceCreate:false];
}

/*
- (void)reauthenticateWithSuccess:(BrainCloudWrapperSuccessfulCompletion)success failure:(BrainCloudWrapperFailedCompletion)failure {
    [self initializeWithURL:self.lastURL
                companyName:nil
                  secretKey:self.lastSecretKey
                     gameID:self.lastGameID
                   appName:nil
                gameVersion:self.lastAppVersion];
    
    if ([self.storedAuthenticationType isEqualToString:kAuthenticationAnonymous])
        [self authenticateAnonymousWithSuccess:success failure:failure];
    
}
 */

#pragma mark - Updates

- (void)runCallbacks
{
    [_bcClient runCallBacks];
}

#pragma mark - Properties

- (BrainCloudScript *)scriptService
{
    return [_bcClient scriptService];
}

- (BrainCloudPushNotification *)pushNotificationService
{
    return [_bcClient pushNotificationService];
}

- (BrainCloudPlayerState *)playerStateService
{
    return [_bcClient playerStateService];
}

- (BrainCloudPlayerStatistics *)playerStatisticsService
{
    return [_bcClient playerStatisticsService];
}

- (BrainCloudGlobalStatistics *)globalStatisticsService
{
    return [_bcClient globalStatisticsService];
}

- (BrainCloudEntity *)entityService
{
    return [_bcClient entityService];
}

- (BrainCloudGlobalEntity *)globalEntityService
{
    return [_bcClient globalEntityService];
}

- (BrainCloudLeaderboard *)leaderboardService
{
    return [_bcClient leaderboardService];
}

- (BrainCloudGlobalApp *)globalAppService
{
    return [_bcClient globalAppService];
}

- (BrainCloudFriend *)friendService
{
    return [_bcClient friendService];
}

- (BrainCloudMail *)mailService
{
    return [_bcClient mailService];
}

- (BrainCloudMessaging*)messagingService
{
    return [_bcClient messagingService];
}

- (BrainCloudLobby*)lobbyService
{
    return [_bcClient lobbyService];
}

- (BrainCloudChat*)chatService
{
    return [_bcClient chatService];
}

- (BrainCloudMatchMaking *)matchMakingService
{
    return [_bcClient matchMakingService];
}

- (BrainCloudAsyncMatch *)asyncMatchService
{
    return [_bcClient asyncMatchService];
}

- (BrainCloudOneWayMatch *)oneWayMatchService
{
    return [_bcClient oneWayMatchService];
}

- (BrainCloudPlaybackStream *)playbackStreamService
{
    return [_bcClient playbackStreamService];
}

- (BrainCloudGamification *)gamificationService
{
    return [_bcClient gamificationService];
}

- (BrainCloudEvent *)eventService
{
    return [_bcClient eventService];
}

- (BrainCloudPlayerStatisticsEvent *)playerStatisticsEventService
{
    return [_bcClient playerStatisticsEventService];
}

- (BrainCloudTime *)timeService
{
    return [_bcClient timeService];
}

- (BrainCloudTournament *)tournamentService
{
    return [_bcClient tournamentService];
}

- (BrainCloudBlockchain *)blockchainService
{
	return [_bcClient blockchainService];
}

- (BrainCloudCustomEntity *)customEntityService
{
    return [_bcClient customEntityService];
}

- (BrainCloudUserItems*)userItemsService
{
    return [_bcClient userItemsService];
}

- (BrainCloudItemCatalog*)itemCatalogService
{
    return [_bcClient itemCatalogService];
}

- (BrainCloudPresence *)presenceService
{
    return [_bcClient presenceService];
}

- (BrainCloudVirtualCurrency *)virtualCurrencyService
{
    return [_bcClient virtualCurrencyService];
}

- (BrainCloudAppStore *)appStoreService
{
    return [_bcClient appStoreService];
}

- (BrainCloudS3Handling *)s3HandlingService
{
    return [_bcClient s3HandlingService];
}

- (BrainCloudIdentity *)identityService
{
    return [_bcClient identityService];
}

- (BrainCloudRedemptionCode *)redemptionCodeService
{
    return [_bcClient redemptionCodeService];
}

- (BrainCloudDataStream *)dataStreamService
{
    return [_bcClient dataStreamService];
}

- (BrainCloudProfanity *)profanityService
{
    return [_bcClient profanityService];
}

- (BrainCloudFile *)fileService
{
    return [_bcClient fileService];
}

- (BrainCloudGlobalFile *)globalFileService
{
    return [_bcClient globalFileService];
}

- (BrainCloudGroup *)groupService
{
    return [_bcClient groupService];
}


@end
