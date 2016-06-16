//
//  NSData+ToString.m
//  01-test
//
//  Created by Kevin on 16/3/14.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "NSData+ToString.h"

@implementation NSData (ToString)

- (NSString *)convertDataToHexStr{
    
    if (!self|| [self length] == 0) {
       
        return @"";
    
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[self length]];
    
    [self enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
       
        unsigned char *dataBytes = (unsigned char*)bytes;
        
        for (NSInteger i = 0; i < byteRange.length; i++) {
            
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            
            if ([hexStr length] == 2) {
                
                [string appendString:hexStr];
           
            } else {
               
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

@end
