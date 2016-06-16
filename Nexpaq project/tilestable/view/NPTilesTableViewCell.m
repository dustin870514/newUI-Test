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

@interface NPTilesTableViewCell()

@property (nonatomic, strong) UIImageView *tileImageView;
@property (nonatomic, strong) UILabel *tileLabel;
@property (nonatomic, strong) UILabel *tileSubtitleLabel;

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
        
        self.tileImageView.layer.cornerRadius = 5;
        
        self.tileImageView.layer.masksToBounds = YES;
        
        self.tileLabel = [[UILabel alloc]init];
        
        self.tileSubtitleLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:_tileImageView];
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
    
    self.tileImageView.frame = CGRectMake(5 , 0, self.width * 0.3, self.height - 5);
    
    [self.tileImageView sd_setImageWithURL:[NSURL URLWithString:modules.icon] placeholderImage:[UIImage imageNamed:@"HomeLeft_Icon"] options:nil];
    
    self.tileLabel.font = [UIFont systemFontOfSize:18];
    
    self.tileLabel.numberOfLines = 0;
    
    self.tileLabel.frame = CGRectMake(CGRectGetMaxX(self.tileImageView.frame) + 5 , 0 , self.frame.size.width - 10 - self.tileImageView.frame.size.width, self.tileImageView.frame.size.height * 0.3);
    
    CGSize maximunSize = CGSizeMake(self.frame.size.width - 10 - self.tileImageView.frame.size.width, 9999);
    
    NSDictionary *attrDict = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    
    CGSize dataStringSize = [modules.desc boundingRectWithSize:maximunSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
    
    CGRect dataFrame = CGRectMake(CGRectGetMaxX(self.tileImageView.frame) + 5, CGRectGetMaxY(self.tileLabel.frame) + 5 , self.frame.size.width - 10 - self.tileImageView.frame.size.width, dataStringSize.height);
    
    self.tileSubtitleLabel.font = [UIFont systemFontOfSize:12];
    
    self.tileSubtitleLabel.numberOfLines = 0;
    
    self.tileSubtitleLabel.textColor = [UIColor lightGrayColor];

    self.tileSubtitleLabel.frame = dataFrame;
    
    self.tileLabel.text = modules.name;
    
    self.tileSubtitleLabel.text = modules.desc;
}

@end
