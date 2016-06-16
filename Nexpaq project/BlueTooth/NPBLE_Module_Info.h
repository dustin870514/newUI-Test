//
//  NPBLE_Module_Info.h
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/25.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPBLE_Module_Info : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *size;

@property (nonatomic, copy) NSString *icon1;

@property (nonatomic, copy) NSString *icon2;

@property (nonatomic, copy) NSString *app;

@property (nonatomic, copy) NSString *firmware;

+ (instancetype)infoWithDict:(NSDictionary *)dict;



@end
