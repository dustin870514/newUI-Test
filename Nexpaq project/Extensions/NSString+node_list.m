//
//  NSString+node_list.m
//  NexpaqMain-project
//
//  Created by Kevin on 16/3/18.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "NSString+node_list.h"
#import "NSString+cut_String.h"

@implementation NSString (node_list)

- (NSMutableArray *)nodeList{
    
    NSMutableArray *nodelist = [NSMutableArray array];

    NSInteger num = [self hexIntegerFromNormalStr];
   
    NSInteger remainder = 0;      //余数
   
    NSInteger divisor = 0;        //除数
    
    NSInteger index = 0;
    
    while (true)
    {
        remainder = num%2;
       
        divisor = num/2;
        
        num = divisor;
        
        if (remainder == 1) {
            
            [nodelist addObject:[NSString stringWithFormat:@"%zd",index + 3]];
            
        }
        
        index ++;
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    return nodelist;
}

- (NSInteger)hexIntegerFromNormalStr{
    
    NSInteger sumNumber = 0;
    
    for (NSInteger i = self.length - 1; i >= 0 ; i--) {
        
        double index = pow(16, i);
        
        NSString *sub_string = [self cutStringWithLocation:self.length - 1 - i andLenth:1];
        
        if ([sub_string isEqualToString:@"A"]) {
            
            sumNumber = sumNumber + 10 * index;
        
        }else if([sub_string isEqualToString:@"B"]){
            
            sumNumber = sumNumber + 11 * index;
        
        }else if ([sub_string isEqualToString:@"C"]){
        
            sumNumber = sumNumber + 12 * index;
       
        }else if([sub_string isEqualToString:@"D"]){
        
            sumNumber = sumNumber + 13 * index;
        
        }else if ([sub_string isEqualToString:@"E"]){
        
            sumNumber = sumNumber + 14 * index;
        
        }else if([sub_string isEqualToString:@"F"]){
        
            sumNumber = sumNumber + 15 * index;
        
        }else{
        
            sumNumber = sumNumber + [sub_string integerValue] * index;
        
        }
    }
        
        return sumNumber;
}

@end
