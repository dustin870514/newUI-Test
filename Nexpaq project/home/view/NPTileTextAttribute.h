//
//  NPTileTextAttribute.h
//  NPMetroUIDemo
//
//  Created by Jordan Zhou on 16/6/16.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NPTileTextAttribute : NSObject

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, copy) NSString *colorString;

+ (instancetype)textAttWithDict:(NSDictionary *)dict;

@end
