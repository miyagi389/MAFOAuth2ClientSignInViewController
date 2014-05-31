//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pair : NSObject

@property(nonatomic) id first;

@property(nonatomic) id second;

- (instancetype)initWithFirst:(id)first second:(id)second;

+ (instancetype)pairWithFirst:(id)first second:(id)second;

@end
