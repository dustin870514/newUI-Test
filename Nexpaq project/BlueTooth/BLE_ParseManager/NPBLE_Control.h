//
//  NPBLE_Control.h
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/11.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPBLE_Device.h"

@interface NPBLE_Control : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *command;

@property (nonatomic, assign) NSInteger node_id;

@property (nonatomic, strong) NPBLE_Device *device;

@property (nonatomic, copy) NSString *param;

+ (instancetype)controlWithDict:(NSDictionary *)dict;

+ (NSArray *)controlsWithSource_arr:(NSArray *)Source_arr;

@end
