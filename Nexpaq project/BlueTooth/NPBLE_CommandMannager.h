//
//  NPBLE_CommandMannager.h
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/7.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPBLE_CommandString.h"
@class NPBLE_Control;

@interface NPBLE_CommandMannager : NSObject

//common Command
@property (nonatomic, strong) NPBLE_CommandString *Common_Request_Mode;
@property (nonatomic, strong) NPBLE_CommandString *Common_Request_UUID;
@property (nonatomic, strong) NPBLE_CommandString *Common_Enter_BSL;
@property (nonatomic, strong) NPBLE_CommandString *Common_Enter_APP;
@property (nonatomic, strong) NPBLE_CommandString *Common_Request_BSLInfo;
@property (nonatomic, strong) NPBLE_CommandString *Common_Request_APPInfo;
@property (nonatomic, strong) NPBLE_CommandString *Common_Erase_APP;
@property (nonatomic, strong) NPBLE_CommandString *Common_Erase_APP_Info;
@property (nonatomic, strong) NPBLE_CommandString *Common_Program_APP;
@property (nonatomic, strong) NPBLE_CommandString *Common_Error_Message;

@property (nonatomic, strong) NPBLE_CommandString *Module_Sennor_state;

@property (nonatomic, strong) NPBLE_CommandString *Case_Request_Mode_List;

@property (nonatomic, strong) NPBLE_CommandString *Set_SSID_Name;

@property (nonatomic, strong) NPBLE_CommandString *Case_Request_Battery_Status;

+ (instancetype)sharedNPBLE_CommandMannager;

+ (NSData *)NPBLE_CommandWithCommand:(NSString *)command  anddNode_id:(NSString *)node_id andParamString:(NSString *)paramString;

+ (NSData *)NPBLE_CommandWithCommand:(NSString *)command  anddNode_id:(NSString *)node_id;

+ (NSData *)NPBLE_ControlCommandWithControl:(NPBLE_Control *)control;

+ (BOOL)yesOrNoResult:(NSString *)result isEquelToResponse:(NSString *)response andParamstring:(NSString *)paramString;

+ (BOOL)yesOrNoResult:(NSString *)result isEquelToResponse:(NSString *)response;

@end
