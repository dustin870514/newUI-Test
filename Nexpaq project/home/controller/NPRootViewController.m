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
#import "UIImage+Not_stretch.h"
#import "NPHttps_Networking_ForTiles.h"
#import "NPTilesModules.h"
#import "NPTileView.h"
#import "NPTile.h"
#import "NPDiscoverController.h"
#import "NPBLE_Manager.h"
#import "NPBLE_Device.h"

#define MODULETILE_NOTIFY_DIDSELECTED @"MODULETILE_NOTIFY_DIDSELECTED"

#define USER_GATEWAY_UUID @"USER_GATEWAY_UUID"

// 颜色
#define NPColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define NPRandomColor NPColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#define kNPGatewayId  @"id"
#define kNPGatewayTemplate @"template"
#define kNPGatewayPosition @"position"

@interface NPRootViewController()<NPDiscoverControllerDelegate>

@property (nonatomic, strong) NPTouchMovedView *touchMovedView;

@property (nonatomic, strong) NPMetroContainerView *metroContainerView;

@property (nonatomic, strong) NSMutableArray *tilesModulesArray;

@property (nonatomic, strong) NSString *gateWayDidselected;

@property (nonatomic, strong) NPDiscoverController *discoverController;

@property (nonatomic, strong) UIButton *coverButton;

@property (nonatomic, strong) NSNotificationCenter *notificationCenter;

@end

@implementation NPRootViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.title = @"Home";
    
    [self.notificationCenter addObserver:self selector:@selector(addTile:) name:MODULETILE_NOTIFY_DIDSELECTED object:nil];
    
    [self setUpNavigationItem];
    
    [self.notificationCenter addObserver:self selector:@selector(refreshDashboardByTpye:) name:USER_GATEWAY_UUID object:nil];

    self.metroContainerView.frame = self.view.bounds;
    
    self.metroContainerView.backgroundColor = [UIColor blackColor];
    
    [self setupMetroSubviews:self.metroContainerView];
    
    self.metroContainerView.contentSize = CGSizeMake(self.view.width, self.view.height*10);
    
    self.metroContainerView.scrollEnabled = YES;
    
    [self.view addSubview:self.metroContainerView];
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

    UIBarButtonItem *settingButton =  [[UIBarButtonItem alloc] initWithTitle:@"setting" style:  UIBarButtonItemStylePlain target:self action:@selector( clickLeftBarButtonItem)];

    UIBarButtonItem *addTilesButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickRightBarButtonItem)];
    
    UIBarButtonItem *scanButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOrginWithName:@"HomeLeft_Icon"] style:UIBarButtonItemStylePlain target:self action:@selector(scanDevice)];
    
    self.navigationItem.leftBarButtonItem = settingButton;
    
    self.navigationItem.rightBarButtonItems = @[addTilesButton,scanButton];
}

-(void)clickLeftBarButtonItem{

    NPTouchMovedView *touchMovedView = [[NPTouchMovedView alloc] init];
    
    self.touchMovedView = touchMovedView;
}

-(void)refreshDashboardByTpye:(NSNotification *)note{
    
    [self.touchMovedView hideDisConnectController];
    
    [self.metroContainerView clearAllSubbViews];
    
    self.gateWayDidselected = note.userInfo[USER_GATEWAY_UUID];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gateways.txt" ofType:nil]];
    
    NSMutableArray *users = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary *user = users.lastObject;
    
    NSArray *gateways = user[@"gateways"];
    
    for (NSDictionary *dict in gateways) {
        
        if ([dict[@"uuid"] isEqualToString:self.gateWayDidselected]) {
            
            NSArray *titles = dict[@"tiles"];
            
            for (NSDictionary *dict in titles) {
                
                NSString *Id = [NSString stringWithFormat:@"%@",dict[kNPGatewayId]];
                
                NSString *tileTemplate = dict[kNPGatewayTemplate];
                
                NSString *position = dict[kNPGatewayPosition];
                
                NPTileView *tileView = [NPTileView tileViewWithTemplate:[tileTemplate integerValue] andPosition:[position integerValue]];
                
                [self.metroContainerView containerViewIncludeSubView:tileView];
                
                [NPHttps_Networking_ForTiles downloadTileResourceWithIdUrl:[NSString stringWithFormat:@"%zd/title.txt",Id] andId:Id andSuccess:^(NPTile *tile) {
                    
                    tileView.tile = tile;
                    
                } andFailure:^(NSError *erro) {
                    
                    if (erro) {
                        
                        NSLog(@"er = %@",erro);
                    }
                    
                }];
            }
        }
    }

}

