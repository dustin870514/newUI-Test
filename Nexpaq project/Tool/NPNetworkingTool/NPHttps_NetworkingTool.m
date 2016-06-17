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
#import "NPFileManager.h"

#define baseUrl @"http://vpn2.coody.top/nexpaq-app-beta-resources/tiles"

@implementation NPHttps_NetworkingTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{

    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    
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

+ (void)getWithUrl:(NSString *)url params:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{

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

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{

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

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{

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

+ (void)downLoadResourceWithUrl:(NSString *)url andId:(NSString *)Id andResourceName:(NSString *)name andSuccess:(void (^)(NSString *))success andFailure:(void (^)(NSError *))failure{

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [NPFileManager createDirectoryInDocumentWithId:Id];
    
    NSURL *destinationPath = [NPFileManager destinationPathWithId:Id andName:[NSString stringWithFormat:@"%@.png",name]];
                                            
    [[sessionManager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return destinationPath;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        success(filePath.path);
        
        if (error) {
            
            failure(error);
        }
        
    }]  resume];
}

@end
