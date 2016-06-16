//
//  NPHttps_Networking_ForTiles.m
//  Nexpaq project
//
//  Created by ben on 16/6/16.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPHttps_Networking_ForTiles.h"
#import "NPTilesModulesResults.h"

@implementation NPHttps_Networking_ForTiles

+(void)downloadTileWithParams:(id)params succsess:(void (^)(NPTilesModulesResults *))success failure:(void (^)(NSError *error))failure{

    [self getWithUrl:@"http://vpn2.coody.top/nexpaq-app-beta-resources/tiles/" params:params resultClass:[NPTilesModulesResults class] success:success failure:failure];

}

@end
