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
#import "NPGatewayUser.h"
#import "NPGatewaysModule.h"
#import "NPGatewayTileModule.h"
#import "MJExtension.h"

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

@property(nonatomic, strong)NSMutableArray *gatewaysArray;

@property(nonatomic, strong)NPGatewayUser *user;

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

-(void)showInRect:(CGRect)rect atView:(UIView *)view gatewayArray:(NSMutableArray *)gateArray{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.containerView.frame = rect;
    [self.containerView addSubview:self.contentView];//add the contentView in the container
    
    self.gatewaysArray = gateArray;
    
    //set the margin of contentView from container
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottonMargin = 8;
    
    self.contentView.x = leftMargin;
    self.contentView.y = topMargin;
    self.contentView.width = self.containerView.width - leftMargin - rightMargin;
    self.contentView.height = self.containerView.height - topMargin - bottonMargin;
    
    self.user = gateArray[0];
    
    for (NSInteger index = 0; index < self.user.gateways.count; index++) {
        
        CGFloat margin = 10;
        CGFloat buttonHeigth = self.contentView.height / self.user.gateways.count - 10;
        
        CGFloat buttonY = (buttonHeigth + margin) * index + margin;
        
        UIButton *gatewayeButton = [[UIButton alloc]init];
        
        NPGatewaysModule *getewayModule = self.user.gateways[index];
        
        [gatewayeButton setTitle:getewayModule.uuid forState:UIControlStateNormal];
        
        NSLog(@"---------%@--------",getewayModule.uuid);
        
        gatewayeButton.frame = CGRectMake(5, buttonY, self.contentView.width - margin , buttonHeigth);
        
        gatewayeButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        gatewayeButton.tag = index;
        
        [self.contentView addSubview:gatewayeButton];
        
        [gatewayeButton addTarget:self action:@selector(gatewayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)gatewayButtonClicked:(UIButton *)button{
    
     NPGatewaysModule *getewayModule = self.user.gateways[button.tag];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:getewayModule.uuid forKey:USER_GATEWAY_UUID];
    
    [self.app.notificationCenter postNotificationName:USER_GATEWAY_UUID object:nil userInfo:dict];
    
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
