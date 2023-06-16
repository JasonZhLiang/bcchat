//
//  AuthenticationTypeObjc.m
//  brainCloudClientObjc
//
//  Created by Brad Hill on 2016-04-04.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthenticationIdsObjc.hh"

@interface AuthenticationIdsObjc ()
@property (readwrite) NSString *externalId;
@property (readwrite) NSString *authenticationToken;
@property (readwrite) NSString *authenticationSubType;
@end

@implementation AuthenticationIdsObjc


- (id)initWithExternalId:(NSString *)externalId
     authenticationToken:(NSString *)authenticationToken
   authenticationSubType:(NSString *)authenticationSubType
{
    self = [super init];
    _externalId = externalId;
    _authenticationToken = authenticationToken;
    _authenticationSubType = authenticationSubType;
    return self;
}

@end

