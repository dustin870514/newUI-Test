//
//  NPBLE_ModuleVersion.m
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/26.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_ModuleVersion.h"

@implementation NPBLE_ModuleVersion

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
  
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)versionWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

@end
