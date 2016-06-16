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

/**
 *  发送一个下载文件的请求
 *
 *  @param request     请求路径
 *  @param destinationPath  文件保存的路径
 *  @param completionHandler 请求完成后的回调（请将请求完成后想做的事情写到这个block中）
 *  @param Results 将结果转化为模型数组－>文件－nsdata－转模型数组；
 */
+(void)downloadTileWithRequest:(NSURLRequest *)request andDestinationPath:(NSURL *)destinationPath completionHandler:(void (^)(id))completionHandler;


+(void)downloadTileWithParams:(id)params succsess:(void (^)(NPTilesModulesResults *result))success failure:(void (^)(NSError *error))failure;

@end
