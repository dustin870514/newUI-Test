//
//  NPTileView.h
//  NPMetroUIDemo
//
//  Created by Jordan Zhou on 16/6/15.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPMetroSubView.h"
#import "NPEnumHeader.h"
@class NPTile;





@interface NPTileView : NPMetroSubView

@property (nonatomic, strong)  NPTile *tile;


+ (instancetype)tileViewWithTemplate:(NPTileTemplate)tileTemplate;



@end