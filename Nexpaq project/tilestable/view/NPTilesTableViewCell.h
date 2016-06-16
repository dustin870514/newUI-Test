//
//  NPTilesTableViewCell.h
//  Nexpaq Beta project
//
//  Created by USER on 16/6/2.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPTilesModules.h"

@interface NPTilesTableViewCell : UITableViewCell

@property(nonatomic, strong)NPTilesModules *modules;

+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
