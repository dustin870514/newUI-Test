//
//  ViewController.m
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 dustin. All rights reserved.
//

#import "NPRootViewController.h"
#import "NPTouchMovedView.h"
#import "NPMetroContainerView.h"
#import "NPMetroSubView.h"
#import "NPAddTilesTableViewController.h"
#import "UIBarButtonItem+extention.h"
#import "NPHttps_Networking_ForTiles.h"
#import "NPTilesModules.h"
#import "NPTileView.h"

#define MODULETILE_NOTIFY_DIDSELECTED @"MODULETILE_NOTIFY_DIDSELECTED"

#define USER_GATEWAY_UUID @"USER_GATEWAY_UUID"

@interface NPRootViewController()

@property (nonatomic, strong) NPTouchMovedView *touchMovedView;

@property (nonatomic, strong) NPMetroContainerView *metroContainerView;

@property (nonatomic, strong) NSMutableArray *tilesModulesArray;

@property (nonatomic, strong) NSNotificationCenter *notifyCenter;

@property (nonatomic, strong) NSString *gateWayDidselected;

@property (nonatomic, strong) AppDelegate *app;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation NPRootViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.notifyCenter addObserver:self selector:@selector(addTile:) name:MODULETILE_NOTIFY_DIDSELECTED object:nil];
    
    [self setUpNavigationItem];
    
    [self.notifyCenter addObserver:self selector:@selector(refreshDashboardByTpye:) name:USER_GATEWAY_UUID object:nil];

    self.metroContainerView.frame = self.view.bounds;
    
    self.metroContainerView.backgroundColor = [UIColor blackColor];
    
    [self setupMetroSubviews:self.metroContainerView];
    
    self.metroContainerView.contentSize = CGSizeMake(self.view.width, self.view.height*10);
    
    self.metroContainerView.scrollEnabled = YES;
    
    [self.view addSubview:self.metroContainerView];
    
}

- (void)setUpNotifyCation{
    
    [self.notifyCenter addObserver:self selector:@selector(getDeviceUUID:) name:NPBLE_NOTIFY_DEVICEGETUUID object:nil];
    
    [self.notifyCenter addObserver:self selector:@selector(getModualUUID:) name:NPBLE_NOTIFY_MODULEGETUUID object:nil];
    
    [self.notifyCenter addObserver:self selector:@selector(getModualResult:) name:NPBLE_NOTIFY_REFRSHUI object:nil];
    
    [self.notifyCenter addObserver:self selector:@selector(modualPushOut:) name:NPBLE_NOTIFY_MODULEPULLOUT object:nil];
}

-(void)setupMetroSubviews:(NPMetroContainerView *)metroContainerView{
    
//    NPMetroSubView *metroSubview0 = [NPMetroSubView metroSubViewWithType:1 andPosition:0];//0 1 6 7
//    metroSubview0.backgroundColor = NPRandomColor;
//    
//    NPMetroSubView *metroSubview1 = [NPMetroSubView metroSubViewWithType:1 andPosition:2];//2 3 8 9
//    metroSubview1.backgroundColor = NPRandomColor;
//    
//    NPMetroSubView *metroSubview2 = [NPMetroSubView metroSubViewWithType:0 andPosition:4];//4
//    metroSubview2.backgroundColor = NPRandomColor;
//    
//    NPMetroSubView *metroSubview3 = [NPMetroSubView metroSubViewWithType:0 andPosition:5];//5
//    metroSubview3.backgroundColor = NPRandomColor;
    
    
//    
//    NPMetroSubView *metroSubview4 = [NPMetroSubView metroSubViewWithType:0 andPosition:10];//10
//    metroSubview4.backgroundColor = NPRandomColor;
//    
//    NPMetroSubView *metroSubview5 = [NPMetroSubView metroSubViewWithType:2 andPosition:12];//12 13 14 15  18 19 20 21
//    metroSubview5.backgroundColor = NPRandomColor;
//    
//    NPMetroSubView *metroSubview6 = [NPMetroSubView metroSubViewWithType:3 andPosition:24];//24 25 26 27 28 29 30 31 32 33 34 35
//    metroSubview6.backgroundColor = NPRandomColor;
//    
//    NPMetroSubView *metroSubview7 = [NPMetroSubView metroSubViewWithType:1 andPosition:36];//36 37 42 43
//    metroSubview7.backgroundColor = NPRandomColor;
//    
//    NPMetroSubView *metroSubview8 = [NPMetroSubView metroSubViewWithType:1 andPosition:38];//38 39 44 45
//    metroSubview8.backgroundColor = NPRandomColor;
//    
//    NPMetroSubView *metroSubview9 = [NPMetroSubView metroSubViewWithType:1 andPosition:40];// 40 41 46 47
//    metroSubview9.backgroundColor = NPRandomColor;
//    
//    NSArray *subviewsArray = @[metroSubview0,metroSubview1,metroSubview2,metroSubview3,metroSubview4,metroSubview5,metroSubview6,metroSubview7,metroSubview8,metroSubview9];
//    
//    [metroContainerView containerViewIncludeSubViews:subviewsArray];
    
}

-(void)setUpNavigationItem{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(clickLeftBarButtonItem)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clickRightBarButtonItem)];
}

