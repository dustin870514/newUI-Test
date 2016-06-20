//
//  NPGatewaysModule.h
//  Nexpaq project
//
//  Created by ben on 16/6/17.
//  Copyright © 2016年 ben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPGatewayTileModule.h"

@interface NPGatewaysModule : NSObject

@property(nonatomic, strong)NPGatewayTileModule *tiles;

@property(nonatomic, copy) NSString *uuid;

//@property(nonatomic, strong) NSMutableArray *tiles;

@end
