//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import "NSString+Local.h"

@implementation NSString (Local)

+ (NSString *)nilToWhitespace:(NSString *)s
{
    if (s == nil || s.length == 0) {
        return @" ";
    } else {
        return s;
    }
}

@end