-(void)clickLeftBarButtonItem{

    NPTouchMovedView *touchMovedView = [[NPTouchMovedView alloc] init];
    
    self.touchMovedView = touchMovedView;
}

-(void)refreshDashboardByTpye:(NSNotification *)note{
    
    [self.touchMovedView hideDisConnectController];
    
    self.gateWayDidselected = note.userInfo[USER_GATEWAY_UUID];
    
    NSLog(@"------------gateWayDidselected.UUID----------%@----------",self.gateWayDidselected);
    
}

-(void)clickRightBarButtonItem{
    
    NPAddTilesTableViewController *addTilesTableViewController = [[NPAddTilesTableViewController alloc] init];
    
    addTilesTableViewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highlightImageName:@"navigationbar_back" target:self action:@selector(back)];
    
   [self.navigationController pushViewController:addTilesTableViewController animated:YES];
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTile:(NSNotification *)note{

    NSInteger ID = [note.userInfo[@"MODULE_ID"] integerValue];
    
    NSInteger tileTemplate = [note.userInfo[@"MODULE_TEMPLATE"] integerValue];
    
    NPTileView *tileView = [NPTileView  tileViewWithTemplate:tileTemplate];
    
    [self.metroContainerView containerViewIncludeSubView:tileView];
    
   [NPHttps_Networking_ForTiles downloadTileResourceWithIdUrl:[NSString stringWithFormat:@"%zd/tile.txt",ID] andId:[NSString stringWithFormat:@"%zd",ID] andSuccess:^(NPTile *tile) {
       
       tileView .tile = tile;
       
   } andFailure:^(NSError *error) {
       
       
       
   }];

}

-(void)getDeviceUUID:(NSNotification *)userInfo{
    
    NPBLE_Device *device = userInfo.userInfo[NPBLE_NOTIFY_DEVICE];
    
    device.isMatch = YES;// set this YES by manual before the service is ok;
    
    [[NPBLE_Manager sharedNPBLE_Manager] NPBLE_RequestInformationOfCurrentDevice:device];//result will be backed by listioning the noti
    
    NSLog(@"--------device.UUID-------%@",device.Case_uuid);
}

-(void)getModualUUID:(NSNotification *)userInfo{
    
    NPBLE_Device *device = userInfo.userInfo[NPBLE_NOTIFY_DEVICE];
    
    NPBLE_Module *module = userInfo.userInfo[NPBLE_NOTIFY_MODULE];
    
    module.isMatch = YES; //set this for YES by manual befor the service is ok;
    
    [[NPBLE_Manager sharedNPBLE_Manager] NPBLE_RequestInformationOfCurrentModule:module andInCurrentDevice:device];//result will be backed by listioning the noti;
    NSLog(@"--------module UUID-------%@",module.module_uuid);
    
}

-(void)getModualResult:(NSNotification *)note{//has new module connected
    
    NPBLE_Module *module = note.userInfo[NPBLE_NOTIFY_MODULE];
    
    NPBLE_Module_Info *info = module.info;
    
    if (self.app.connectedViewIsShow == NO) {
        
        [self clickLeftBarButtonItem];//进入dashboardController要先显示disconnectedcontroller，5秒后隐藏
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(hideDisConnectController) userInfo:nil repeats:NO];
    }
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:module forKey:@"NPBLE_NEW_MODULE_CONNECTED"];
    
    [self.notifyCenter postNotificationName:@"NPBLE_NEW_MODULE_CONNECTED" object:nil userInfo:userInfo];//post noti to refresh the activeModualView
    
}

-(void)modualPushOut:(NSNotification *)note{
    
    NPBLE_Module *module = note.userInfo[NPBLE_NOTIFY_MODULE];
    
    NSString *node_id = module.node_id;//which modual has push out;
    
    if (self.app.connectedViewIsShow == NO) {
        
        [self clickLeftBarButtonItem];//进入dashboardController要先显示disconnectedcontroller，5秒后隐藏
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(hideDisConnectController) userInfo:nil repeats:NO];
    }
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:module forKey:@"NPBLE_MODULE_PUSHOUT"];
    
    [self.notifyCenter postNotificationName:@"NPBLE_MODULE_PUSHOUT" object:nil userInfo:userInfo];
    
    NSLog(@"第 %@ 个模块已经拔出",node_id);
}

-(void)hideDisConnectController{
    
    [self.touchMovedView hideDisConnectController];
    
    [self.timer invalidate];
}

#pragma mark - setter && getter

-(NSMutableArray *)tilesModulesArray{
    
    if (_tilesModulesArray == nil) {
        
        self.tilesModulesArray = [NSMutableArray array];
    }
    
    return _tilesModulesArray;
}

-(NPMetroContainerView *)metroContainerView{
    
    if (_metroContainerView == nil) {
        
        self.metroContainerView = [NPMetroContainerView containerViewWithLagreMagrin:5 andSmallMagrin:5 andTopMagrin:5];
    }
    
    return _metroContainerView;
}

- (NSNotificationCenter *)notifyCenter{

    if (_notifyCenter == nil) {
        
        _notifyCenter = [NSNotificationCenter defaultCenter];
    }
  
    return _notifyCenter;
}

-(AppDelegate *)app{

    if (_app == nil) {
        
        self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    
    return _app;
}

@end
