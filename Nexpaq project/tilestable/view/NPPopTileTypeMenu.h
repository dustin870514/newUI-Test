//
//  NPPopTileTypeMenu.h
//  Nexpaq Beta project
//
//  Created by ben on 16/6/6.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ModualsTileType{
    
    ModualsTileTypebyQueue,
    ModualsTileTypebySingle,
    ModualsTileTypebyDouble,
    ModualsTileTypebyTriple,
    
}ModualsTileType;

@class NPPopTileTypeMenu;

@protocol NPPopTileTypeMenuDelegate <NSObject>

@optional

-(void)popTileTypeMenuDismiss:(NPPopTileTypeMenu *)popmenu buttonDidClickedByTag:(ModualsTileType )type;

@end

@interface NPPopTileTypeMenu : UIView

-(instancetype)initWithContentView:(UIView *)view;

/*
 * 显示菜单
 */
-(void)showInRect:(CGRect)rect;

/*
 * 关闭菜单
 */
-(void)dismiss;

/*
 * 设置菜单的背景图片
 */
-(void)setBackground:(UIImage *)background;


@property(nonatomic, weak) id<NPPopTileTypeMenuDelegate> delegate;

@end
