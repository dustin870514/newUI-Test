////
////  NPDisConnectedModualsView.m
////  Nexpaq Beta project
////
////  Created by ben on 16/6/7.
////  Copyright © 2016年 kevin.liu. All rights reserved.
////
//
//#import "NPDisConnectedModualsView.h"
//#import "NPActiveMoudolesView.h"
//#import "NPInternalBattryView.h"
//#import "UIView+Extension.h"
//#import "NPBLE_Device.h"
//#import "NPBLE_DeviceManager.h"
//
//@interface NPDisConnectedModualsView()
//
//@property(nonatomic, strong)NPActiveMoudolesView *activeMoudolesView;
//@property(nonatomic, strong)NPInternalBattryView *internalBattryView;
//
//@property(nonatomic, strong)UIButton *coverButton;
//
//@property (nonatomic, strong) NSArray *deviceList;
//
//@property(nonatomic, strong) UIView *titleView;
//
//@property(nonatomic, strong) UILabel *descriptionLabel;
///*
// * this view contains all the views about moduals views;
// */
//@property(nonatomic, strong) UIView *containerView;
//
//@end
//
//@implementation NPDisConnectedModualsView
//
//-(instancetype)initWithFrame:(CGRect)frame{
//
//    self = [super initWithFrame:frame];
//    
//    if (self) {
//
//        UIWindow *windon = [UIApplication sharedApplication].keyWindow;
//        
//        self.x = - (windon.frame.size.width);
//        
//        self.y = 0;
//        
//        self.width= windon.frame.size.width;
//        
//        self.height = windon.frame.size.height;
//        
//        [windon addSubview:self];
//        
//        self.coverButton.frame = self.frame;
//        
//        [self addSubview:_coverButton];
//        
//        self.containerView.frame = CGRectMake(0, 20, self.width*0.9, self.height-20);
//        
//        [self addSubview:_containerView];
//        
//        self.titleView.frame = CGRectMake(0, 0, self.containerView.width, self.containerView.height * 0.05);
//        
//        [self.containerView addSubview:_titleView];
//        
//        [self setupTitleView:self.titleView];
//        
//        self.activeMoudolesView = [[NPActiveMoudolesView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), self.containerView.width, self.containerView.height*0.3)];
//        
//        [self.containerView addSubview:_activeMoudolesView];
//        
//        self.internalBattryView = [[NPInternalBattryView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.activeMoudolesView.frame), self.containerView.width, self.containerView.height*0.2)];
//        
//        [self.containerView addSubview:_internalBattryView];
//        
//        self.descriptionLabel.frame = CGRectMake(5, CGRectGetMaxY(self.internalBattryView.frame) + 5 , self.containerView.width, self.containerView.height*0.1);
//        
//        self.descriptionLabel.numberOfLines = 0;
//        
//        self.descriptionLabel.textColor = [UIColor lightGrayColor];
//        
//        self.descriptionLabel.text = @"Nexpaq will automatically chagen your phone when connected tp power supply.";
//        
//        self.descriptionLabel.font = [UIFont systemFontOfSize:14];
//        
//        [self.containerView addSubview:_descriptionLabel];
//
//    }
//    
//    return self;
//}
//
//-(void)showDisConnectedModualsView{
//
//    [UIView animateWithDuration:1.0 animations:^{
//        
//        self.transform = CGAffineTransformMakeTranslation([UIApplication sharedApplication].keyWindow.width, 0);
//    }];
//    
//}
//
//-(void)setupTitleView:(UIView *)titleView{
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width*0.8, titleView.frame.size.height)];
//    
////    NPBLE_Device *device = self.deviceList.lastObject;
//    
////    titleLabel.text = device.peripheral.name;
//    
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    titleLabel.textColor = [UIColor whiteColor];
//    
//    UIButton *hideViewButton = [[UIButton alloc] init];
//    
//    hideViewButton.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, titleView.frame.size.width*0.2, titleView.frame.size.height);
//    
//    [hideViewButton addTarget:self action:@selector(hideDisConnectController) forControlEvents:UIControlEventTouchUpInside];
//    
//    [hideViewButton setImage:[UIImage imageNamed:@"hidemodualview"] forState:UIControlStateNormal];
//    
//    [titleView addSubview:titleLabel];
//    
//    [titleView addSubview:hideViewButton];
//}
//
//-(void)hideDisConnectController{
//    
//    [UIView animateWithDuration:1.0 animations:^{
//        
//        self.transform = CGAffineTransformMakeTranslation(-[UIApplication sharedApplication].keyWindow.width, 0);
//    }];
//}
//
//-(NSArray *)deviceList{
//    
//    if (_deviceList == nil) {
//        
////        self.deviceList = [NPBLE_DeviceManager sharedNPBLE_DeviceManager].device_List;
//    }
//    
//    return _deviceList;
//}
//
//-(UIView *)titleView{
//    
//    if (_titleView == nil) {
//        
//        self.titleView = [[UIView alloc] init];
//        
//        self.titleView.backgroundColor = [UIColor lightGrayColor];
//    }
//    
//    return _titleView;
//}
//
//-(UILabel *)descriptionLabel{
//    
//    if (_descriptionLabel == nil) {
//        
//        self.descriptionLabel = [[UILabel alloc] init];
//    }
//    
//    return _descriptionLabel;
//}
//
//-(UIButton *)coverButton{
//
//    if (_coverButton == nil) {
//        
//        self.coverButton = [[UIButton alloc] init];
//        self.coverButton.backgroundColor = [UIColor blackColor];
//        self.coverButton.alpha = 0.3;
//    }
//    
//    return _coverButton;
//}
//
//-(UIView *)containerView{
//
//    if (_containerView == nil) {
//        
//        self.containerView = [[UIView alloc] init];
//        self.containerView.backgroundColor = [UIColor whiteColor];
//    }
//    
//    return _containerView;
//}
//
//@end
