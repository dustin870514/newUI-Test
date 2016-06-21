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
#import "NPGatewayUser.h"

@interface NPDisConnectController ()

@property (nonatomic, strong) NSArray *deviceList;

@property (nonatomic, strong) NSMutableArray *cellList;

@property(nonatomic, strong) NPActiveMoudolesView *activeMoudolesView;

@property(nonatomic, strong) NPInternalBattryView *internalBattryView;

@property(nonatomic, strong) NSNotificationCenter *notificationCenter;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong)NSData *resoureData;

@property(nonatomic, strong)NSMutableArray *gatewaysArray;

@property(nonatomic, assign) BOOL isShowGatewayView;

@property(nonatomic, strong) UIView *gatewayView;

@property(nonatomic, strong) NPGatewayUser *user;

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

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
         [self loadgatewayData];
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.85, 44)];
    
    titleView.backgroundColor = [UIColor lightGrayColor];
    
    [self setupTitleView:titleView];
    
    [self.view addSubview:titleView];
    
    [self setupActiveModules];
    
    [self setupInternalBattryView];
    
    [self setupGatewayView];
}
-(void)loadgatewayData{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"gateways.txt" ofType:nil];
    
    self.resoureData = [NSData dataWithContentsOfFile:filePath];
    
    NSMutableArray *tempArray = [NSJSONSerialization JSONObjectWithData:self.resoureData options:NSJSONReadingMutableContainers error:nil];
    
    self.gatewaysArray = [NPGatewayUser mj_objectArrayWithKeyValuesArray:tempArray];
    
    NSLog(@"-----%ld-------",self.gatewaysArray.count);

}
-(void)setupActiveModules{

    _activeMoudolesView = [[NPActiveMoudolesView alloc] initWithFrame:CGRectMake(0, 44, self.view.width*0.85, self.view.height * 0.25)];
    
    [self.view addSubview:_activeMoudolesView];
    
}

-(void)setupInternalBattryView{
    
    _internalBattryView = [[NPInternalBattryView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_activeMoudolesView.frame), self.view.width*0.85, self.view.height * 0.2)];
    
    [self.view addSubview:_internalBattryView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5 , CGRectGetMaxY(_internalBattryView.frame)+ 5 , self.view.width*0.85, self.view.height * 0.1)];
    
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

    self.user = self.gatewaysArray[0];
    
    self.titleLabel.text = self.user.user;
    
    self.titleLabel.frame = CGRectMake(0, 0, titleView.width*0.6, titleView.height);
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *changeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX( self.titleLabel.frame), 0, titleView.width*0.2, titleView.height)];
    
    [changeButton setTitle:@"change" forState:UIControlStateNormal];
    
    changeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [changeButton addTarget:self action:@selector(toShowGatewayViews) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *hideViewButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeButton.frame), 0, titleView.width*0.2, titleView.height)];
    
    [hideViewButton setTitle:@"hide" forState:UIControlStateNormal];
    
    hideViewButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [hideViewButton addTarget:self action:@selector(toHideDisConnectController) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:hideViewButton];
    
    [titleView addSubview:changeButton];
    
    [titleView addSubview: self.titleLabel];

}

-(void)toShowGatewayViews{
    
    if (!self.isShowGatewayView) {
        
        self.gatewayView.hidden = NO;
        self.isShowGatewayView = YES;
        
    }else{
    
        self.gatewayView.hidden = YES;
        self.isShowGatewayView = NO;
    }
}

-(void)setupGatewayView{
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor lightGrayColor];
    
    NPShowGateWayView *gateway = [[NPShowGateWayView alloc]initWithContentView:view];

//    [gateWayView showInRect:CGRectMake((self.titleLabel.width - 100 )/2, CGRectGetMaxY(self.titleLabel.frame) + 20, 100, 150) atView:self.view gatewayArray:self.gatewaysArray];
    
    self.gatewayView = [gateway showInRect:CGRectMake((self.view.width*0.85*0.5 - 100)/2, 22, 100, 150) atView:self.view gatewayArray:self.gatewaysArray];
    
    self.gatewayView.hidden = YES;
    
    self.isShowGatewayView = NO;
    
   [self.view addSubview:self.gatewayView];
}

@end
