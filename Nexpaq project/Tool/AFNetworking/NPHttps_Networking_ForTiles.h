//
//  NPHttps_Networking_ForTiles.h
//  Nexpaq project
//
//  Created by ben on 16/6/16.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPHttps_NetworkingTool.h"
#import "NPTilesModulesResults.h"

@interface NPHttps_Networking_ForTiles : NPHttps_NetworkingTool

+(void)downloadTileWithParams:(id)params succsess:(void (^)(NPTilesModulesResults *result))success failure:(void (^)(NSError *error))failure;



@end
