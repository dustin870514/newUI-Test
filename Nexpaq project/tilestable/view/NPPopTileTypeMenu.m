//
//  NPPopTileTypeMenu.m
//  Nexpaq Beta project
//
//  Created by ben on 16/6/6.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPPopTileTypeMenu.h"
#import "UIView+Extension.h"

@interface NPPopTileTypeMenu()
/*
* all the contents will be showed in this contentView;
*/
@property(nonatomic , strong) UIView *contentView;
/*
 * container will show  all the contents in contentView
 */
@property(nonatomic , strong)UIImageView *containerView;
/*
 * this coverButton will cover all except the contentView in container
 */
@property(nonatomic , strong) UIButton *coverButton;

@end

@implementation NPPopTileTypeMenu

-(instancetype)initWithContentView:(UIView *)view{

    if (self = [super init]) {
        
        self.contentView = view;
    }
    
    return self;

}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        //add the coverButton and container
        UIButton *coverButton = [[UIButton alloc] init];
        [coverButton addTarget:self action:@selector(clickCoverButton) forControlEvents:UIControlEventTouchUpInside];
        coverButton.backgroundColor = [UIColor blackColor];
        coverButton.alpha = 0.3;
        [self addSubview:coverButton];
        self.coverButton = coverButton;
        
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.userInteractionEnabled = YES;
        containerView.image = [self resizedImage:@"popover_background"];
        [self addSubview:containerView];
        self.containerView = containerView;
        
    }
    
    return self;
}

-(void)showInRect:(CGRect)rect{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    self.coverButton.frame = self.frame;
    
    self.containerView.frame = rect;
    [self.containerView addSubview:self.contentView];//add the contentView in the container
    
    //set the margin of contentView from container
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottonMargin = 8 ;
    
    self.contentView.x = leftMargin;
    self.contentView.y = topMargin;
    self.contentView.width = self.containerView.width - leftMargin - rightMargin;
    self.contentView.height = self.containerView.height - topMargin - bottonMargin;
    
    UIButton *queueButton = [[UIButton alloc]init];
    [queueButton setTitle:@"queue" forState:UIControlStateNormal];
    queueButton.frame = CGRectMake(5, 10, self.contentView.width - 10 , 30);
    queueButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [queueButton addTarget:self action:@selector(queueButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *singleButton = [[UIButton alloc]init];
    [singleButton setTitle:@"single" forState:UIControlStateNormal];
    singleButton.frame = CGRectMake(5, CGRectGetMaxY(queueButton.frame) + 10, self.contentView.width - 10, 30);
    singleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [singleButton addTarget:self action:@selector(singleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *doubleButton = [[UIButton alloc]init];
    [doubleButton setTitle:@"double" forState:UIControlStateNormal];
    doubleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    doubleButton.frame = CGRectMake(5, CGRectGetMaxY(singleButton.frame) + 10, self.contentView.width - 10, 30);
    [doubleButton addTarget:self action:@selector(doubleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:queueButton];
    [self.contentView addSubview:singleButton];
    [self.contentView addSubview:doubleButton];
}

-(void)queueButtonClicked:(UIButton *)button{

    if ([self.delegate respondsToSelector:@selector(popTileTypeMenuDismiss:buttonDidClickedByTag:)]) {
        
        [self.delegate popTileTypeMenuDismiss:self buttonDidClickedByTag:ModualsTileTypebyQueue];
    }

}
-(void)singleButtonClicked:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(popTileTypeMenuDismiss:buttonDidClickedByTag:)]) {
        
        [self.delegate popTileTypeMenuDismiss:self buttonDidClickedByTag:ModualsTileTypebySingle];
    }
}

-(void)doubleButtonClicked:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(popTileTypeMenuDismiss:buttonDidClickedByTag:)]) {
        
        [self.delegate popTileTypeMenuDismiss:self buttonDidClickedByTag:ModualsTileTypebyDouble];
    }
    
}

-(void)clickCoverButton{

    [self dismiss];
}

-(void)dismiss{
    
    [self removeFromSuperview];
}

-(UIImage *)resizedImage:(NSString *)imageName{

    UIImage *imgae = [UIImage imageNamed:imageName];
    
    return [imgae stretchableImageWithLeftCapWidth:imgae.size.width*0.5 topCapHeight:imgae.size.height*0.5];
}

@end
