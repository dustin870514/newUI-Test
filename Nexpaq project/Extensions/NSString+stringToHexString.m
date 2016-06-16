//
//  NSString+stringToHexString.m
//  NexpaqMain-project
//
//  Created by Kevin on 16/3/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "NSString+stringToHexString.h"
#import "NSString+cut_String.h"

@implementation NSString (stringToHexString)

- (NSString *)hexStringFromString{
    
    NSInteger num = self.integerValue;
    
    NSString *remainder = [self hexStringWithNum:(num % 16)];
    NSString *divisor =  [self hexStringWithNum:(num / 16)];
   
    NSString *reslut = [divisor stringByAppendingString:remainder];
    return reslut;
}

- (NSInteger)numberWithHexString{
    
    NSInteger sum = 0;

    for (int i = 0; i < self.length; ++i) {
        
        NSInteger number = [[self cutStringWithLocation:i andLenth:1] numberFromHexString];
        
        sum = sum + number * pow(16, self.length - i - 1);
        
    }

    return sum;
}

- (NSString *)hexStringWithNum:(NSInteger )num{
    
    switch (num) {
        case 10:
            return @"A";
            break;
        case 11:
            return @"B";
            break;
        case 12:
            return @"C";
            break;
        case 13:
            return @"D";
            break;
        case 14:
            return @"E";
            break;
        case 15:
            return @"F";
            break;
            
        default:
            return [NSString stringWithFormat:@"%zd",num];
            break;
    }
}

- (NSInteger)numberFromHexString{

    if ([self isEqualToString:@"A"]) {
        
        return 10;
        
    }else if([self isEqualToString:@"B"]){
        
        return 11;
        
    }else if ([self isEqualToString:@"C"]){
        
        return 12;
        
    }else if([self isEqualToString:@"D"]){
        
        return 13;
        
    }else if ([self isEqualToString:@"E"]){
        
        return 14;
        
    }else if([self isEqualToString:@"F"]){
        
        return 15;
        
    }else{
        
        return self.intValue;
        
    }

}

- (NSString *)ASCHexStringWithString{
    
    const  char *ch = [self cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSMutableString *tmpstring = [NSMutableString string];
    
    for (int i = 0; i<strlen(ch); i++) {
        
        int number = (int)ch[i];
        
        NSString *numberstring = [NSString stringWithFormat:@"%d",number];
        
        NSString *hexstring = [numberstring hexStringFromString];
        
        [tmpstring appendString:hexstring];
        
    }
        
    return tmpstring;
}

@end
