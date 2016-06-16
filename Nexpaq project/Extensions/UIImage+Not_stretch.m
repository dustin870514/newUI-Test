//
//  UIImage+Not_stretch.m
//  NexpaqMain-project
//
//  Created by Kevin on 16/3/17.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "UIImage+Not_stretch.h"

@implementation UIImage (Not_stretch)

+ (instancetype)imageNotStretchWithName:(NSString *)name{

    UIImage *image = [UIImage imageNamed:name];
    
  return  [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];

}

+ (instancetype)imageOrginWithName:(NSString *)name{

    UIImage *image = [UIImage imageNamed:name];

    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;

}

+ (instancetype)imageOrginWithImage:(UIImage *)image{

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (instancetype)imageNotStretch{


  return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];

}

@end
