//
//  NPBLE_Module.m
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/8.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_Module.h"
#import "NPBLE_DeviceManager.h"
#import "NPFileManager.h"
#import "NSString+cut_String.h"
#import "NPBLE_DeviceManager.h"

@implementation NPBLE_Module

+ (instancetype)moduleWithMoule:(NPBLE_Module *)module{
    
    NSString *iconImagePath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@_%@_icon1.png",module.product_id,module.product_id,module.version.icon1]];
  
    NSString *settingImagePath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@_%@_icon2.png",module.product_id,module.product_id,module.version.icon2]];
    
    NSString *infoPath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@_information.txt",module.product_id,module.version.information]];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:infoPath] options:0 error:nil];
    
    module.iconImage = [UIImage imageWithContentsOfFile:iconImagePath];
    
    module.settingImage = [UIImage imageWithContentsOfFile:settingImagePath];
    
    module.info = [NPBLE_Module_Info infoWithDict:dict];
    
    return module;
}

- (NSString *)settingImageWithProduct_id:(NSInteger)product_id{

    NSString *imagePath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%zd/%zd_icon2.png",product_id,product_id]];
    
    return imagePath;
}

#pragma mark -  Getter && Setter

- (void)setModule_uuid_short:(NSString *)module_uuid_short{
    
    _module_uuid_short = module_uuid_short;

    self.module_uuid = [self.module_uuid_long stringByAppendingString:module_uuid_short];

}

- (void)setModule_uuid:(NSString *)module_uuid{
    
    if (module_uuid.length == 16 * 2) {
        
        _module_uuid = module_uuid;
        
        return;
    }
    
    _module_uuid = [module_uuid cutStringWithLocation:14 andLenth:16 * 2];
    
}

- (void)setProduct_id:(NSString *)product_id{

    _product_id = product_id;
    
    if (product_id) {
        
        self.isMatch = YES;
    
    }else{
    
        self.isMatch = NO;
    }
}

- (void)setBsl_info:(NSString *)bsl_info{
    
    self.bsl_version = [bsl_info cutStringWithLocation:0 andLenth:3 * 2];
    
    self.hasApp = [[bsl_info cutStringWithLocation:6 andLenth:2] integerValue]; ;
}

- (void)setApp_info:(NSString *)app_info{

    _app_info = app_info;
    
    self.app_vsersion = app_info;

}

- (void)setApp_vsersion:(NSString *)app_vsersion{
    
    if (app_vsersion.length == 5) {
        
        _app_vsersion = app_vsersion;
        
        return;
    }

    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < app_vsersion.length / 2; ++i) {
        
        NSString * subString = [app_vsersion cutStringWithLocation:i * 2 andLenth:2];
        
        if (i == (app_vsersion.length / 2) - 1) {
            
            [string appendString:[NSString stringWithFormat:@"%zd",subString.integerValue]];
            
            _app_vsersion = string;
            
            return;
        }
        
        [string appendString:[NSString stringWithFormat:@"%zd.",subString.integerValue]];
    }
}

- (void)setElectricity:(NSString *)Electricity{

     NSInteger pointLeft = [[Electricity cutStringWithLocation: 0 andLenth:2] integerValue];
    
     NSInteger pointRight = [[Electricity cutStringWithLocation:2 andLenth:2] integerValue];
    
     CGFloat fianl = pointLeft + pointRight / 100;
    
    _Electricity =  [NSString stringWithFormat:@"%f",(fianl / 4.25 )*100];
    
}

- (void)setBsl_version:(NSString *)bsl_version{
    
    if (bsl_version.length < 6) {//okmaHhgq
        
        _bsl_version = bsl_version;
        
        return;
    }
  
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < bsl_version.length / 2; ++i) {
        
        NSString * subString = [bsl_version cutStringWithLocation:i * 2 andLenth:2];
        
        if (i == (bsl_version.length / 2) - 1) {
            
            [string appendString:[NSString stringWithFormat:@"%zd",subString.integerValue]];
            
            _bsl_version = string;
            
            return;
        }
        
        [string appendString:[NSString stringWithFormat:@"%zd.",subString.integerValue]];
    }
}

@end
