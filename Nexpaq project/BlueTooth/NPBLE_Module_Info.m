//
//  NPBLE_Module_Info.m
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/25.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_Module_Info.h"

@implementation NPBLE_Module_Info


- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
       [self setValuesForKeysWithDictionary:dict];
    }
  
    return self;
}

+ (instancetype)infoWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];

}

@end
