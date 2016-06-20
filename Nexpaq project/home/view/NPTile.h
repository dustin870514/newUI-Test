//
//  NPTile.h
//  NPMetroUIDemo
//
//  Created by Jordan Zhou on 16/6/16.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPTileTextAttribute.h"
#import "NPEnumHeader.h"



@interface NPTile : NSObject

@property (nonatomic, assign) NPTileTemplate tileTemplate;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, strong) NSMutableDictionary *statusImagePaths;

@property (nonatomic, strong) NSMutableDictionary *iconImagePaths;

@property (nonatomic, strong) NSMutableDictionary *textAtts;

@property (nonatomic, copy) NSString *title;


+ (instancetype)tileWithStatusImagePaths:(NSMutableDictionary *)statusImagePaths andIconImagePaths:(NSMutableDictionary *)iconImagePaths andTextAtts:(NSMutableDictionary *)textAtts andTitle:(NSString *)title;



@end
