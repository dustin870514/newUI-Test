//
//  NPFileManager.h
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/22.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPFileManager : NSObject

@property (nonatomic, copy) NSString *doucumentPath;

@property (nonatomic, strong) NSString *tmpPath;

+ (instancetype)sharedFileMannager;

+ (void)createDirectoryInDocumentWithProduct_id:(NSString *)Product_id;

+ (NSURL *)destinationPathWithProduct_id:(NSString *)product_id andName:(NSString *)name;

+ (NSURL *)destinationPathWithName:(NSString *)name;

+ (BOOL)deleteFileWithPath:(NSString *)product_id;

+ (BOOL)isExistWithFilePath:(NSString *)filePath;

+ (NSString *)resourcePathWithProduct_id:(NSInteger)prduct_id andName:(NSString *)name;

@end
