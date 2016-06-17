//
//  NPShowGateWayView.h
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 ben. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum UserGateWayTypes{
    
    UserGateWayTypebyQueue,
    UserGateWayTypebySingle,
    UserGateWayTypebyDouble,
    
}UserGateWayTypes;

#define USER_GATEWAY_TYPE @"USER_GATEWAY_TYPE"
#define USERGATEWAYTYPEBYQUEUE @"USERGATEWAYTYPEBYQUEUE"
#define USERGATEWAYTYPEBYSINGLE @"USERGATEWAYTYPEBYSINGLE"
#define USERGATEWAYTYPEBYDOUBLE @"USERGATEWAYTYPEBYDOUBLE"

@class NPShowGateWayView;

@protocol NPShowGateWayViewDelegate <NSObject>

@optional

-(void)gateWayViewDismiss:(NPShowGateWayView *)popView buttonDidClickedByTag:(UserGateWayTypes)type;

@end


@interface NPShowGateWayView : UIView

-(instancetype)initWithContentView:(UIView *)view;

/*
 * 显示菜单
 */
-(void)showInRect:(CGRect)rect atView:(UIView *)view;

/*
 * 关闭菜单
 */
-(void)dismiss;

/*
 * 设置菜单的背景图片
 */
-(void)setBackground:(UIImage *)background;


@property(nonatomic, weak) id<NPShowGateWayViewDelegate> delegate;

@end
