//
//  NPTilesTableViewCell.m
//  Nexpaq Beta project
//
//  Created by USER on 16/6/2.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPTilesTableViewCell.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "NSString+stringToHexString.h"
#import "NSString+cut_String.h"

@interface NPTilesTableViewCell()

@property (nonatomic, strong) UIImageView *tileImageView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *tileLabel;
@property (nonatomic, strong) UILabel *tileSubtitleLabel;
@property (nonatomic, strong) NSString *colorString;

@end

@implementation NPTilesTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"status";
    
    NPTilesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[NPTilesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self layoutSubviews];
    
    if (self) {
        
        self.tileImageView = [[UIImageView alloc]init];
        
        self.containerView = [[UIView alloc] init];
        
        [self.containerView addSubview:self.tileImageView];
        
        self.containerView.layer.cornerRadius = 5;
        
        self.containerView.layer.masksToBounds = YES;
        
        self.tileLabel = [[UILabel alloc]init];
        
        self.tileSubtitleLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:_containerView];
        [self.contentView addSubview:_tileLabel];
        [self.contentView addSubview:_tileSubtitleLabel];
        // cell的设置
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.height = 80 ;
}

#pragma setter 方法设置 tileImageView tileLabel tileSubtitleLabel 里面的数据

-(void)setModules:(NPTilesModules *)modules{

    _modules = modules;
    
    self.containerView.frame = CGRectMake(5 , 0, self.height - 5, self.height - 5);
    
    self.containerView.backgroundColor = [self colorString:modules.background];
    
    self.tileImageView.size = CGSizeMake(self.containerView.width * 0.4, self.containerView.height * 0.4);
    
    self.tileImageView.x = (self.containerView.width - self.tileImageView.width) * 0.5 ;
    
    self.tileImageView.y = (self.containerView.height - self. tileImageView.height) *0.5;
    
    NSLog(@"-----%@------0%@---",NSStringFromCGPoint(self.tileImageView.center),NSStringFromCGPoint(self.containerView.center));
    
    [self.tileImageView sd_setImageWithURL:[NSURL URLWithString:modules.icon] placeholderImage:[UIImage imageNamed:@"HomeLeft_Icon"] options:nil];
    
    self.tileLabel.font = [UIFont systemFontOfSize:18];
    
    self.tileLabel.numberOfLines = 0;
    
    self.tileLabel.frame = CGRectMake(CGRectGetMaxX(self.containerView.frame) + 5 , 0 , self.frame.size.width - 10 - self.containerView.frame.size.width, self.containerView.frame.size.height * 0.3);
    
    CGSize maximunSize = CGSizeMake(self.frame.size.width - 10 - self.containerView.frame.size.width, 9999);
    
    NSDictionary *attrDict = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    
    CGSize dataStringSize = [modules.desc boundingRectWithSize:maximunSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
    
    CGRect dataFrame = CGRectMake(CGRectGetMaxX(self.containerView.frame) + 5, CGRectGetMaxY(self.tileLabel.frame) + 5 , self.frame.size.width - 10 - self.containerView.frame.size.width, dataStringSize.height);
    
    self.tileSubtitleLabel.font = [UIFont systemFontOfSize:12];
    
    self.tileSubtitleLabel.numberOfLines = 0;
    
    self.tileSubtitleLabel.textColor = [UIColor lightGrayColor];

    self.tileSubtitleLabel.frame = dataFrame;
    
    self.tileLabel.text = modules.name;
    
    self.tileSubtitleLabel.text = modules.desc;
}

-(UIColor *)colorString:(NSString *)colorString{
    
    _colorString = colorString;
    
    NSString *redString = [colorString cutStringWithLocation:1 andLenth:2];
    
    NSInteger redInteger = [redString numberWithHexString];
    
    NSString *greenString = [colorString cutStringWithLocation:3 andLenth:2];
    
    NSInteger greenInteger = [greenString numberWithHexString];
    
    NSString *blueString = [colorString cutStringWithLocation:5 andLenth:2];
    
    NSInteger blueInteger = [blueString numberWithHexString];
    
    UIColor *color = [UIColor colorWithRed:redInteger / 255.0 green:greenInteger /  255.0 blue:blueInteger / 255.0 alpha:1];
    
    return color;
}

@end
