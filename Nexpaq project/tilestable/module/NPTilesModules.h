//
//  NPTilesModules.h
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 ben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPTilesModules : NSObject

@property(nonatomic, assign)NSInteger id;

@property(nonatomic, assign)NSInteger template;

@property(nonatomic, strong)NSString *name;

@property(nonatomic, strong)NSString *desc;

@property(nonatomic, strong)NSString *icon;

@property(nonatomic, strong)NSString *background;

@end
