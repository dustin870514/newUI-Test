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

@interface NPAddTilesTableViewController ()<NPPopTileTypeMenuDelegate>

@end

@implementation NPAddTilesTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    self.navigationItem.titleView = [self navigationItemView];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
//    
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 5)];
    
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

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"which tile is selected" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    
    [alertView show];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NPTilesTableViewCell *cell = [NPTilesTableViewCell cellWithTableView:tableView];
    
    //通过传数据模型到NPTilesTableViewCell中设置imageView，titleLabel, descriptionLabel
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
