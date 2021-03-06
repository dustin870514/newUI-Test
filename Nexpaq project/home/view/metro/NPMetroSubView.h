//
//  NPMetroSubView.h
//  NPMetroUIDemo
//
//  Created by Jordan Zhou on 16/6/7.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    
    moveTypeLeft,
    moveTypeRight,
    moveTypeUp,
    moveTypeDown
    
}moveType;


@interface NPMetroSubView : UIView

@property (nonatomic, copy) void (^touchBeganBlock)();

//监听view的移动事件
@property (nonatomic, copy) void (^movingBlock)(NPMetroSubView *);
//监听view的松手事件
@property (nonatomic, copy) void (^movingEndedBlock)(NPMetroSubView *);
//view的类型
@property (nonatomic, assign) NSInteger type;
//viewde坐标
@property (nonatomic, assign) NSInteger position;

@property (nonatomic, assign) NSInteger oldPosition;

@property (nonatomic, strong) NSMutableArray *positions;

@property (nonatomic, strong) NSMutableArray *Fpositions;

@property (nonatomic, strong) NSMutableArray *Spositions;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) CGFloat margin;


+ (instancetype)metroSubViewWithType:(NSInteger)type andPosition:(NSInteger)position;

+ (instancetype)metroSubViewWithType:(NSInteger)type;


@end
