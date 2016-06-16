//
//  NPBLE_Module.h
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/8.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NPBLE_Module_Info.h"
#import "NPBLE_ModuleVersion.h"

@interface NPBLE_Module : NSObject

@property (nonatomic, copy) NSString *node_id;

@property (nonatomic, copy) NSString *product_id;

@property (nonatomic, copy) NSString *module_uuid;

@property (nonatomic, copy) NSString *module_uuid_long;

@property (nonatomic, copy) NSString *module_uuid_short;

@property (nonatomic, assign) BOOL isMatch;

@property (nonatomic, copy) NSString *bsl_info;

@property (nonatomic, copy) NSString *app_info;

@property (nonatomic, copy) NSString *bsl_version;

@property (nonatomic, copy) NSString *app_vsersion;

@property (nonatomic, copy) UIImage *settingImage;

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, strong) NPBLE_Module_Info *info;

@property (nonatomic, strong) NPBLE_ModuleVersion *version;

@property (nonatomic, copy) NSString *Electricity;

@property (nonatomic, assign) BOOL hasApp;

@property (nonatomic, assign) BOOL isRotating;



+ (instancetype)moduleWithMoule:(NPBLE_Module *)module;

@end
