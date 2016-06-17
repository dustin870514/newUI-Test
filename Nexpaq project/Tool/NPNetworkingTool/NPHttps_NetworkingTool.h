//
//  NPHttps_NetworkingTool.h
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 ben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPHttps_NetworkingTool : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  发送一个GET请求－－得到一个模型数组，通过遍历数组久可以取得所有的具体模型数据 NPTilesModulesResults *result－>result.modulesArray；
 *
 *  @param url     请求路径
 *  @param param  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中－把结果都转化为一个模型数组）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)getWithUrl:(NSString *)url params:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  发送一个POST请求---只普通参数；
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)downLoadResourceWithUrl:(NSString *)url andId:(NSString *)Id andResourceName:(NSString *)name andSuccess:(void (^)(NSString *))success andFailure:(void (^)(NSError *))failure;

@end
