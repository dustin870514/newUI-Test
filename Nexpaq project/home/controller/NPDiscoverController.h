//
//  NPDiscoverController.h
//  Nexpaq project
//
//  Created by Jordan Zhou on 16/6/21.
//  Copyright © 2016年 ben. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NPDiscoverController;
@class NPBLE_Device;


@protocol NPDiscoverControllerDelegate <NSObject>


@optional

- (void)discoverController:(NPDiscoverController *)controller didSelectDevice:(NPBLE_Device *)device;

@end

@interface NPDiscoverController : UITableViewController

@property (nonatomic, strong) NSArray *devices;

@property (nonatomic, weak) id<NPDiscoverControllerDelegate> delegate;

@end
