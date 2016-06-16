//
//  NPBLE_Control.m
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/11.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_Control.h"
#import "NSString+stringToHexString.h"

@implementation NPBLE_Control

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        self.name = dict[@"name"];
        
        self.command = [self cmdWithArray:dict[@"cmd"]];
    }
    
    return self;
}

+ (instancetype)controlWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
    
}

+ (NSArray *)controlsWithSource_arr:(NSArray *)Source_arr{
    
    NSMutableArray *des_arr = [NSMutableArray array];
    
    for (NSDictionary *dict in Source_arr) {
        
        NPBLE_Control *control = [NPBLE_Control controlWithDict:dict];
        
        [des_arr addObject:control];
    }
    
    return des_arr.copy;
}

- (NSString *)cmdWithArray:(NSArray *)cmdArray{
    
    NSMutableString *tmpString = [NSMutableString string];
    
    for (NSNumber *number in cmdArray) {
        
        NSString *hexStr = [[NSString stringWithFormat:@"%zd",number.integerValue] hexStringFromString];
        
        [tmpString appendString:hexStr];
        
    }
    
    return tmpString;
    
}



@end
