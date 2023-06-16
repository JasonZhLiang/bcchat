//
//  BrainCloudSaveDataHelper.h
//  BrainCloud
//
//  Created by Benoit Sarrazin on 2016-02-29.
//  Copyright © 2016 BitHeads Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrainCloudSaveDataHelper : NSObject

- (instancetype)initWithCompanyName:(NSString *)companyName appName:(NSString *)appName;

- (void)saveString:(NSString *)string forKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;

@end
