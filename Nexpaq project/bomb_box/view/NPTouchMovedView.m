    //
//  NPTouchMovedView.m
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/28.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPTouchMovedView.h"
#import "NPDisConnectController.h"
#import "UIView+setFrame.h"
#import "AppDelegate.h"

@interface NPTouchMovedView ()

@property (nonatomic, strong) UIButton *coverButton;

@property (nonatomic, strong) NPDisConnectController *disconnectController;

@property(nonatomic , strong)NSNotificationCenter *hideDisConnectControllerNotificationCenter;


@property(nonatomic, strong)AppDelegate *app;

@end

@implementation NPTouchMovedView

-(AppDelegate *)app{
    
    if (_app == nil) {
        
        self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    
    return _app;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [[UIApplication sharedApplication].keyWindow addSubview:self.coverButton];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.disconnectController.view];
    
#warning 动画效果------
    [UIView animateWithDuration:1.0 animations:^{
        
        self.disconnectController.view.transform = CGAffineTransformMakeTranslation([UIApplication sharedApplication].keyWindow.width * 0.85, 0);
        
    }];

}

- (void)clickCoverButton{
    
    self.app.connectedViewIsShow = NO;
    
#warning 删除动画效果------
    [UIView animateWithDuration:1.0 animations:^{
        
        self.disconnectController.view.transform = CGAffineTransformMakeTranslation(-[UIApplication sharedApplication].keyWindow.width * 0.85,0);
        
        [self.coverButton removeFromSuperview];
        
    }completion:^(BOOL finished) {
        
        [self.disconnectController.view removeFromSuperview];
        
    }];
    
}

#pragma mark - Getter && Setter

- (UIButton *)coverButton{

    if (_coverButton == nil) {
        
        _coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _coverButton.backgroundColor = [UIColor blackColor];
        
        _coverButton.alpha = 0.3;
        
        _coverButton.frame = [UIApplication sharedApplication].keyWindow.bounds;
        
        [_coverButton addTarget:self action:@selector(clickCoverButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _coverButton;
}

- (NPDisConnectController *)disconnectController{

    if (_disconnectController == nil) {
        
        _disconnectController = [[NPDisConnectController alloc] init];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        _disconnectController.view.x = - window.width * 0.85;
        
        _disconnectController.view.y = window.y + 20;
        
        _disconnectController.view.width = window.width * 0.85;
        
        _disconnectController.view.height = window.height - 20;
        
        _disconnectController.view.backgroundColor = [UIColor whiteColor];
    }

    return _disconnectController;
}

#warning ----不要显示这个View在控制器上，调用类方法去做事情

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    self.hideDisConnectControllerNotificationCenter = [NSNotificationCenter defaultCenter];
    
    [_hideDisConnectControllerNotificationCenter addObserver:self selector:@selector(clickCoverButton) name:@"hideDisConnectControllerNotification" object:nil];
    
    if (self) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverButton];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.disconnectController.view];
        
#warning 动画效果------
        [UIView animateWithDuration:1.0 animations:^{
            
            self.disconnectController.view.transform = CGAffineTransformMakeTranslation([UIApplication sharedApplication].keyWindow.width * 0.85 , 0);
            
        }];
    }

    return self;
}

#warning -------开启进入NPDashBoardController先显示显示框3秒隐藏；
-(void)hideDisConnectController{

    [self clickCoverButton];
}


@end
