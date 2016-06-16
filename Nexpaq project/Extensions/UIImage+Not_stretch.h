//
//  UIImage+Not_stretch.h
//  NexpaqMain-project
//
//  Created by Kevin on 16/3/17.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Not_stretch)

+ (instancetype)imageNotStretchWithName:(NSString *)name;

+ (instancetype)imageOrginWithName:(NSString *)name;

+ (instancetype)imageOrginWithImage:(UIImage *)image;

- (instancetype)imageNotStretch;

@end
