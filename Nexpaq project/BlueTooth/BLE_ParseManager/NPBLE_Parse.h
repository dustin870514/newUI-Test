//
//  NPBLE_Parse.h
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/11.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NPBLE_Module;

@interface NPBLE_Parse : NSObject

@property (nonatomic, copy) NSString *fun;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) NSString *format;

@property (nonatomic, strong) NSDictionary *state;


+ (instancetype)parseWithDict:(NSDictionary *)dict;

+ (NSArray *)parsesWithModule:(NPBLE_Module *)module;

@end
