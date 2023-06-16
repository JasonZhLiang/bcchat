//
//  Platform.m
//  brainCloudClientObjc
//
//  Created by Preston Jennings on 2015-09-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlatformObjc.hh"
#include "braincloud/Platform.h"

@interface PlatformObjc ()
@property(readwrite) NSString *value;
@end

@implementation PlatformObjc

static PlatformObjc *_AppleTVOS = [[PlatformObjc alloc] initWithValue:@"APPLE_TV_OS"];
static PlatformObjc *_BlackBerry = [[PlatformObjc alloc] initWithValue:@"BB"];
static PlatformObjc *_Facebook = [[PlatformObjc alloc] initWithValue:@"FB"];
static PlatformObjc *_GooglePlayAndroid = [[PlatformObjc alloc] initWithValue:@"ANG"];
static PlatformObjc *_iOS = [[PlatformObjc alloc] initWithValue:@"IOS"];
static PlatformObjc *_Linux = [[PlatformObjc alloc] initWithValue:@"LINUX"];
static PlatformObjc *_Mac = [[PlatformObjc alloc] initWithValue:@"MAC"];
static PlatformObjc *_Web = [[PlatformObjc alloc] initWithValue:@"WEB"];
static PlatformObjc *_Windows = [[PlatformObjc alloc] initWithValue:@"WINDOWS"];
static PlatformObjc *_WindowsPhone = [[PlatformObjc alloc] initWithValue:@"WINP"];
static PlatformObjc *_Xbox360 = [[PlatformObjc alloc] initWithValue:@"XBOX_360"];
static PlatformObjc *_PS3 = [[PlatformObjc alloc] initWithValue:@"PS3"];
static PlatformObjc *_XboxOne = [[PlatformObjc alloc] initWithValue:@"XBOX_ONE"];
static PlatformObjc *_PS4 = [[PlatformObjc alloc] initWithValue:@"PS4"];
static PlatformObjc *_WatchOS = [[PlatformObjc alloc] initWithValue:@"WATCH_OS"];
static PlatformObjc *_Wii = [[PlatformObjc alloc] initWithValue:@"WII"];
static PlatformObjc *_PSVita = [[PlatformObjc alloc] initWithValue:@"PS_VITA"];
static PlatformObjc *_Tizen = [[PlatformObjc alloc] initWithValue:@"TIZEN"];
static PlatformObjc *_Roku = [[PlatformObjc alloc] initWithValue:@"ROKU"];
static PlatformObjc *_Unknown = [[PlatformObjc alloc] initWithValue:@"UNKNOWN"];

- (id)initWithValue:(NSString *)value;
{
  self = [super init];
  _value = value;
  return self;
}

- (NSString *)toString {
  return _value;
}

+ (PlatformObjc *)AppleTVOS {
  return _AppleTVOS;
}
+ (PlatformObjc *)BlackBerry {
  return _BlackBerry;
}
+ (PlatformObjc *)Facebook {
  return _Facebook;
}
+ (PlatformObjc *)GooglePlayAndroid {
  return _GooglePlayAndroid;
}
+ (PlatformObjc *)iOS {
  return _iOS;
}
+ (PlatformObjc *)Linux {
  return _Linux;
}
+ (PlatformObjc *)Mac {
  return _Mac;
}
+ (PlatformObjc *)Web {
  return _Web;
}
+ (PlatformObjc *)Windows {
  return _Windows;
}
+ (PlatformObjc *)WindowsPhone {
  return _WindowsPhone;
}
+ (PlatformObjc *)Xbox360 {
  return _Xbox360;
}
+ (PlatformObjc *)PS3 {
  return _PS3;
}
+ (PlatformObjc *)XboxOne {
  return _XboxOne;
}
+ (PlatformObjc *)PS4 {
  return _PS4;
}
+ (PlatformObjc *)WatchOS {
  return _WatchOS;
}
+ (PlatformObjc *)Wii {
  return _Wii;
}
+ (PlatformObjc *)PSVita {
  return _PSVita;
}
+ (PlatformObjc *)Tizen {
  return _Tizen;
}
+ (PlatformObjc *)Roku {
  return _Roku;
}
+ (PlatformObjc *)Unknown {
  return _Unknown;
}

+ (PlatformObjc *)fromString:(NSString *)platform {
  if ([platform compare:@"APPLE_TV_OS"] == NSOrderedSame) {
    return _AppleTVOS;
  }
  if ([platform compare:@"BB"] == NSOrderedSame) {
    return _BlackBerry;
  }
  if ([platform compare:@"FB"] == NSOrderedSame) {
    return _Facebook;
  }
  if ([platform compare:@"ANG"] == NSOrderedSame) {
    return _GooglePlayAndroid;
  }
  if ([platform compare:@"IOS"] == NSOrderedSame) {
    return _iOS;
  }
  if ([platform compare:@"LINUX"] == NSOrderedSame) {
    return _Linux;
  }
  if ([platform compare:@"MAC"] == NSOrderedSame) {
    return _Mac;
  }
  if ([platform compare:@"WEB"] == NSOrderedSame) {
    return _Web;
  }
  if ([platform compare:@"WINDOWS"] == NSOrderedSame) {
    return _Windows;
  }
  if ([platform compare:@"WINP"] == NSOrderedSame) {
    return _WindowsPhone;
  }
  if ([platform compare:@"XBOX_360"] == NSOrderedSame) {
    return _Xbox360;
  }
  if ([platform compare:@"PS3"] == NSOrderedSame) {
    return _PS3;
  }
  if ([platform compare:@"XBOX_ONE"] == NSOrderedSame) {
    return _XboxOne;
  }
  if ([platform compare:@"PS4"] == NSOrderedSame) {
    return _PS4;
  }
  if ([platform compare:@"WATCH_OS"] == NSOrderedSame) {
    return _WatchOS;
  }
  if ([platform compare:@"WII"] == NSOrderedSame) {
    return _Wii;
  }
  if ([platform compare:@"PS_VITA"] == NSOrderedSame) {
    return _PSVita;
  }
  if ([platform compare:@"TIZEN"] == NSOrderedSame) {
    return _Tizen;
  }
  if ([platform compare:@"ROKU"] == NSOrderedSame) {
    return _Roku;
  }

  return _Unknown;
}
@end