-(void)clickRightBarButtonItem{
    
    NPAddTilesTableViewController *addTilesTableViewController = [[NPAddTilesTableViewController alloc] init];
    
    addTilesTableViewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highlightImageName:@"navigationbar_back" target:self action:@selector(back)];
    
   [self.navigationController pushViewController:addTilesTableViewController animated:YES];
    
}

- (void)scanDevice{
    
    [[NPBLE_Manager sharedNPBLE_Manager] NPBLE_ScanDeviceWithCompletionHandler:^(NSArray *devices) {
        
        self.discoverController.devices = devices;
    }];
 
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self.coverButton];
    
    [window addSubview:self.discoverController.view];
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
       
       if (error) {
           
           NSLog(@"er = %@",error);
       }
   }];
}

- (void)hideDiscoverControllerView{
    
    [self.coverButton removeFromSuperview];

    [self.discoverController.view removeFromSuperview];
    
    self.discoverController = nil;
    
    [[NPBLE_Manager sharedNPBLE_Manager] clearDiscoverDevices];
}

- (void)discoverController:(NPDiscoverController *)controller didSelectDevice:(NPBLE_Device *)device{
  
    [[NPBLE_Manager sharedNPBLE_Manager] NPBLE_ConnectDevice:device andCompletionHandler:^(NPBLE_Device *device) {
        
        NSLog(@"connect device name = %@",device.name);
    }];
    
    [self hideDiscoverControllerView];
}

#pragma mark - setter && getter

- (NPDiscoverController *)discoverController{

    if (_discoverController == nil) {
        
        _discoverController = [[NPDiscoverController alloc] init];
        
        _discoverController.view.y = 60;
        
        _discoverController.view.width = self.view.width * 0.3;
        
        _discoverController.view.height = self.view.height * 0.5;
        
        _discoverController.view.x = (self.view.width - _discoverController.view.width) * 0.5;
        
        _discoverController.delegate = self;
    }
    
    return _discoverController;
}

- (UIButton *)coverButton{

    if (_coverButton == nil) {
        
        _coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        _coverButton.frame = window.bounds;
        
        _coverButton.backgroundColor = [UIColor blackColor];
        
        _coverButton.alpha = 0.3;
        
        [_coverButton addTarget:self action:@selector(hideDiscoverControllerView) forControlEvents:UIControlEventTouchUpInside];
    }
  
    return _coverButton;
}

#pragma mark - setter && getter

-(NSNotificationCenter *)notificationCenter{

    if (_notificationCenter == nil) {
        
        _notificationCenter = [NSNotificationCenter defaultCenter];
    }
    
    return _notificationCenter;
}

-(NSMutableArray *)tilesModulesArray{
    
    if (_tilesModulesArray == nil) {
        
        self.tilesModulesArray = [NSMutableArray array];
    }
    
    return _tilesModulesArray;
}

-(NPMetroContainerView *)metroContainerView{
    
    if (_metroContainerView == nil) {
        
        _metroContainerView = [NPMetroContainerView containerViewWithLagreMagrin:5 andSmallMagrin:5 andTopMagrin:5];
    }
    
    return _metroContainerView;
}

@end
