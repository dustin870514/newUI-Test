//
//  NPInternalBattryView.m
//  Nexpaq Beta project
//
//  Created by USER on 16/6/2.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPInternalBattryView.h"
#import "UIView+Extension.h"

// 颜色
#define HMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define HMRandomColor HMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface NPInternalBattryView()

@property(strong, nonatomic)UILabel *titleLabel;

@end

@implementation NPInternalBattryView

-(UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        self.titleLabel = [[UILabel alloc] init];
        
        self.titleLabel.text = @"Internal Battry";
        
        self.titleLabel.textColor = [UIColor blackColor];
        
        self.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    
    return _titleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        CGFloat marginX = 5;
        
        CGFloat marginY = 5;
        
        self.titleLabel.frame = CGRectMake(marginX , marginY , self.width - marginX * 2, (self.height - 2 * marginY) * 0.2);
        
        UIView *detailView = [self setupDetailViews];
        
        [self addSubview:self.titleLabel];
        
        [self addSubview:detailView];
        
    }
    
    return self;
}

-(UIView *)setupDetailViews{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.titleLabel.frame) + 10, self.width - 10, (self.height - 2 * 5) * 0.8)];
    view.layer.cornerRadius = 8;
    view.layer.borderWidth = 1.5;
    view.layer.borderColor = [UIColor greenColor].CGColor;
    view.layer.masksToBounds = YES;
    
    [self showInteralDetailViews:view];
    
    return view;
}

-(void)showInteralDetailViews:(UIView *)view{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, view.width*0.3, view.height - 10 )];

    imageView.image = [UIImage imageNamed:@"battry"];
    
    UILabel *showBattryNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 5, view.width-imageView.width, view.height*0.5)];
    
    showBattryNumLabel.text = [NSString stringWithFormat:@"%@",@"89%"];
    showBattryNumLabel.font = [UIFont systemFontOfSize:32];
    
    UILabel *descripeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5 , CGRectGetMaxY(showBattryNumLabel.frame), (view.frame.size.width-imageView.frame.size.width) * 0.6, view.frame.size.height*0.35)];
    
    descripeLabel.text = @"Charge Phone";
    descripeLabel.font = [UIFont systemFontOfSize:14];
    descripeLabel.textColor = [UIColor lightGrayColor];
    
    UISwitch *switchButton =[[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMaxX(descripeLabel.frame), CGRectGetMaxY(showBattryNumLabel.frame),(view.width-imageView.width) * 0.4, 10)];
    
    switchButton.on = NO;
    
    switchButton.transform = CGAffineTransformMakeScale(0.75, 0.7);
    
    [view addSubview:imageView];
    [view addSubview:showBattryNumLabel];
    [view addSubview:descripeLabel];
    [view addSubview:switchButton];
}

@end
