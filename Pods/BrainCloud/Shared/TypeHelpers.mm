//
//  TypeHelpers.mm
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-12-07.
//  Copyright © 2015 bitHeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <vector>
#import <string>

#import "TypeHelpers.hh"

std::vector<std::string> TypeHelpers::NSStringArrayToVector(NSArray* array)
{
    std::vector<std::string> strings;
    strings.reserve([array count]);
    
    for (id object in array)
    {
        strings.push_back([object UTF8String]);
    }
    
    return strings;
}

std::string TypeHelpers::NSStringToStdString(NSString* string)
{
    std::string str = string != nil ? [string UTF8String] : "";
    return str;
}