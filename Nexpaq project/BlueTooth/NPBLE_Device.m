//
//  NPBLE_Device.m
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/21.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_Device.h"
#import "NPBLE_DeviceManager.h"
#import "NSString+cut_String.h"
#import "NSString+node_list.h"
#import "NSArray+newArray.h"



@interface NPBLE_Device ()

@property (nonatomic, strong) CBPeripheral *per;

@end

@implementation NPBLE_Device


+ (instancetype)NPBLE_DeviceWithPeripheral:(CBPeripheral *)per{

    NPBLE_Device *device = [[NPBLE_Device alloc] init];
    
    device.peripheral = per;
    
    device.name = per.name == nil ? @"emptyName" : per.name;
    
    return device;
}

- (NSMutableArray *)modules{
    
    if (_modules == nil) {
        
        _modules = [NSMutableArray array];
    }
    
    return _modules;
}

- (NSMutableArray *)node_list{
    
    if (_node_list == nil) {
        
        _node_list = [NSMutableArray array];
    }
    
    return _node_list;
}

- (void)setNode_list_str:(NSString *)node_list_str{
    
    _node_list_str = node_list_str;
    
    NSMutableArray *node_list = [node_list_str nodeList];
    
    _changeNode_list  = [node_list newArrayWithArray:self.node_list];
    
    self.isAddList = node_list.count >= self.node_list.count;
    
    self.node_list = node_list;
}

- (void)setCase_bsl_info:(NSString *)Case_bsl_info{
    
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < Case_bsl_info.length / 2; ++i) {
        
        NSString * subString = [Case_bsl_info cutStringWithLocation:i * 2 andLenth:2];
        
        if (i == (Case_bsl_info.length / 2) - 1) {
            
            [string appendString:[NSString stringWithFormat:@"%zd",subString.integerValue]];
            
            _Case_bsl_info = string;
            
            return;
        }
        
        [string appendString:[NSString stringWithFormat:@"%zd.",subString.integerValue]];
    }
}

- (NSMutableArray *)changeNode_list{
    
    if (_changeNode_list == nil) {
        
        _changeNode_list = [NSMutableArray array];
    }
    
    return _changeNode_list;
}

- (void)setCase_uuid_short:(NSString *)Case_uuid_short{
    
    _Case_uuid_short = Case_uuid_short;
    
    NSString *fianl_uuid = [self.Case_uuid_long stringByAppendingString:Case_uuid_short];
    
    self.Case_uuid = [fianl_uuid cutStringWithLocation:14 andLenth:16 * 2];
}

- (void)setCase_app_info:(NSString *)Case_app_info{
    
    if ([Case_app_info isEqualToString:@"no app"]) {
        
        _Case_app_info = Case_app_info;
        
    }else{
        
        NSMutableString *string = [NSMutableString string];
        
        for (int i = 0; i < Case_app_info.length / 2; ++i) {
            
            NSString * subString = [Case_app_info cutStringWithLocation:i * 2 andLenth:2];
            
            if (i == (Case_app_info.length / 2) - 1) {
                
                [string appendString:[NSString stringWithFormat:@"%zd",subString.integerValue]];
                
                _Case_app_info = string;
                
                return;
            }
            
            [string appendString:[NSString stringWithFormat:@"%zd.",subString.integerValue]];
        }
        
    }
}

@end
