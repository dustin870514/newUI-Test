//
//  NPBLE_ModuleVersion.h
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/26.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPBLE_ModuleVersion : NSObject

@property (nonatomic, strong) NSNumber *information;

@property (nonatomic, strong) NSNumber *icon1;

@property (nonatomic, strong) NSNumber *icon2;

@property (nonatomic, strong) NSNumber *parse;

@property (nonatomic, strong) NSNumber *app;

@property (nonatomic, strong) NSNumber *control;

@property (nonatomic, strong) NSNumber *firmware;

+ (instancetype)versionWithDict:(NSDictionary *)dict;

@end
