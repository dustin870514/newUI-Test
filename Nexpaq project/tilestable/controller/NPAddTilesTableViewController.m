//
//  NPAddTilesTableViewController.m
//  Nexpaq Beta project
//
//  Created by USER on 16/6/2.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPAddTilesTableViewController.h"
#import "NPTilesTableViewCell.h"
#import "UIView+Extension.h"
#import "NPPopTileTypeMenu.h"
#import "NPHttps_Networking_ForTiles.h"
#import "NPTilesModulesResults.h"
#import "AFNetworking.h"
#import "NPTilesModules.h"
#import "MJExtension.h"

@interface NPAddTilesTableViewController ()<NPPopTileTypeMenuDelegate>

@property(nonatomic, strong) NSMutableArray *modulesArray;

@property(nonatomic, strong) NSMutableArray *tilesModulesArray;

@property(nonatomic, strong) NSNotificationCenter *notificationCenter;

@end

@implementation NPAddTilesTableViewController

-(NSNotificationCenter *)notificationCenter{
    
    if (_notificationCenter == nil) {
        
        self.notificationCenter = [NSNotificationCenter defaultCenter];
    }
    
    return _notificationCenter;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self downloadTileModules];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    self.navigationItem.titleView = [self navigationItemView];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
//    
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 5)];
    
}

-(void)downloadTileModules{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *url = @"http://vpn2.coody.top/nexpaq-app-beta-resources/tiles/tiles.txt";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    }completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        NSLog(@"filePath = %@",filePath.path);
        
        NSData *data = [NSData dataWithContentsOfFile:filePath.path];
        
        self.modulesArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.tilesModulesArray = [NPTilesModules mj_objectArrayWithKeyValuesArray:self.modulesArray];
        
        NSLog(@"---------self.tilesModulesArray.count------%ld",self.tilesModulesArray.count);
        
        [self.tableView reloadData];
    }];
    
    [downloadTask resume];

}

-(UIView *)navigationItemView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    title.text = @"All Tiles";
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.textColor = [UIColor orangeColor];
    
    [titleView addSubview:title];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSelectTileView:)];
    
    [titleView addGestureRecognizer:tapGesture];

    return titleView;
}

-(void)showSelectTileView:(UITapGestureRecognizer *)recongnizer{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    
    NPPopTileTypeMenu *menu = [[NPPopTileTypeMenu alloc]initWithContentView:view];
    menu.delegate = self;
    
    [menu showInRect:CGRectMake((self.view.width - 100)/2, 64 , 100, 150)];
}

#pragma the delegate of NPPopTileTypeMenu;--tableView will reload data according to ModualsTileType;

-(void)popTileTypeMenuDismiss:(NPPopTileTypeMenu *)popmenu buttonDidClickedByTag:(ModualsTileType)type{
    
    [popmenu dismiss];

    switch (type) {
            
        case ModualsTileTypebyQueue:
            
            [self showAlertView:@"ModualsTileTypebyQueue is selected!!!"];
            
            break;
            
        case ModualsTileTypebySingle:
            
            [self showAlertView:@"ModualsTileTypebySingle is selected!!!"];
            
            break;
            
        case ModualsTileTypebyDouble:
            
            [self showAlertView:@"ModualsTileTypebyDouble is selected!!!"];
            
            break;
            
        default:
            
            break;
    }
}

-(void)showAlertView:(NSString *)message{

    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NPTilesTableViewCell *cell = [NPTilesTableViewCell cellWithTableView:tableView];
    
    //通过传数据模型到NPTilesTableViewCell中设置imageView，titleLabel, descriptionLabel
    cell.modules = self.tilesModulesArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NPTilesModules *moduleTile = self.tilesModulesArray[indexPath.row];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    [userInfo setObject:@(moduleTile.id) forKey:@"MODULE_ID"];
    
    [userInfo setObject:@(moduleTile.template) forKey:@"MODULE_TEMPLATE"];
    
    [self.notificationCenter postNotificationName:MODULETILE_NOTIFY_DIDSELECTED object:nil userInfo:userInfo];
    
//    [self.navigationController popViewControllerAnimated:YES];
}


@end
