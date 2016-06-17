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
#import "NPFileManager.h"

#define kNPResourceIcon   @"icon"
#define kNPResourceStatus @"status"
#define kNPResourceTitle  @"title"
#define kNPResourceText   @"text"

#define kNPTextAttSize    @"size"
#define kNPTextAttColor   @"color"

#define kNPResourceIconKeys   @"iconKeys"
#define kNPResourceStatusKeys @"statusKeys"

@implementation NPHttps_Networking_ForTiles

+(void)downloadTileWithRequest:(NSURLRequest *)request andDestinationPath:(NSURL *)destinationPath completionHandler:(void (^)(id))completionHandler{
    
    [self downloadTilesWithRequest:request resultClass:[NPTilesModules class] andDestinationPath:destinationPath andCompletionHandler:completionHandler];
    
}

+(void)downloadTileWithParams:(id)params succsess:(void (^)(NPTilesModulesResults *))success failure:(void (^)(NSError *error))failure{
    
    [self getWithUrl:@"http://vpn2.coody.top/nexpaq-app-beta-resources/tiles/" params:params resultClass:[NPTilesModulesResults class] success:success failure:failure];
    
}

+ (void)downloadTileResourceWithIdUrl:(NSString *)idUrl andId:(NSString *)Id andSuccess:(void (^)(NPTile *))success andFailure:(void (^)(NSError *erro))failure{
    
    dispatch_group_t group = dispatch_group_create();
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:Id]) {
        
        NSMutableDictionary *iconImagePaths = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *statusImagePaths = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *textAttMDict = [NSMutableDictionary dictionary];
        
        NSString *titleFilePath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",Id,kNPResourceTitle]];
        
        NSString *title = [NSString stringWithContentsOfFile:titleFilePath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *textAttsFilePath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",Id,[NSString stringWithFormat:@"%@.txt",kNPResourceText]]];
        
        NSArray *textAtts = [NSArray arrayWithContentsOfFile:textAttsFilePath];
        
        for (NSDictionary *textAttDict in textAtts) {
            
            NSString *key = textAttDict.allKeys.lastObject;
            
            NSArray *atts = textAttDict[key];
            
            NPTileTextAttribute *textAtt = [[NPTileTextAttribute alloc] init];
            
            textAtt.colorString = atts.firstObject[kNPTextAttColor];
            
            textAtt.size = [atts.lastObject[kNPTextAttSize] integerValue];
            
            [textAttMDict setObject:textAtt forKey:key];
        }
        
        NSString *iconKeysPath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",Id,kNPResourceIconKeys]];
        
        NSArray *iconKeys = [NSArray arrayWithContentsOfFile:iconKeysPath];
        
        for (NSString *key in iconKeys) {
            
            NSString *iconPaths = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",Id,[NSString stringWithFormat:@"%@.png",key]]];
            
            [iconImagePaths setObject:iconPaths forKey:key];
        }
        
        NSString *statusKeysPath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",Id,kNPResourceStatusKeys]];
        
        NSArray *statusKeys = [NSArray arrayWithContentsOfFile:statusKeysPath];
        
        for (NSString *key in statusKeys) {
            
            NSString *statusPath = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",Id,[NSString stringWithFormat:@"%@.png",key]]];
            
            [statusImagePaths setObject:statusPath forKey:key];
        }
        
        NPTile *tile = [NPTile tileWithStatusImagePaths:statusImagePaths andIconImagePaths:iconImagePaths andTextAtts:textAttMDict andTitle:title];
        
        success(tile);
        
    }else{
    
        [self get:idUrl params:nil success:^(id result) {
            
            [NPFileManager createDirectoryInDocumentWithId:Id];
            
            NSString *title = result[kNPResourceTitle];
            
            [NPFileManager stringWriteToFileId:Id andObject:title name:kNPResourceTitle];
            
            NSMutableDictionary *iconImagePaths = [NSMutableDictionary dictionary];
            
            NSMutableDictionary *statusImagePaths = [NSMutableDictionary dictionary];
            
            NSMutableDictionary *textAttMDict = [NSMutableDictionary dictionary];
            
            NSArray *textAtts = result[kNPResourceText];
            
            [NPFileManager arrayWriteToFileId:Id andObject:textAtts name:[NSString stringWithFormat:@"%@.txt",kNPResourceText]];
            
            for (NSDictionary *textAttDict in textAtts) {
                
                NSString *key = textAttDict.allKeys.lastObject;
                
                NSArray *atts = textAttDict[key];
                
                NPTileTextAttribute *textAtt = [[NPTileTextAttribute alloc] init];
                
                textAtt.colorString = atts.firstObject[kNPTextAttColor];
                
                textAtt.size = [atts.lastObject[kNPTextAttSize] integerValue];
                
                [textAttMDict setObject:textAtt forKey:key];
            }
            
            NSArray *iconUrls = result[kNPResourceIcon];
            
            NSMutableArray *iconKeys = [NSMutableArray array];
            
            for (NSDictionary *iconDict in iconUrls) {
                
                NSString *key = iconDict.allKeys.lastObject;
                
                [iconKeys addObject:key];
                
                NSString *url = iconDict[key];
                
                dispatch_group_enter(group);
                
                [self downLoadResourceWithUrl:url andId:Id andResourceName:key andSuccess:^(NSString *filePath) {
                    
                    [iconImagePaths setObject:filePath forKey:key];
                    
                    dispatch_group_leave(group);
                    
                } andFailure:^(NSError *error) {
                    
                    NSLog(@"er = %@",error);
                }];
            }
            
            [NPFileManager arrayWriteToFileId:Id andObject:iconKeys name:kNPResourceIconKeys];
            
            NSArray *statusUrls = result[kNPResourceStatus];
            
            NSMutableArray *statusKeys = [NSMutableArray array];
            
            for (NSDictionary *statusDict in statusUrls) {
                
                NSString *key = statusDict.allKeys.lastObject;
                
                [statusKeys addObject:key];
                
                NSString *url = statusDict[key];
                
                dispatch_group_enter(group);
                
                [self downLoadResourceWithUrl:url andId:Id andResourceName:key andSuccess:^(NSString *filePath) {
                    
                    [statusImagePaths setObject:filePath forKey:key];
                    
                    dispatch_group_leave(group);
                    
                } andFailure:^(NSError *error) {
                    
                    NSLog(@"er = %@",error);
                }];
                
            }
            
            [NPFileManager arrayWriteToFileId:Id andObject:statusKeys name:kNPResourceStatusKeys];
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                
                NPTile *tile = [NPTile tileWithStatusImagePaths:statusImagePaths andIconImagePaths:iconImagePaths andTextAtts:textAttMDict andTitle:title];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Id];
                
                success(tile);
            });
            
        } failure:^(NSError *er) {
            
            failure(er);
        }];

    }
}

@end
