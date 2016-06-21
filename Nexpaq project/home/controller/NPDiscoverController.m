//
//  NPDiscoverController.m
//  Nexpaq project
//
//  Created by Jordan Zhou on 16/6/21.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPDiscoverController.h"
#import "UIImage+Not_stretch.h"
#import "NPBLE_Device.h"
#import "NPBLE_Manager.h"

static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation NPDiscoverController

- (void)viewDidLoad{
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNotStretchWithName:@"popover_background"]];
}

- (void)setDevices:(NSArray *)devices{
    
    _devices = devices;

    [self.tableView reloadData];
}


#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NPBLE_Device *device = self.devices[indexPath.row];
    
    NSLog(@"device name = %@",device.name);
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = device.name;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NPBLE_Device *device = self.devices[indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(discoverController:didSelectDevice:)]) {
        
        [self.delegate discoverController:self didSelectDevice:device];
    }
}



@end
