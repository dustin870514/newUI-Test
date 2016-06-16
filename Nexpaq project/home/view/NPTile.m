//
//  NPTile.m
//  NPMetroUIDemo
//
//  Created by Jordan Zhou on 16/6/16.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPTile.h"

@implementation NPTile


- (instancetype)initWithStatusImagePaths:(NSMutableDictionary *)statusImagePaths andIconImagePaths:(NSMutableDictionary *)iconImagePaths andTextAtts:(NSMutableDictionary *)textAtts andTitle:(NSString *)title{

    if (self = [super init]) {
        
        self.statusImagePaths = statusImagePaths;
        
        self.iconImagePaths = iconImagePaths;
        
        self.textAtts = textAtts;
        
        self.title = title;
    }

    return self;
}




+ (instancetype)tileWithStatusImagePaths:(NSMutableDictionary *)statusImagePaths andIconImagePaths:(NSMutableDictionary *)iconImagePaths andTextAtts:(NSMutableDictionary *)textAtts andTitle:(NSString *)title{

    return [[self alloc] initWithStatusImagePaths:statusImagePaths andIconImagePaths:iconImagePaths andTextAtts:textAtts andTitle:title];
}

@end
