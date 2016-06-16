//
//  NPBLE_CommandString.m
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/21.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_CommandString.h"

@implementation NPBLE_CommandString

- (instancetype)initWithCommand:(NSString *)command andResponse:(NSString *)response{
    
    if (self = [super init]) {
        
        self.command = command;
        
        self.response = response;
    }
    
    return self;
}

+ (instancetype)CommandWithCommandString:(NSString *)command andResponse:(NSString *)response{
    
    return [[self alloc] initWithCommand:command andResponse:response];
    
}


@end
