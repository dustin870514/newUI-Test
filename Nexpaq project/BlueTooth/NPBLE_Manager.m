//
//  NPBLE_Manager.m
//  Blutooth API
//
//  Created by Jordan Zhou on 16/5/30.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_Manager.h"
#import "NPBLE_Device.h"
#import "NPBLE_DeviceManager.h"
#import "NPBLE_Module.h"
#import "NPBLE_CommandMannager.h"
#import "NPBLE_Control.h"
#import "NSString+cut_String.h"
#import "NSData+ToString.h"
#import "NSData+CRC.h"
#import "NSString+checkCRC.h"
#import "NSString+stringToHexString.h"
#import "NPBLENotifyNameHeader.h"
#import "NPFileManager.h"
#import "NPBLE_ParseManager.h"



#define SEVERICE_UUID       @"0000fff0-0000-1000-8000-00805f9b34fb"
#define CHARA_WRITE_UUID    @"0000fff1-0000-1000-8000-00805f9b34fb"
#define CHARA_NOTIFY_UUID   @"0000fff4-0000-1000-8000-00805f9b34fb"
#define SEVERICE_UUID_SHORT @"FFF0"
#define CHARA_UUID_WRITE    @"FFF1"

#define Station_Node_id  @"01"
#define Bsl_Mode  @"00"
#define App_Mode  @"01"
#define Enter_App_Mode @"00"

@interface NPBLE_Manager ()<CBPeripheralDelegate,CBCentralManagerDelegate>

/**
 *  中心设备管理器
 */
@property (nonatomic, strong) CBCentralManager *central;

/**
 *  通知中心
 */
@property (nonatomic, strong) NSNotificationCenter *notifyCenter;

@property (nonatomic, strong) NPBLE_CommandMannager *cmd;


// --------  block 回调 ---------

@property (nonatomic, copy) void (^didDiscoverDevice)(NSArray *);

@property (nonatomic, copy) void (^didConnectedDevice)(NPBLE_Device *);

@property (nonatomic, copy) void (^updateProgressHandler)(NSString *,BOOL *);

@property (nonatomic, strong) NSMutableArray *disCoverDevices;

@property (nonatomic, assign) BOOL isUpdating;

@property (nonatomic, assign) BOOL isStopUpdating;

@property (nonatomic, assign) NSInteger programCount;

@property (nonatomic, strong) NSArray *updating_Array;

@end

@implementation NPBLE_Manager

+ (instancetype)sharedNPBLE_Manager{
    
    static NPBLE_Manager *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
        
        instance.cmd  = [NPBLE_CommandMannager sharedNPBLE_CommandMannager];
        
        instance.notifyCenter = [NSNotificationCenter defaultCenter]; //creat a notifyCenter
    });
    
    return instance;
}

#pragma mark - 蓝牙功能API

- (void)NPBLE_ScanDeviceWithCompletionHandler:(void(^)(NSArray *))completionHandler{
    
    if (self.central == nil) {
        
        self.didDiscoverDevice = completionHandler;
        
        self.central = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        
        return;
    }
    
    CBUUID *serviceUUID = [self CBUUIDWithUUIDString:SEVERICE_UUID]; //生成服务UUID
    
    [self.central scanForPeripheralsWithServices:@[serviceUUID] options:nil]; //扫描带有该服务的蓝牙外设
}


- (void)NPBLE_ConnectDevice:(NPBLE_Device *)device andCompletionHandler:(void(^)(NPBLE_Device *))completionHandler{
    
    self.didConnectedDevice = completionHandler;

    [self.central connectPeripheral:device.peripheral options:nil];//连接外设
    
    [self.central stopScan];//停止扫描
    
}

#pragma mark 蓝牙代理方法

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{//代理方法创建中心设备管理器会调用
    
    if (central.state != CBCentralManagerStatePoweredOn) {
        
        NSLog(@"蓝牙未打开");
        
        return;
    }
    
    CBUUID *serviceUUID = [self CBUUIDWithUUIDString:SEVERICE_UUID]; //生成服务UUID
    
    [self.central scanForPeripheralsWithServices:@[serviceUUID] options:nil]; //扫描带有该服务的蓝牙外设
}

