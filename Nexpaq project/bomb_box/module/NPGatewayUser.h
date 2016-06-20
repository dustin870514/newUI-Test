//
//  NPGatewayUser.h
//  Nexpaq project
//
//  Created by ben on 16/6/17.
//  Copyright © 2016年 ben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPGatewaysModule.h"

@interface NPGatewayUser : NSObject

@property(nonatomic, copy) NSString *user;

//@property(nonatomic, strong) NPGatewaysModule *gateways;

@property(nonatomic, strong) NSMutableArray *gateways;

@end
