//
//  UIImage+Extension.h
//  Nexpaq Beta project
//
//  Created by USER on 16/6/2.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)resizedImage:(NSString *)name;

- (UIImage *)resizedImage:(UIImage *)image;

@end