// 已经发现的蓝牙设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{

    NPBLE_Device *device = [NPBLE_Device NPBLE_DeviceWithPeripheral:peripheral]; //包装NPBLE_Device
    
    [self.disCoverDevices addObject:device];
    
    [NPBLE_DeviceManager sharedNPBLE_DeviceManager].disCoverDevices  = [NSMutableArray arrayWithArray:self.disCoverDevices];
    
    self.didDiscoverDevice(self.disCoverDevices);//执行回调block
}

- (void)clearDiscoverDevices{
    
    [self.disCoverDevices removeAllObjects];
}

//已经连接的蓝牙设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{

    NPBLE_Device *device = [NPBLE_Device NPBLE_DeviceWithPeripheral:peripheral];
    
    peripheral.delegate = self;
    
    [[NPBLE_DeviceManager sharedNPBLE_DeviceManager].devices addObject:device];
    
    self.didConnectedDevice(device);//执行回调block
    
    [peripheral discoverServices:@[[self CBUUIDWithUUIDString:SEVERICE_UUID]]]; //扫描服务
}

//已经发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    for (CBService *ser in peripheral.services) {
        
        if ([ser.UUID.UUIDString isEqualToString:SEVERICE_UUID_SHORT]) {
            
            CBUUID *write_Chara_uuid = [self CBUUIDWithUUIDString:CHARA_WRITE_UUID];
           
            CBUUID *notify_Chara_uuid = [self CBUUIDWithUUIDString:CHARA_NOTIFY_UUID];
            
            [peripheral discoverCharacteristics:@[notify_Chara_uuid,write_Chara_uuid] forService:ser];
        }
    }
}

//已经发现特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    for (CBCharacteristic *chara in service.characteristics) {
        
        if ([chara.UUID.UUIDString isEqualToString:CHARA_UUID_WRITE]) {
            
            NPBLE_Device *currentDevice = [NPBLE_DeviceManager currentDeviceWithPeripheral:peripheral];
            
            currentDevice.read_write_chara = chara;
        
            NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_Mode.command anddNode_id:Station_Node_id];//生成命令通过命令控制器
            
            [self writeValue:value forDevice:currentDevice];//向蓝牙设备写入命令
    
        }else{
            
            [peripheral setNotifyValue:YES forCharacteristic:chara];
            
        }
    }
}

#pragma mark - 蓝牙通讯回调方法

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{

    NSString *result = [[characteristic.value convertDataToHexStr] uppercaseString];
    
    NSLog(@"reslut = %@",result);
    
    NPBLE_Device *currentDevice = [NPBLE_DeviceManager currentDeviceWithPeripheral:peripheral];//获得当前设备
    
    [self NPBLE_SenorDataWithResult:result andCurrentDevice:currentDevice];//监听上行数据
    
    [self NPBLE_ToUpdatingFirmwareWithNode_id:[self node_idWithResult:result] andResult:result andCurrentDevice:currentDevice];//升级模块
    
    [self NPBLE_GetInformationOfCurrentModuleByCurrentDevice:currentDevice andWithResult:result];//获得模块信息
    
    [self NPBLE_CertificateModuleResult:result andDevice:currentDevice]; //认证模块
    
    [self NPBLE_GetInformationOfCurrentDevice:currentDevice andWithResult:result];//获得case信息
    
    [self NPBLE_CertificateCaseWithResult:result andDevice:currentDevice];//认证case

}

#pragma mark 核心接口

- (void)NPBLE_CertificateCaseWithResult:(NSString *)result andDevice:(NPBLE_Device *)device{
    
    if (device.isMatch) return;
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_Mode.response andParamstring:Bsl_Mode]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_UUID.command anddNode_id:Station_Node_id];
        
        [self writeValue:value forDevice:device];
        
        return;
        
    }
    
    if([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_Mode.response andParamstring:App_Mode]){
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Enter_BSL.command anddNode_id:Station_Node_id];
        
        [self writeValue:value forDevice:device];
        
        return;
        
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Enter_BSL.response andParamstring:Bsl_Mode]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_UUID.command anddNode_id:Station_Node_id];
        
        [self writeValue:value forDevice:device];
        
        return;
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_UUID.response]) {
        
        device.Case_uuid_long = result;
        
        return;
        
    }else if(result.length == 12){
        
        device.Case_uuid_short = result;
        
        NSDictionary *userInfo = @{NPBLE_NOTIFY_DEVICE:device};
        
        [self.notifyCenter postNotificationName:NPBLE_NOTIFY_DEVICEGETUUID object:nil userInfo:userInfo];
    }
}


