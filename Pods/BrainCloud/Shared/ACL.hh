//
//  ACL.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-07.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma once

typedef NS_ENUM(NSUInteger, Access) { None, ReadOnly, ReadWrite };

@interface ACL : NSObject

+ (NSString *)getAclJson:(Access)access;

+ (NSString *)getGroupAclJson:(Access)other memberAccess:(Access)member;

@end
