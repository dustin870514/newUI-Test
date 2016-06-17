//
//  NPTileTextAttribute.m
//  NPMetroUIDemo
//
//  Created by Jordan Zhou on 16/6/16.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPTileTextAttribute.h"
#import "NSString+cut_String.h"
#import "NSString+stringToHexString.h"

@implementation NPTileTextAttribute


- (void)setColorString:(NSString *)colorString{

    _colorString = colorString;
    
    NSString *redString = [colorString cutStringWithLocation:1 andLenth:2];
    
    NSInteger redInteger = [redString numberWithHexString];
    
    NSString *greenString = [colorString cutStringWithLocation:3 andLenth:2];
    
    NSInteger greenInteger = [greenString numberWithHexString];
    
    NSString *blueString = [colorString cutStringWithLocation:5 andLenth:2];
    
    NSInteger blueInteger = [blueString numberWithHexString];
    
    UIColor *color = [UIColor colorWithRed:redInteger / 255.0 green:greenInteger /  255.0 blue:blueInteger / 255.0 alpha:1];
    
    self.color = color;

}


+ (instancetype)textAttWithDict:(NSDictionary *)dict{

    NPTileTextAttribute *textAtt = [[self alloc] init];
    
    [textAtt setValuesForKeysWithDictionary:dict];
    
    return textAtt;
}

@end
