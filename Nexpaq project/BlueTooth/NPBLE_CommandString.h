//
//  NPBLE_CommandString.h
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/21.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPBLE_CommandString : NSObject

@property (nonatomic, copy) NSString *command;

@property (nonatomic, copy) NSString *response;


+ (instancetype)CommandWithCommandString:(NSString *)command andResponse:(NSString *)response;

@end
