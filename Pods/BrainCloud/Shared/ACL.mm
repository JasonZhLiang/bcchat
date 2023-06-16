//
//  ACL.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-07.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "ACL.hh"

@implementation ACL

+ (NSString *)getAclJson:(Access)access
{
    return [NSString stringWithFormat:@"%@%lu", @"{ \"other\": ", (unsigned long)access];
}

+ (NSString *)getGroupAclJson:(Access)other memberAccess:(Access)member
{
    return [NSString stringWithFormat:@"{ \"other\": %lu, \"member\": %lu }", (unsigned long)other, (unsigned long)member];
}

@end
