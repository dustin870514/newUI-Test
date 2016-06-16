//
//  NPHttps_NetworkingTool.m
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPHttps_NetworkingTool.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@implementation NPHttps_NetworkingTool

+(void)downloadTilesWithRequest:(NSURLRequest *)request andDestinationPath:(NSURL *)destinationPath andCompletionHandler:(void(^)(NSString *))completionHandler{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [urlSessionManager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode == 404) return nil;
        
        return destinationPath;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (completionHandler) {
            
            completionHandler(filePath.path);
        }
    }];
    
    [downloadTask resume];
}

+(void)downloadTilesWithRequest:(NSURLRequest *)request resultClass:(Class)resultClass andDestinationPath:(NSURL *)destinationPath andCompletionHandler:(void (^)(id))completionHandler{
    
    [self downloadTilesWithRequest:request andDestinationPath:destinationPath andCompletionHandler:^(NSString *filePath) {
        
        if (completionHandler) {
            
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            
            NSMutableArray *tempArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            id result = [resultClass mj_objectArrayWithKeyValuesArray:tempArray];
            
            completionHandler(result);
        }
    }];
}




+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html", nil];

    [sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
        }
    }];
}

+(void)getWithUrl:(NSString *)url params:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    NSDictionary *params = [param mj_keyValues];
    
    [self get:url params:params success:^(id responseObj) {
        
        if (success) {
            
            id result = [resultClass mj_objectWithKeyValues:responseObj];//convert the responseObj to resultClass
            
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
        }
    }];

}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
        }
    }];
    
}

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    NSDictionary *params = [param mj_keyValues];
    
    [self post:url params:params success:^(id responseObj) {
        
        if (success) {
            
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            
            success(result);
        }
        
    } failure:^(NSError *error){
    
        if (failure) {
            
            failure(error);
        }
    }];
}

@end