- (void)NPBLE_RequestInformationOfCurrentDevice:(NPBLE_Device *)device{
  
    if (device.isMatch && device.Case_app_info == nil) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_BSLInfo.command anddNode_id:Station_Node_id];
        
        [self writeValue:value forDevice:device];
    }
}

- (void)NPBLE_GetInformationOfCurrentDevice:(NPBLE_Device *)device andWithResult:(NSString *)result{
    
    if (device.Case_app_info || !device.isMatch) return;
  
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_BSLInfo.response]) {
        
        device.Case_bsl_info = [result cutStringWithLocation:14 andLenth:3 * 2];
        
        device.hasApp = [[result cutStringWithLocation:20 andLenth:1 * 2] integerValue];
        
        if (device.hasApp) {
            
            NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Enter_APP.command anddNode_id:Station_Node_id];
            
            [self writeValue:value forDevice:device];
            
        }else{
            
           
        }
        
        return;
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Enter_APP.response andParamstring:Enter_App_Mode]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_APPInfo.command anddNode_id:Station_Node_id];
        
        [self writeValue:value forDevice:device];
        
        return;
    }
    
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_APPInfo.response]) {
        
        device.Case_app_info = [result cutStringWithLocation:14 andLenth:3 * 2];
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Case_Request_Mode_List.command anddNode_id:Station_Node_id];
        
        [self writeValue:value forDevice:device];
        
        NPBLE_Module *module = [[NPBLE_Module alloc] init];
        
        module.product_id = @"10";
        
        module.node_id = @"01";
        
        module.bsl_version = device.Case_bsl_info;
        
        module.app_vsersion = device.Case_app_info;
        
        module.module_uuid = device.Case_uuid;
        
        [device.modules addObject:module];
        
        return;
    }
}

- (void)NPBLE_CertificateModuleResult:(NSString *)result andDevice:(NPBLE_Device *)device{
    
    if (!device.isMatch) return;
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Case_Request_Mode_List.response]) {
        
        device.node_list_str = [result cutStringWithLocation:14 andLenth:2];
        
        if (device.isAddList) {
            
            for (NSString *node_id in device.changeNode_list) {
                
                NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_Mode.command anddNode_id:node_id];
                
                [self writeValue:value forDevice:device];
            }
            
        }else{
            
            NPBLE_Module *currentModule = [self currentModuleWithDevice:device];
            
            [device.modules removeObject:currentModule];
            
            currentModule.node_id = device.changeNode_list[0];
            
            NSDictionary *userInfo = @{NPBLE_NOTIFY_MODULE:currentModule};
            
            [self.notifyCenter postNotificationName:NPBLE_NOTIFY_MODULEPULLOUT object:nil userInfo:userInfo];
        }
        
        return;
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_Mode.response andParamstring:Bsl_Mode]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_UUID.command anddNode_id:[self node_idWithResult:result]];
        
        [self writeValue:value forDevice:device];
        
        return;
        
    }else if([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_Mode.response andParamstring:App_Mode]){
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Enter_BSL.command anddNode_id:[self node_idWithResult:result]];
        
        [self writeValue:value forDevice:device];
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Enter_BSL.response andParamstring:@"00"]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_UUID.command anddNode_id:[self node_idWithResult:result ]];
        
        [self writeValue:value forDevice:device];
        
        return;
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_UUID.response]) {
        
        NPBLE_Module *module = [[NPBLE_Module alloc] init];
        
        module.module_uuid_long = result;
        
        module.node_id = [self node_idWithResult:result];
        
        [device.modules addObject:module];
        
        return;
        
    }else if (result.length == 12){
        
        NPBLE_Module *currentModule = nil;
        
        for (NPBLE_Module *module in device.modules) {
            
            NSString *temp_uuid = [module.module_uuid_long stringByAppendingString:result];
            
            if ([temp_uuid uuidCheckCRCIsMatch]) {
                
                module.module_uuid_short = result;
                
                currentModule = module;
                
                break;
            }
        }
        
        NSDictionary *userInfo = @{NPBLE_NOTIFY_MODULE:currentModule,
                                   NPBLE_NOTIFY_DEVICE:device
                                   };
        
        [self.notifyCenter postNotificationName:NPBLE_NOTIFY_MODULEGETUUID object:nil userInfo:userInfo];
    }
}

