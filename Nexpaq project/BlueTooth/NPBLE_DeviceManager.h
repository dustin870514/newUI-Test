//
//  NPBLE_DeviceManager.h
//  Blutooth API
//
//  Created by Jordan Zhou on 16/5/30.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPBLE_Device.h"

@interface NPBLE_DeviceManager : NSObject

@property (nonatomic, strong) NSMutableArray *disCoverDevices;

@property (nonatomic, strong) NSMutableArray *devices;


+ (instancetype)sharedNPBLE_DeviceManager;

+ (NPBLE_Device *)currentDeviceWithPeripheral:(CBPeripheral *)per;

@end
