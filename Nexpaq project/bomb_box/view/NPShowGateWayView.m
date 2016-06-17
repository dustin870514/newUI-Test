//
//  NPShowGateWayView.m
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPShowGateWayView.h"
#import "UIView+Extension.h"
#import "AppDelegate.h"

@interface NPShowGateWayView()
/*
 * all the contents will be showed in this contentView;
 */
@property(nonatomic , strong) UIView *contentView;
/*
 * container will show  all the contents in contentView
 */
@property(nonatomic , strong)UIImageView *containerView;

@property(nonatomic, strong)NSNotificationCenter *notificationCenter;

@property(nonatomic, strong)AppDelegate *app;

@end

@implementation NPShowGateWayView

-(AppDelegate *)app{
    
    if (_app == nil) {
        
        self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    
    return _app;
}

-(instancetype)initWithContentView:(UIView *)view{

    if (self = [super init]) {
        
        self.contentView = view;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];

    if (self) {
        
        UIImageView *containerView = [[UIImageView alloc] init];
        
        containerView.userInteractionEnabled = YES;
        
        containerView.image = [self resizedImage:@"popover_background"];
       
        [self addSubview:containerView];
        
        self.containerView = containerView;
        
    }
    
    return self;
}

-(void)showInRect:(CGRect)rect atView:(UIView *)view{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
//    [view addSubview:self];

    self.containerView.frame = rect;
    [self.containerView addSubview:self.contentView];//add the contentView in the container
    
    //set the margin of contentView from container
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottonMargin = 8 ;
    
    self.contentView.x = leftMargin;
    self.contentView.y = topMargin;
    self.contentView.width = self.containerView.width - leftMargin - rightMargin;
    self.contentView.height = self.containerView.height - topMargin - bottonMargin;
    
    UIButton *queueButton = [[UIButton alloc]init];
    [queueButton setTitle:@"gateway1" forState:UIControlStateNormal];
    queueButton.frame = CGRectMake(5, 10, self.contentView.width - 10 , 30);
    queueButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [queueButton addTarget:self action:@selector(queueButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *singleButton = [[UIButton alloc]init];
    [singleButton setTitle:@"gateway2" forState:UIControlStateNormal];
    singleButton.frame = CGRectMake(5, CGRectGetMaxY(queueButton.frame) + 10, self.contentView.width - 10, 30);
    singleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [singleButton addTarget:self action:@selector(singleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *doubleButton = [[UIButton alloc]init];
    [doubleButton setTitle:@"gateway3" forState:UIControlStateNormal];
    doubleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    doubleButton.frame = CGRectMake(5, CGRectGetMaxY(singleButton.frame) + 10, self.contentView.width - 10, 30);
    [doubleButton addTarget:self action:@selector(doubleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:queueButton];
    [self.contentView addSubview:singleButton];
    [self.contentView addSubview:doubleButton];
    
    queueButton.userInteractionEnabled = YES;
}

-(void)queueButtonClicked:(UIButton *)button{
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:USERGATEWAYTYPEBYQUEUE forKey:USER_GATEWAY_TYPE];
    
    [self.app.notificationCenter postNotificationName:USER_GATEWAY_TYPE object:nil userInfo:dict];
    
    [self dismiss];
    
}
-(void)singleButtonClicked:(UIButton *)button{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:USERGATEWAYTYPEBYSINGLE forKey:USER_GATEWAY_TYPE];
    
    [self.app.notificationCenter postNotificationName:USER_GATEWAY_TYPE object:nil userInfo:dict];
    
    [self dismiss];
}

-(void)doubleButtonClicked:(UIButton *)button{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:USERGATEWAYTYPEBYDOUBLE forKey:USER_GATEWAY_TYPE];
    
    [self.app.notificationCenter postNotificationName:USER_GATEWAY_TYPE object:nil userInfo:dict];
    
    [self dismiss];
}

-(void)dismiss{

    [self removeFromSuperview];
}


-(UIImage *)resizedImage:(NSString *)imageName{
    
    UIImage *imgae = [UIImage imageNamed:imageName];
    
    return [imgae stretchableImageWithLeftCapWidth:imgae.size.width*0.5 topCapHeight:imgae.size.height*0.5];
}


@end