- (void)NPBLE_RequestInformationOfCurrentModule:(NPBLE_Module *)module andInCurrentDevice:(NPBLE_Device *)device{

    NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_BSLInfo.command anddNode_id:module.node_id];
    
    [self writeValue:value forDevice:device];
}

- (void)NPBLE_GetInformationOfCurrentModuleByCurrentDevice:(NPBLE_Device *)device andWithResult:(NSString *)result{
    
    NPBLE_Module *currentModule = [self currentModuleWithDevice:device andResult:result];
    
    if (!currentModule.isMatch) return;
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_BSLInfo.response]) {
        
        currentModule.bsl_info = [result cutStringWithLocation:14 andLenth:4 * 2];
        
        if (currentModule.hasApp) {
            
            NSData *data = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Enter_APP.command anddNode_id:currentModule.node_id];
            
            [self writeValue:data forDevice:device];
            
        }else{
            
            
        }
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Enter_APP.response andParamstring:Enter_App_Mode]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_APPInfo.command anddNode_id:currentModule.node_id];
        
        [self writeValue:value forDevice:device];
        
        return;
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_APPInfo.response]) {
        
        currentModule.app_info = [result cutStringWithLocation:14 andLenth:3*2];
        
        NSDictionary *userInfo = @{NPBLE_NOTIFY_MODULE:currentModule};
        
        [self.notifyCenter postNotificationName:NPBLE_NOTIFY_REFRSHUI object:nil userInfo:userInfo];
        
        return;
    }
}

- (void)NPBLE_ControlModuleWithCurrentModule:(NPBLE_Module *)module andCurrentDevice:(NPBLE_Device *)device andHTMLCommand:(NSString *)command{
    
    NPBLE_Control *control = [NPBLE_ParseManager NPBLE_ParseControlWithModule:module andDevice:device andHTMLCommand:command];
  
    NSData *value = [NPBLE_CommandMannager NPBLE_ControlCommandWithControl:control];
    
    if (value == nil) return;
    
    [self writeValue:value forDevice:control.device];
}

- (void)NPBLE_SenorDataWithResult:(NSString *)result andCurrentDevice:(NPBLE_Device *)currentDevice{
    
    if (![NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Module_Sennor_state.response]) return;
    
    NSString *node_id = [self node_idWithResult:result];
    
    NSInteger dataLenth = [[result cutStringWithLocation:12 andLenth:2] integerValue];
    
    NSString *dataString = [result cutStringWithLocation:14 andLenth:dataLenth * 2];
    
    NPBLE_Module *currentModule = nil;
    
    for (NPBLE_Module *module in currentDevice.modules) {
        
        if ([module.node_id isEqualToString:node_id]) {
            
            currentModule = module;
            
            break;
        }
    }
    
    NSString *callBack = [NPBLE_ParseManager NPBLE_ParseSenorDataWithModule:currentModule andDataString:dataString];
    
    NSString *eventsfilePath = [[NPFileManager sharedFileMannager].tmpPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_app_%@/events.js",currentModule.product_id,currentModule.version.app]];
    
    if ([NPFileManager isExistWithFilePath:eventsfilePath]) {
        
        NSString *filePath = [[NPFileManager sharedFileMannager].tmpPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_app_%@/index.html",currentModule.product_id,currentModule.version.app]];
        

    }else{
        
       
        
    }
}

- (void)NPBLE_RequestUpDateFirmwareWithModel:(NPBLE_Module *)module andDevice:(NPBLE_Device *)device andProgressHandler:(void(^)(NSString * ,BOOL *))progressHandler{

    self.isUpdating = YES;
    
    self.updateProgressHandler = progressHandler;
    
     NSString *filePath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@_firmware.txt",module.product_id,module.version.firmware]];
    
    self.updating_Array = [[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\r\n"];
    
    NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Request_Mode.command anddNode_id:module.node_id];
    
    [self writeValue:value forDevice:device];
}

- (void)NPBLE_ToUpdatingFirmwareWithNode_id:(NSString *)node_id andResult:(NSString *)result andCurrentDevice:(NPBLE_Device *)device{

    if (!self.isUpdating) return;
    
    if (self.isStopUpdating) return;
    
    if (self.programCount == self.updating_Array.count) {
        
        NSLog(@"烧写成功");
        
        [self writeValue:[NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Enter_APP.command anddNode_id:node_id] forDevice:device];
        
        self.isUpdating = NO;
        
        self.programCount = 0;
        
        return;
    }
    
    [self NPBLE_EnterBsl_ModeAndEraseAPPWithResult:result andNode_id:node_id andCurrentDevice:device];
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Erase_APP.response andParamstring:@"00"]) {
        
        [self writeValue:[NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Program_APP.command anddNode_id:node_id andParamString:[self.updating_Array.firstObject ASCHexStringWithString]] forDevice:device];
        
        self.programCount = 1;
        
        return;
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Program_APP.response andParamstring:@"00"]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Program_APP.command anddNode_id:node_id andParamString:[self.updating_Array[self.programCount] ASCHexStringWithString]];
        
        [self writeValue:value forDevice:device];
        
        NPBLE_Module *module = [self currentModuleWithDevice:device andResult:result];
        
        self.programCount ++;
        
        NSInteger progressCount = (self.programCount / self.updating_Array.count) * 100;
        
        NSString *progress = [NSString stringWithFormat:@"%zd",progressCount];
        
        BOOL *stop = &_isUpdating;
        
        self.updateProgressHandler(progress,stop);
        
        return;
        
    }
}

