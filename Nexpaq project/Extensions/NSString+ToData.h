//
//  NSString+ToData.h
//  01-test
//
//  Created by Kevin on 16/3/14.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ToData)


- (NSData *)stringToData;

- (NSData *)convertHexStrToData;

+ (NSData *)commandDataWithString:(NSString *)string;

@end
