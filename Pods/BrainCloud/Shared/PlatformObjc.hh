//
//  Platform.hh
//  brainCloudClientObjc
//
//  Created by Preston Jennings on 2015-09-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma once

@interface PlatformObjc : NSObject

+ (PlatformObjc *)AppleTVOS;
+ (PlatformObjc *)BlackBerry;
+ (PlatformObjc *)Facebook;
+ (PlatformObjc *)GooglePlayAndroid;
+ (PlatformObjc *)iOS;
+ (PlatformObjc *)Linux;
+ (PlatformObjc *)Mac;
+ (PlatformObjc *)Web;
+ (PlatformObjc *)Windows;
+ (PlatformObjc *)WindowsPhone;
+ (PlatformObjc *)Xbox360;
+ (PlatformObjc *)PS3;
+ (PlatformObjc *)XboxOne;
+ (PlatformObjc *)PS4;
+ (PlatformObjc *)WatchOS;
+ (PlatformObjc *)Wii;
+ (PlatformObjc *)PSVita;
+ (PlatformObjc *)Tizen;
+ (PlatformObjc *)Roku;
+ (PlatformObjc *)Unknown;

- (NSString *)toString;
+ (PlatformObjc *)fromString:(NSString *)platform;

- (id)initWithValue:(NSString *)value;

@property(readonly) NSString *value;

@end
