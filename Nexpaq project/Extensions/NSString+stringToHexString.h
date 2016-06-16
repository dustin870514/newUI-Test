//
//  NSString+stringToHexString.h
//  NexpaqMain-project
//
//  Created by Kevin on 16/3/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (stringToHexString)
//10进制字符串转换成16进制字符串
- (NSString *)hexStringFromString;

//16进制字符串转换成10进制字符串
- (NSInteger)numberWithHexString;

//普通字符串转换成16进制ASC字符串
- (NSString *)ASCHexStringWithString;

@end
