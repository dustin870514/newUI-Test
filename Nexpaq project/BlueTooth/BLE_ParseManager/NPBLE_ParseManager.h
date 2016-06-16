//
//  NPBLE_ParseManager.h
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/28.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NPBLE_Control;
@class NPBLE_Module;
@class NPBLE_Device;

@interface NPBLE_ParseManager : NSObject

+ (NPBLE_Control *)NPBLE_ParseControlWithModule:(NPBLE_Module *)module   andDevice:(NPBLE_Device *)device andHTMLCommand:(NSString *)command;

+ (NSString *)NPBLE_ParseSenorDataWithModule:(NPBLE_Module *)module andDataString:(NSString *)dataString;

@end
