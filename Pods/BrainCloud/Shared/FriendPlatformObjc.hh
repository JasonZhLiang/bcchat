//
//  Platform.hh
//  brainCloudClientObjc
//
//  Created by Brad Hill on 2016-03-27.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"
#import <Foundation/Foundation.h>

@interface FriendPlatformObjc : NSObject

+ (FriendPlatformObjc *) All;
+ (FriendPlatformObjc *) BrainCloud;
+ (FriendPlatformObjc *) Facebook;
+ (FriendPlatformObjc *) Unknown;

- (NSString *)toString;
+ (FriendPlatformObjc *)fromString:(NSString *)platform;

- (id)initWithValue:(NSString *)value;

@property (readonly) NSString *value;

@end

#pragma clang diagnostic pop
