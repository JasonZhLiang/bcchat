//
//  Platform.m
//  brainCloudClientObjc
//
//  Created by Preston Jennings on 2015-09-10.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendPlatformObjc.hh"

@interface FriendPlatformObjc ()
@property (readwrite) NSString *value;
@end

@implementation FriendPlatformObjc

static FriendPlatformObjc * _All = [[FriendPlatformObjc alloc] initWithValue:@"All"];
static FriendPlatformObjc * _BrainCloud = [[FriendPlatformObjc alloc] initWithValue:@"brainCloud"];
static FriendPlatformObjc * _Facebook = [[FriendPlatformObjc alloc] initWithValue:@"Facebook"];
static FriendPlatformObjc * _Unknown = [[FriendPlatformObjc alloc] initWithValue:@"Unknown"];

- (id)initWithValue:(NSString *)value;
{
    self = [super init];
    _value = value;
    return self;
}

- (NSString*) toString
{
    return _value;
}

+ (FriendPlatformObjc*) All
{
    return _All;
}
+ (FriendPlatformObjc*) BrainCloud
{
    return _BrainCloud;
}
+ (FriendPlatformObjc*) Facebook
{
    return _Facebook;
}
+ (FriendPlatformObjc*) Unknown
{
    return _Unknown;
}

+ (FriendPlatformObjc*) fromString:(NSString *)platform
{
    if ([platform compare:_All.value] == NSOrderedSame)
    {
        return _All;
    }
    if ([platform compare:_BrainCloud.value] == NSOrderedSame)
    {
        return _BrainCloud;
    }
    if ([platform compare:_Facebook.value]  == NSOrderedSame)
    {
        return _Facebook;
    }
    return _Unknown;
}
@end

