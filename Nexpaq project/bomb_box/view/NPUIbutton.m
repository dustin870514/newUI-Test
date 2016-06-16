//
//  NPUIbutton.m
//  Nexpaq Beta project
//
//  Created by ben on 16/6/13.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPUIbutton.h"
#import "UIView+Extension.h"

@implementation NPUIbutton

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
//        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        self.adjustsImageWhenHighlighted = NO;
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

/**
*  设置内部图标的frame
*/
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageX = 5;
    CGFloat imageW = self.width*0.25;
    CGFloat imageH = self.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  设置内部文字的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = self.width*0.25 + 15 ;
    CGFloat titleH = self.height;
    CGFloat titleW = self.width - self.width*0.25 - 15;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
