//
//  NPHttps_Networking_ForTiles.m
//  Nexpaq project
//
//  Created by ben on 16/6/16.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPHttps_Networking_ForTiles.h"
#import "NPTilesModulesResults.h"
#import "NPTileTextAttribute.h"
#import "NPTilesModules.h"
#import "NPTile.h"

#define kNPResourceIcon   @"icon"
#define kNPResourceStatus @"status"
#define kNPResourceTitle  @"title"
#define kNPResourceText   @"text"

#define kNPTextAttSize    @"size"
#define kNPTextAttColor   @"color"

@implementation NPHttps_Networking_ForTiles

+(void)downloadTileWithRequest:(NSURLRequest *)request andDestinationPath:(NSURL *)destinationPath completionHandler:(void (^)(id))completionHandler{
    
    [self downloadTilesWithRequest:request resultClass:[NPTilesModules class] andDestinationPath:destinationPath andCompletionHandler:completionHandler];
}

+(void)downloadTileWithParams:(id)params succsess:(void (^)(NPTilesModulesResults *))success failure:(void (^)(NSError *error))failure{
    
    [self getWithUrl:@"http://vpn2.coody.top/nexpaq-app-beta-resources/tiles/" params:params resultClass:[NPTilesModulesResults class] success:success failure:failure];
    
}

+ (void)downloadTileResourceWithIdUrl:(NSString *)idUrl andId:(NSString *)Id andSuccess:(void (^)(NPTile *))success andFailure:(void (^)(NSError *erro))failure{
    
    dispatch_group_t group = dispatch_group_create();
    
   [self get:idUrl params:nil success:^(id result) {
       
       NSString *title = result[kNPResourceTitle];
       
       NSMutableDictionary *iconImagePaths = [NSMutableDictionary dictionary];
       
       NSMutableDictionary *statusImagePaths = [NSMutableDictionary dictionary];
       
       NSMutableDictionary *textAttMDict = [NSMutableDictionary dictionary];
       
       NSArray *textAtts = result[kNPResourceText];
       
       for (NSDictionary *textAttDict in textAtts) {
           
           NSString *key = textAttDict.allKeys.lastObject;
           
           NSArray *atts = textAttDict[key];
           
           NPTileTextAttribute *textAtt = [[NPTileTextAttribute alloc] init];
           
           textAtt.colorString = atts.firstObject[kNPTextAttColor];
           
           textAtt.size = [atts.lastObject[kNPTextAttSize] integerValue];
           
           [textAttMDict setObject:textAtt forKey:key];
       }
       
       NSArray *iconUrls = result[kNPResourceIcon];
       
       for (NSDictionary *iconDict in iconUrls) {
           
           NSString *key = iconDict.allKeys.lastObject;
           
           NSString *url = iconDict[key];
           
           dispatch_group_enter(group);
           
           [self downLoadResourceWithUrl:url andId:Id andResourceName:key andSuccess:^(NSString *filePath) {
               
               [iconImagePaths setObject:filePath forKey:key];
               
               dispatch_group_leave(group);
               
           } andFailure:^(NSError *error) {
               
               NSLog(@"er = %@",error);
           }];
       }
       
       NSArray *statusUrls = result[kNPResourceStatus];
       
       for (NSDictionary *statusDict in statusUrls) {
           
           NSString *key = statusDict.allKeys.lastObject;
           
           NSString *url = statusDict[key];
           
           dispatch_group_enter(group);
           
           [self downLoadResourceWithUrl:url andId:Id andResourceName:key andSuccess:^(NSString *filePath) {
               
               [statusImagePaths setObject:filePath forKey:key];
               
               dispatch_group_leave(group);
               
           } andFailure:^(NSError *error) {
               
               NSLog(@"er = %@",error);
           }];
           
       }
       
       dispatch_group_notify(group, dispatch_get_main_queue(), ^{
           
           NPTile *tile = [NPTile tileWithStatusImagePaths:statusImagePaths andIconImagePaths:iconImagePaths andTextAtts:textAttMDict andTitle:title];
           
           success(tile);///Users/Jordan/Library/Developer/CoreSimulator/Devices/A3788496-2A47-4DD3-BAB6-A97E479319C1/data/Containers/Data/Application/BE23C10E-7E32-49CB-AEAF-52679837F7F8/Documents/1004/middle"
       });
      
  } failure:^(NSError *er) {
      
      failure(er);
  }];

}

@end
