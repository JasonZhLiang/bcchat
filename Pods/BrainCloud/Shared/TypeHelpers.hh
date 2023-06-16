//
//  TypeHelpers.hh
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-12-07.
//  Copyright © 2015 bitHeads. All rights reserved.
//

#ifndef TypeHelpers_hh
#define TypeHelpers_hh

class TypeHelpers
{
public:
    static std::vector<std::string> NSStringArrayToVector(NSArray* array);

    static std::string NSStringToStdString(NSString* string);
};


#endif /* TypeHelpers_hh */
