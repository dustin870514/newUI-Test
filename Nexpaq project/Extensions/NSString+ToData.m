//
//  NSString+ToData.m
//  01-test
//
//  Created by Kevin on 16/3/14.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "NSString+ToData.h"

@implementation NSString (ToData)

+ (NSData *)commandDataWithString:(NSString *)string{
    
    NSString *str = string;
    
    NSData *data = [str convertHexStrToData];
    
    return data;
}

- (NSData *)stringToData{

    int len = (int)[self length] / 2; // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3];// = {'1','2','3'};
    
    int i;
   
    for (i=0; i < [self length] / 2; i++) {
        
        byte_chars[0] = [self characterAtIndex:i*2];
        
        byte_chars[1] = [self characterAtIndex:i*2+1];
        
        *whole_byte = strtol(byte_chars, NULL, 16);
       
        whole_byte++;
    }
    
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    
    free( buf);
    
    return data;

}

- (NSData *)convertHexStrToData{
    
    if (!self || [self length] == 0) {
        
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    
    NSRange range;
    
    if ([self length] % 2 == 0) {
        
        range = NSMakeRange(0, 2);
    
    } else {
       
        range = NSMakeRange(0, 1);
    }
    
    for (NSInteger i = range.location; i < [self length]; i += 2) {
        
        unsigned int anInt;
        
        NSString *hexCharStr = [self substringWithRange:range];
        
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        
        [hexData appendData:entity];
        
        range.location += range.length;
        
        range.length = 2;
    }
    
    return hexData;

}
@end
