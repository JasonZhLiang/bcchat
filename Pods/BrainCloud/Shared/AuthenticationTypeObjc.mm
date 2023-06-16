//
//  AuthenticationTypeObjc.m
//  brainCloudClientObjc
//
//  Created by Brad Hill on 2016-04-04.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthenticationTypeObjc.hh"

@interface AuthenticationTypeObjc ()
@property (readwrite) NSString *value;
@end

@implementation AuthenticationTypeObjc

static AuthenticationTypeObjc * _Anonymous = [[AuthenticationTypeObjc alloc] initWithValue:@"Anonymous"];
static AuthenticationTypeObjc * _Universal = [[AuthenticationTypeObjc alloc] initWithValue:@"Universal"];
static AuthenticationTypeObjc * _Email = [[AuthenticationTypeObjc alloc] initWithValue:@"Email"];
static AuthenticationTypeObjc * _Facebook = [[AuthenticationTypeObjc alloc] initWithValue:@"Facebook"];
static AuthenticationTypeObjc * _GameCenter = [[AuthenticationTypeObjc alloc] initWithValue:@"GameCenter"];
static AuthenticationTypeObjc * _Steam = [[AuthenticationTypeObjc alloc] initWithValue:@"Steam"];
static AuthenticationTypeObjc * _Apple = [[AuthenticationTypeObjc alloc] initWithValue:@"Apple"];
static AuthenticationTypeObjc * _Google = [[AuthenticationTypeObjc alloc] initWithValue:@"Google"];
static AuthenticationTypeObjc * _GoogleOpenId = [[AuthenticationTypeObjc alloc] initWithValue:@"GoogleOpenId"];
static AuthenticationTypeObjc * _Twitter = [[AuthenticationTypeObjc alloc] initWithValue:@"Twitter"];
static AuthenticationTypeObjc * _Parse = [[AuthenticationTypeObjc alloc] initWithValue:@"Parse"];
static AuthenticationTypeObjc * _Handoff = [[AuthenticationTypeObjc alloc] initWithValue:@"Handoff"];
static AuthenticationTypeObjc * _SettopHandoff = [[AuthenticationTypeObjc alloc] initWithValue:@"SettopHandoff"];
static AuthenticationTypeObjc * _External = [[AuthenticationTypeObjc alloc] initWithValue:@"External"];
static AuthenticationTypeObjc * _Ultra = [[AuthenticationTypeObjc alloc] initWithValue:@"Ultra"];
static AuthenticationTypeObjc * _Unknown = [[AuthenticationTypeObjc alloc] initWithValue:@"UNKNOWN"];

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

+ (AuthenticationTypeObjc*) Anonymous
{
    return _Anonymous;
}
+ (AuthenticationTypeObjc*) Universal
{
    return _Universal;
}
+ (AuthenticationTypeObjc*) Email
{
    return _Email;
}
+ (AuthenticationTypeObjc*) Facebook
{
    return _Facebook;
}
+ (AuthenticationTypeObjc*) GameCenter
{
    return _GameCenter;
}
+ (AuthenticationTypeObjc*) Steam
{
    return _Steam;
}
+ (AuthenticationTypeObjc*) Google
{
    return _Google;
}
+ (AuthenticationTypeObjc*) Twitter
{
    return _Twitter;
}
+ (AuthenticationTypeObjc*) Parse
{
    return _Parse;
}
+ (AuthenticationTypeObjc*) Handoff
{
	return _Handoff;
}
+ (AuthenticationTypeObjc*) SettopHandoff
{
	return _SettopHandoff;
}
+ (AuthenticationTypeObjc*) External
{
    return _External;
}
+ (AuthenticationTypeObjc*) Ultra
{
    return _Ultra;
}
+ (AuthenticationTypeObjc*) Unknown
{
    return _Unknown;
}

+ (AuthenticationTypeObjc*) fromString:(NSString *)platform
{
    if ([platform compare:_Anonymous.toString] == NSOrderedSame)
    {
        return _Anonymous;
    }
    if ([platform compare:_Universal.toString] == NSOrderedSame)
    {
        return _Universal;
    }
    if ([platform compare:_Email.toString] == NSOrderedSame)
    {
        return _Email;
    }
    if ([platform compare:_Facebook.toString] == NSOrderedSame)
    {
        return _Facebook;
    }
    if ([platform compare:_GameCenter.toString] == NSOrderedSame)
    {
        return _GameCenter;
    }
    if ([platform compare:_Steam.toString] == NSOrderedSame)
    {
        return _Steam;
    }
    if ([platform compare:_Google.toString] == NSOrderedSame)
    {
        return _Google;
    }
    if ([platform compare:_Twitter.toString] == NSOrderedSame)
    {
        return _Twitter;
    }
    if ([platform compare:_Parse.toString] == NSOrderedSame)
    {
        return _Parse;
    }
	if ([platform compare:_Handoff.toString] == NSOrderedSame)
	{
		return _Handoff;
	}
	if ([platform compare:_SettopHandoff.toString] == NSOrderedSame)
	{
		return _SettopHandoff;
	}
    if ([platform compare:_External.toString] == NSOrderedSame)
    {
        return _External;
    }
    if ([platform compare:_Ultra.toString] == NSOrderedSame)
    {
        return _Ultra;
    }

    return _Unknown;
}
@end

