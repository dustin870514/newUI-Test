//
//  NPBLE_Parse.m
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/11.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_Parse.h"
#import "NPFileManager.h"
#import "NPBLE_Module.h"

@implementation NPBLE_Parse

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


+ (instancetype)parseWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)parsesWithModule:(NPBLE_Module *)module{
    
    NSInteger product_id = [module.product_id integerValue];

    NSString *filePath = [NPFileManager  resourcePathWithProduct_id:product_id andName:[NSString stringWithFormat:@"%@_parse.txt",module.version.parse]];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data == nil) return nil;
    
    NSArray *module_parse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *tmp_arr = [NSMutableArray array];
    
    for (NSDictionary *dict in module_parse) {
        
        NPBLE_Parse *parse = [NPBLE_Parse parseWithDict:dict];
        
        [tmp_arr addObject:parse];
    }
    
    return tmp_arr.copy;
}

@end
