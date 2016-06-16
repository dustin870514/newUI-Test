//
//  NSString+cut_String.m
//  NexpaqMain-project
//
//  Created by Kevin on 16/3/18.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "NSString+cut_String.h"
#import "NSString+stringToHexString.h"


@implementation NSString (cut_String)

- (instancetype)cutStringWithLocation:(NSInteger)location andLenth:(NSInteger)lenth{
   
   return  [self substringWithRange:NSMakeRange(location, lenth)];
    
}

- (instancetype)cutStringWithStartString:(NSString *)startString andEndString:(NSString *)endString{

    NSRange range = [self rangeOfString:startString];
    
    NSRange range1 = [self rangeOfString:endString];
    
    NSRange newRange = NSMakeRange(range.location + range.length, range1.location - range.length-range.location);
    
    NSString *cutString = [self substringWithRange:newRange];

    return cutString;
}

- (instancetype)getHexStringFromString{
    
    NSMutableString *tmpString = [NSMutableString string];

    NSArray *arr = [self componentsSeparatedByString:@","];
    
    for (NSString *str in arr) {
        
        NSString *hexString = [str hexStringFromString];
        
        [tmpString appendString:hexString];
    }
    
    NSLog(@"tmpstring = %@",tmpString);
    
    return tmpString;
}

+ (NSArray *)bindEventWithMessageBody:(NSMutableString *)body{

    NSMutableArray *subString_arr = [NSMutableArray array];
    
    for (int i = 0; i < 4; ++i) {
        
        NSRange leftRange = [body rangeOfString:@"{"];
        
        NSRange rightRange = [body rangeOfString:@"}"];
        
        NSInteger lenth = rightRange.location - leftRange.location;
        
        if (lenth > 60) {
            
            NSString *availableString = [body cutStringWithLocation:leftRange.location + 1 andLenth:lenth - 1];
            
            [subString_arr addObject:availableString];
            
            //                NSLog(@"availablestring = %@",availableString);
            
            [body deleteCharactersInRange:rightRange];
            
            [body deleteCharactersInRange:leftRange];
            
            //                NSLog(@"body --- %@",body);
            
        }else{
            
            [body deleteCharactersInRange:rightRange];
            
            [body deleteCharactersInRange:leftRange];
        }
    
    }
    
    NSMutableArray *retun_arr = [NSMutableArray array];
    
    for (NSString *str in subString_arr) {
        
        NSArray *str_arr = [str componentsSeparatedByString:@","];
        
        NSMutableArray *mStr_0_arr = [NSMutableArray array];
        
        for (NSString *str_0 in str_arr) {
            
            NSArray *str_0_arr = [str_0 componentsSeparatedByString:@":"];
            
            NSMutableString *mStr_1 = [NSMutableString stringWithString:str_0_arr.lastObject];
            
            [mStr_1 replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, mStr_1.length)];
            
            [mStr_0_arr addObject:mStr_1];
        }
        
        NSDictionary *dict_0 = [NSDictionary dictionaryWithObject:mStr_0_arr[1] forKey:mStr_0_arr.lastObject];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:dict_0 forKey:mStr_0_arr.firstObject];
        
        [retun_arr addObject:dict];
    }
    
    return retun_arr.copy;
}



@end
