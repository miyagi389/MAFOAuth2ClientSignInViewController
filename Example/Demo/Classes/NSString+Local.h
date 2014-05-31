//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Local)

/**
 * @return nil or 空文字 だったら 半角空白1文字を返す。
 */
+ (NSString *)nilToWhitespace:(NSString *)s;

@end