- (void)NPBLE_EnterBsl_ModeAndEraseAPPWithResult:(NSString *)result andNode_id:(NSString *)node_id andCurrentDevice:(NPBLE_Device *)device{

    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_Mode.response andParamstring:@"00"]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Erase_APP.command anddNode_id:node_id];
        
        [self writeValue:value forDevice:device];
        
        return;
        
    }else if([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Request_Mode.response andParamstring:@"01"]){
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Enter_BSL.command anddNode_id:node_id];
        
        [self writeValue:value forDevice:device];
        
        return;
    }
    
    if ([NPBLE_CommandMannager yesOrNoResult:result isEquelToResponse:self.cmd.Common_Enter_BSL.response andParamstring:@"00"]) {
        
        NSData *value = [NPBLE_CommandMannager NPBLE_CommandWithCommand:self.cmd.Common_Erase_APP.command anddNode_id:node_id];
        
        [self writeValue:value forDevice:device];
        
        return;
    }
}


#pragma mark Other Method

- (CBUUID *)CBUUIDWithUUIDString:(NSString *)UUIDString{
    
    return  [CBUUID UUIDWithString:UUIDString];
}

- (void)writeValue:(NSData *)value forDevice:(NPBLE_Device *)device {
    
    [device.peripheral writeValue:value forCharacteristic:device.read_write_chara type:CBCharacteristicWriteWithResponse];
    
}

- (NSString *)node_idWithResult:(NSString *)result{
    
    return [result cutStringWithLocation:2 andLenth:2];
}

- (NPBLE_Module *)currentModuleWithDevice:(NPBLE_Device *)device{
    
    NPBLE_Module *currentModule = nil;
    
    for (NPBLE_Module *module in device.modules) {
        
        NSLog(@" %@ ",device.changeNode_list.lastObject);
        
        if ([module.node_id integerValue] == [device.changeNode_list.lastObject integerValue]) {
            
            currentModule = module;
            
            return currentModule;
        }
    }
    
    return nil;
}

- (NPBLE_Module *)currentModuleWithDevice:(NPBLE_Device *)device andResult:(NSString *)result{
    
    NPBLE_Module *currentModule = nil;
    
    for (NPBLE_Module *module in device.modules) {
        
        if ([module.node_id isEqualToString:[self node_idWithResult:result]]) {
            
            currentModule = module;
            
            return currentModule;
        }
    }
    
    return nil;
}

#pragma mark - getter && setter 

- (NSMutableArray *)disCoverDevices{

    if (_disCoverDevices == nil) {
        
        _disCoverDevices = [NSMutableArray array];
    }
  
    return _disCoverDevices;
}

@end
