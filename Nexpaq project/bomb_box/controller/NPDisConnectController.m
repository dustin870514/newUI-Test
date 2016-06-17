//
//  NPDisConnectController.m
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/28.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPDisConnectController.h"
#import "NPBLE_DeviceManager.h"
#import "NPActiveMoudolesView.h"
#import "NPInternalBattryView.h"
#import "NPBLE_Device.h"
#import "NPShowGateWayView.h"
#import "UIView+Extension.h"


@interface NPDisConnectController ()

@property (nonatomic, strong) NSArray *deviceList;

@property (nonatomic, strong) NSMutableArray *cellList;

@property(nonatomic, strong) NPActiveMoudolesView *activeMoudolesView;

@property(nonatomic, strong) NPInternalBattryView *internalBattryView;

@property(nonatomic, strong) NSNotificationCenter *notificationCenter;

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation NPDisConnectController

-(UILabel *)titleLabel{

    if (_titleLabel == nil) {
        
        self.titleLabel = [[UILabel alloc] init];
    }
    
    return _titleLabel;
}

-(NSNotificationCenter *)notificationCenter{

    if (_notificationCenter == nil) {
        
        self.notificationCenter = [NSNotificationCenter defaultCenter];
    }
    
    return _notificationCenter;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.85, 40)];
    
    titleView.backgroundColor = [UIColor lightGrayColor];
    
    [self setupTitleView:titleView];
    
    [self.view addSubview:titleView];
    
    [self setupActiveModules];
    
    [self setupInternalBattryView];
}

-(void)setupActiveModules{

    _activeMoudolesView = [[NPActiveMoudolesView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width*0.85, self.view.frame.size.height * 0.25)];
    
    [self.view addSubview:_activeMoudolesView];
    
}

-(void)setupInternalBattryView{
    
    _internalBattryView = [[NPInternalBattryView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_activeMoudolesView.frame), self.view.frame.size.width*0.85, self.view.frame.size.height * 0.2)];
    
    [self.view addSubview:_internalBattryView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5 , CGRectGetMaxY(_internalBattryView.frame)+ 5 , self.view.frame.size.width*0.85, self.view.frame.size.height * 0.1)];
    
    label.numberOfLines = 0;
    label.textColor = [UIColor lightGrayColor];
    
    label.text = @"Nexpaq will automatically chagen your phone when connected tp power supply.";
    
    label.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:label];
}

-(void)toHideDisConnectController{

    NSNotificationCenter *hideDisConnectControllerNotificationCenter = [NSNotificationCenter defaultCenter];
    
    [hideDisConnectControllerNotificationCenter postNotificationName:@"hideDisConnectControllerNotification" object:nil userInfo:nil];
}

-(void)setupTitleView:(UIView *)titleView{

//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width*0.8, titleView.frame.size.height)];
    
//    NPBLE_Device *device = self.deviceList.lastObject;
//    
//    titleLabel.text = device.peripheral.name;
    
    self.titleLabel.frame = CGRectMake(0, 0, titleView.frame.size.width*0.5, titleView.frame.size.height);
    
     self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
     self.titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *changeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX( self.titleLabel.frame), 0, titleView.frame.size.width*0.3, titleView.frame.size.height)];
    
    [changeButton setTitle:@"change" forState:UIControlStateNormal];
    
    [changeButton addTarget:self action:@selector(toShowGatewayViews) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *hideViewButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeButton.frame), 0, titleView.frame.size.width*0.2, titleView.frame.size.height)];
    
    [hideViewButton setTitle:@"hide" forState:UIControlStateNormal];
    
    [hideViewButton addTarget:self action:@selector(toHideDisConnectController) forControlEvents:UIControlEventTouchUpInside];
    
    [hideViewButton setImage:[UIImage imageNamed:@"hidemodualview"] forState:UIControlStateNormal];
    
    [titleView addSubview:hideViewButton];
    
    [titleView addSubview:changeButton];
    
    [titleView addSubview: self.titleLabel];

}

-(void)toShowGatewayViews{

    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor lightGrayColor];
    
    NPShowGateWayView *gateWayView = [[NPShowGateWayView alloc]initWithContentView:view];
    
    [gateWayView showInRect:CGRectMake((self.titleLabel.width - 100 )/2, CGRectGetMaxY(self.titleLabel.frame) + 20, 100, 150) atView:self.view];
}


@end
