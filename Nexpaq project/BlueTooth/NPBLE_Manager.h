//
//  NPBLE_Manager.h
//  Blutooth API
//
//  Created by Jordan Zhou on 16/5/30.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//  该类主要用来实现app与蓝牙设备的通讯

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@class NPBLE_Device;
@class NPBLE_Control;
@class NPBLE_Module;



@interface NPBLE_Manager : NSObject

/**
 *  单例方法
 *
 *  @return 蓝牙管理器实例对象
 */
+ (instancetype)sharedNPBLE_Manager;

//  --------------- 功能接口 API -----------------------
/**
 *  扫描蓝牙设备
 */
- (void)NPBLE_ScanDeviceWithCompletionHandler:(void(^)(NSArray *))completionHandler;
/**
 *  连接设备
 *
 *  @param device  蓝牙设备实例对象
 */

/**
 *  清理发现设备的数组
 */
- (void)clearDiscoverDevices;

- (void)NPBLE_ConnectDevice:(NPBLE_Device *)device andCompletionHandler:(void(^)(NPBLE_Device *))completionHandler;
/**
 *   请求获取case信息
 *
 *  @param device case
 */
- (void)NPBLE_RequestInformationOfCurrentDevice:(NPBLE_Device *)device;
/**
 *  请求获取模块信息
 *
 *  @param module 模块
 *  @param device 模块所在case
 */
- (void)NPBLE_RequestInformationOfCurrentModule:(NPBLE_Module *)module andInCurrentDevice:(NPBLE_Device *)device;

/**
 *  控制模块
 *
 *  @param control  控制模块实例对象
 */
- (void)NPBLE_ControlModuleWithCurrentModule:(NPBLE_Module *)module andCurrentDevice:(NPBLE_Device *)device andHTMLCommand:(NSString *)command;
/**
 *  升级模块
 *
 *  @param module          模块
 *  @param device          模块所在case
 *  @param progressHandler 进度回调
 */
- (void)NPBLE_RequestUpDateFirmwareWithModel:(NPBLE_Module *)module andDevice:(NPBLE_Device *)device andProgressHandler:(void(^)(NSString * ,BOOL *))progressHandler;

@end
