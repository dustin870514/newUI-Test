//
//  NPDiscoverController.m
//  Nexpaq project
//
//  Created by Jordan Zhou on 16/6/21.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPDiscoverController.h"
#import "UIImage+Not_stretch.h"

@implementation NPDiscoverController

- (void)viewDidLoad{

    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNotStretchWithName:@"popover_background"]];
    
}




@end
