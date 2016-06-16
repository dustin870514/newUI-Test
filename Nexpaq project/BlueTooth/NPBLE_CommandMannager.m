//
//  NPBLE_CommandMannager.m
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/7.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_CommandMannager.h"
#import "NSString+ToData.h"
#import "NSString+stringToHexString.h"
#import "NSString+cut_String.h"
#import "NSString+ToData.h"
#import "NSData+CRC.h"
#import "NPBLE_Control.h"
//#import "NPBLE_Control.h"

@implementation NPBLE_CommandMannager

+ (instancetype)sharedNPBLE_CommandMannager{

        static NPBLE_CommandMannager *instance = nil;
        
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            
            instance = [[self alloc] init];
            
            [instance setupCommand];
            
        });
        
        return instance;
}

#pragma mark - Certificate Module
/**
 *  Create Command
 *
 *  @param command     Funcation
 *  @param node_id     node_id
 *  @param paramString param we need send to device
 *
 *  @return command
 */
+ (NSData *)NPBLE_CommandWithCommand:(NSString *)command  anddNode_id:(NSString *)node_id andParamString:(NSString *)paramString{
    
    if (command == nil) {
        
        return nil;
    }
    
    if (paramString == nil) {
        
        paramString = @"";
    }

    NSInteger hexParamStringLenth = paramString.length / 2;
    
    NSString *hexParamStringLenthString = [[NSString stringWithFormat:@"%zd",hexParamStringLenth] hexStringFromString];
    
    NSString *contentLenth = [[NSString stringWithFormat:@"%zd",hexParamStringLenth + 3] hexStringFromString];
    
    NSString *receiver = [node_id hexStringFromString];
    
    NSString *content = [NSString stringWithFormat:@"00%@%@%@%@%@",receiver,contentLenth,command,hexParamStringLenthString,paramString];
    
    NSData *contentData = [content convertHexStrToData];
    
    NSString *crc_result = [[NSString stringWithFormat:@"%04x",[contentData crc16Checksum]] uppercaseString];
    
    NSString *FinalCommand = [NSString stringWithFormat:@"7E%@%@7E",content,crc_result];
    
    NSLog(@"FilnalCommand = %@",FinalCommand);
    
    return [NSString commandDataWithString:FinalCommand];

}
/**
 *  Create Command without param
 *
 *  @param command Funcation
 *  @param node_id node_id
 *
 *  @return command without param
 */
+ (NSData *)NPBLE_CommandWithCommand:(NSString *)command  anddNode_id:(NSString *)node_id{

   return  [self NPBLE_CommandWithCommand:command anddNode_id:node_id andParamString:nil];

}
/**
 *  Create Control Command
 *
 *  @param control Control object
 *
 *  @return control command
 */
+ (NSData *)NPBLE_ControlCommandWithControl:(NPBLE_Control *)control{
    
    NSString *node_idStr = [NSString stringWithFormat:@"%zd",control.node_id];

  return  [self NPBLE_CommandWithCommand:control.command anddNode_id:node_idStr  andParamString:control.param];

}
/**
 *  Match Result With Response
 *
 *  @param result      Device send to us
 *  @param response    Response We want the result shoud be match
 *  @param paramString Param the result take along
 *
 *  @return Yes or no
 */
+ (BOOL)yesOrNoResult:(NSString *)result isEquelToResponse:(NSString *)response andParamstring:(NSString *)paramString{

    if ([[result cutStringWithLocation:8 andLenth:4] isEqualToString:response] && [[result cutStringWithLocation:14 andLenth:2] isEqualToString:paramString]) {
        
        return YES;
    }

    return NO;
}
/**
 *  Match Result With Response Without Param
 *
 *  @param result   Device send to us without param
 *  @param response  Response We want the result shoud be match
 *
 *  @return Yes or no
 */
+ (BOOL)yesOrNoResult:(NSString *)result isEquelToResponse:(NSString *)response{

    if ([[result cutStringWithLocation:8 andLenth:4] isEqualToString:response]) {
        
        return YES;
    }
    
    return NO;
}
//Set up command manager
- (void)setupCommand{
    
    self.Common_Request_Mode = [NPBLE_CommandString CommandWithCommandString:@"080E" andResponse:@"080F"];
    self.Common_Request_UUID = [NPBLE_CommandString CommandWithCommandString:@"0808" andResponse:@"0809"];
    self.Common_Enter_BSL = [NPBLE_CommandString CommandWithCommandString:@"0806" andResponse:@"0807"];
    self.Common_Request_BSLInfo = [NPBLE_CommandString CommandWithCommandString:@"080A" andResponse:@"080B"];
    self.Common_Request_APPInfo = [NPBLE_CommandString CommandWithCommandString:@"080C" andResponse:@"080D"];
    self.Common_Enter_APP = [NPBLE_CommandString CommandWithCommandString:@"0800" andResponse:@"0801"];
    self.Common_Erase_APP = [NPBLE_CommandString CommandWithCommandString:@"0802" andResponse:@"0803"];
    self.Common_Erase_APP_Info = [NPBLE_CommandString CommandWithCommandString:@"0810" andResponse:@"0811"];
    self.Common_Program_APP = [NPBLE_CommandString CommandWithCommandString:@"0804" andResponse:@"0805"];
    self.Common_Error_Message = [NPBLE_CommandString CommandWithCommandString:nil andResponse:@"0480"];
    
    self.Case_Request_Mode_List = [NPBLE_CommandString CommandWithCommandString:@"0B02" andResponse:@"0B03"];
    self.Module_Sennor_state = [NPBLE_CommandString CommandWithCommandString:nil andResponse:@"2800"];
    
    self.Set_SSID_Name = [NPBLE_CommandString CommandWithCommandString:@"0A06" andResponse:@"0A07"];
    
    self.Case_Request_Battery_Status = [NPBLE_CommandString CommandWithCommandString:@"0B0C" andResponse:@"4600"];
    
}

@end
