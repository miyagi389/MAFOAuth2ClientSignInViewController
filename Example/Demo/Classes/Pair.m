//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import "Pair.h"

@implementation Pair

- (instancetype)initWithFirst:(id)first second:(id)second
{
    self = [super init];
    if (self) {
        self.first = first;
        self.second = second;
    }
    return self;
}

+ (instancetype)pairWithFirst:(id)first second:(id)second
{
    return [[self alloc] initWithFirst:first second:second];
}

@end
