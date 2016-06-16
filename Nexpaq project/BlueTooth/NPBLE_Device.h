//
//  NPBLE_Device.h
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/21.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBPeripheral.h>
#import <CoreBluetooth/CBCentralManager.h>

@interface NPBLE_Device : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong)  CBPeripheral *peripheral;

@property (nonatomic, strong) NSMutableArray *modules;

@property (nonatomic, copy) NSString *Case_uuid;

@property (nonatomic, copy) NSString *Case_uuid_long;

@property (nonatomic, copy) NSString *Case_uuid_short;

@property (nonatomic, copy) NSString *Case_bsl_info;

@property (nonatomic, assign) BOOL hasApp;

@property (nonatomic, copy) NSString *Case_app_info;

@property (nonatomic, strong) CBCharacteristic *read_write_chara;

@property (nonatomic, strong) NSMutableArray *node_list;

@property (nonatomic, strong) NSMutableArray *changeNode_list;

@property (nonatomic, assign) BOOL isAddList;

@property (nonatomic, copy) NSString *node_list_str;

@property (nonatomic, assign) BOOL isMatch;

+ (instancetype)NPBLE_DeviceWithPeripheral:(CBPeripheral *)per;



@end
