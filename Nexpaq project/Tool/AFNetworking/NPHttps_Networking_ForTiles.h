//
//  NPHttps_Networking_ForTiles.h
//  Nexpaq project
//
//  Created by ben on 16/6/16.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPHttps_NetworkingTool.h"
#import "NPTilesModulesResults.h"
@class NPTile;

@interface NPHttps_Networking_ForTiles : NPHttps_NetworkingTool

+ (void)downloadTileWithParams:(id)params succsess:(void (^)(NPTilesModulesResults *result))success failure:(void (^)(NSError *error))failure;

+ (void)downloadTileResourceWithIdUrl:(NSString *)idUrl andId:(NSString *)Id andSuccess:(void (^)(NPTile *))success andFailure:(void (^)(NSError *erro))failure;



@end
