//
//  NPActiveMoudolesView.m
//  Nexpaq Beta project
//
//  Created by USER on 16/6/1.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPActiveMoudolesView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Extension.h"
#import "NPShowConnectedModual.h"
#import "AppDelegate.h"
//#import "NPBLE_Module.h"

#define PerRowActiveModuleLabeCount 2
#define PerColumActiveModuleLabeCount 3

#define marginX 5.0
#define marginY 5.0

@interface NPActiveMoudolesView()

@property(strong, nonatomic)UILabel *activeMoudolesLabel;

@property(strong, nonatomic)UIView *showModualView;

@end

@implementation NPActiveMoudolesView

-(UIView *)showModualView{

    if (!_showModualView) {
        
        self.showModualView = [[UIView alloc] init];
    }
    
    return  _showModualView;
}

-(UILabel *)activeMoudolesLabel{

    if (_activeMoudolesLabel == nil) {
        
        self.activeMoudolesLabel = [[UILabel alloc] init];
        
        self.activeMoudolesLabel.text = @"Modules connected";
        
        self.activeMoudolesLabel.textColor = [UIColor blackColor];
        
        self.activeMoudolesLabel.font = [UIFont systemFontOfSize:20];
    }
    
    return _activeMoudolesLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.activeMoudolesLabel.frame = CGRectMake(marginX , marginY ,self.width - marginX * 2, (self.height - 2 * marginY) * 0.2);
        
        UIView *detailView = [self setupDetailViews];
        
        [self addSubview:self.activeMoudolesLabel];
        
        [self addSubview:detailView];
        
    }
    
    return self;
}

-(UIView *)setupDetailViews{

    NPShowConnectedModual *view = [[NPShowConnectedModual alloc] initWithFrame:CGRectMake(marginX, CGRectGetMaxY(self.activeMoudolesLabel.frame) + marginY, self.width - 2 * marginX, (self.height - 2 * marginY) * 0.8)];
    view.layer.cornerRadius = 8;
    view.layer.borderWidth = 1.5;
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.masksToBounds = YES;
    
    return view;
}


@end
