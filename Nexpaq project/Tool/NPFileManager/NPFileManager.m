//
//  NPFileManager.m
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/22.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPFileManager.h"

@interface NPFileManager ()

@property (nonatomic, strong) NSFileManager *mannager;

@end

@implementation NPFileManager

+ (instancetype)sharedFileMannager{
    
    static NPFileManager *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
        
        instance.mannager = [NSFileManager defaultManager];
        
        instance.doucumentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        instance.tmpPath = NSTemporaryDirectory();
    });
    
    return instance;
}


+ (void)createDirectoryInDocumentWithProduct_id:(NSString *)Product_id{
    
    NSString *pathDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", pathDocument,Product_id];
    
    NPFileManager *fileMannager = [NPFileManager sharedFileMannager];
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![fileMannager.mannager fileExistsAtPath:createPath]) {
        
        [fileMannager.mannager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        
    } else {
        
        //        NSLog(@"FileDir is exists.");
    }
}

+ (NSURL *)destinationPathWithProduct_id:(NSString *)product_id andName:(NSString *)name{
    
    NSURL *path = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil]
                   URLByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",product_id,name]];
    
    return path;
}

+ (NSURL *)destinationPathWithName:(NSString *)name{
    
    NSURL *path = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil]
                   URLByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    
    return path;
}

+ (BOOL)deleteFileWithPath:(NSString *)path{
    
    NPFileManager *Filemannager = [NPFileManager sharedFileMannager];
    
    BOOL isExist = [Filemannager.mannager fileExistsAtPath:path];
    
    if (isExist) {
        
        BOOL isDelete = [Filemannager.mannager removeItemAtPath:path error:nil];
        
        if (isDelete) {
            
            NSLog(@"存在删除成功");
            
            return YES;
            
        }else{
            
            NSLog(@"删除文件失败");
            
            return NO;
        }
        
    }else{
        
        NSLog(@"不存在");
        
        return YES;
    }
    
}

+ (BOOL)isExistWithFilePath:(NSString *)filePath{
    
    NPFileManager *manager = [NPFileManager sharedFileMannager];

    return [manager.mannager fileExistsAtPath:filePath];

}

+ (NSString *)resourcePathWithProduct_id:(NSInteger)prduct_id andName:(NSString *)name{
    
    NSString *path = [[NPFileManager sharedFileMannager].doucumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%zd/%@",prduct_id,name]];
    
    return path;
}

@end
