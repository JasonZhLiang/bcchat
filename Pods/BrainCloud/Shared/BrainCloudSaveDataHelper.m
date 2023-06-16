//
//  BrainCloudSaveDataHelper.m
//  BrainCloud
//
//  Created by Benoit Sarrazin on 2016-02-29.
//  Copyright © 2016 BitHeads Inc. All rights reserved.
//

#import "BrainCloudSaveDataHelper.h"

#import <SSKeychain/SSKeychain.h>

@interface BrainCloudSaveDataHelper ()

@property(copy, nonatomic) NSString *companyName;
@property(copy, nonatomic) NSString *appName;
@property(copy, nonatomic) NSString *path;

@end

@implementation BrainCloudSaveDataHelper

- (instancetype)initWithCompanyName:(NSString *)companyName gameName:(NSString *)appName
{
    self = [self init];

    if (self != nil)
    {
        self.path = [NSString stringWithFormat:@"%@.%@", companyName, appName];
    }

    return self;
}

- (instancetype)initWithCompanyName:(NSString *)companyName appName:(NSString *)appName
{
    self = [self init];

    if (self != nil)
    {
        self.path = [NSString stringWithFormat:@"%@.%@", companyName, appName];
    }

    return self;
}

- (void)saveString:(NSString *)string forKey:(NSString *)key
{
    if (self.path.length == 0) return;

    [SSKeychain deletePasswordForService:self.path account:key];

    if (string.length == 0)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:string forKeyPath:key];
    }
}

- (NSString *)stringForKey:(NSString *)key
{
    if (self.path.length == 0) return nil;

    return [self migrateLoadString:key];
}

- (NSString *)migrateLoadString:(NSString *)key
{
    NSString *value = [SSKeychain passwordForService:self.path account:key];

    if (value != nil && value.length > 0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:value forKeyPath:key];
        [SSKeychain deletePasswordForService:self.path account:key];
    }

    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

@end
