//
//  NPBLE_DeviceManager.m
//  Blutooth API
//
//  Created by Jordan Zhou on 16/5/30.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_DeviceManager.h"
#import "NPBLE_Device.h"

@implementation NPBLE_DeviceManager

+ (instancetype)sharedNPBLE_DeviceManager{

    static NPBLE_DeviceManager *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    
    return instance;
}


+ (NPBLE_Device *)currentDeviceWithPeripheral:(CBPeripheral *)per{
    
    NPBLE_DeviceManager *manager = [NPBLE_DeviceManager sharedNPBLE_DeviceManager];
    
    for (NPBLE_Device *device in manager.devices) {
        
        if (device.peripheral == per) {
            
            return device;
        }
    }
    
    return nil;
}


#pragma mark - setter && getter

- (NSMutableArray *)disCoverDevices{

    if (_disCoverDevices == nil) {
        
        _disCoverDevices = [NSMutableArray array];
    }
  
    return _disCoverDevices;
}

- (NSMutableArray *)devices{

    if (_devices == nil) {
        
        _devices = [NSMutableArray array];
    }
  
    return _devices;
}

@end
