// Copyright 2022 bitHeads, Inc. All Rights Reserved.

#pragma once

#import <Foundation/Foundation.h>

@interface AuthenticationIdsObjc : NSObject

- (id)initWithExternalId:(NSString *)externalId
     authenticationToken:(NSString *)authenticationToken
   authenticationSubType:(NSString *)authenticationSubType;

@property (readonly) NSString *externalId;
@property (readonly) NSString *authenticationToken;
@property (readonly) NSString *authenticationSubType;

@end
