//
//  NPTilesTableViewCell.m
//  Nexpaq Beta project
//
//  Created by USER on 16/6/2.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPTilesTableViewCell.h"
#import "UIView+Extension.h"

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
    
//    NSLog(@"------%@-----",NSStringFromCGRect(self.frame));
    [self layoutSubviews];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 , 0, self.width * 0.3, self.height - 5)];
        imageView.image = [UIImage imageNamed:@"HomeLeft_Icon"];
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        
        _tileImageView = imageView;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5 , 0 , self.frame.size.width - 10 - imageView .frame.size.width, imageView.frame.size.height * 0.3)];
        
        _tileLabel = label;
        
        UILabel *subtitleLabe = [[UILabel alloc] init];
        
        CGSize maximunSize = CGSizeMake(self.frame.size.width - 10 - imageView .frame.size.width, 9999);
        
        NSString *string = @"Allows you to control LED, it's color and blinking frequency.";
        
        NSDictionary *attrDict = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
        
        CGSize dataStringSize = [string boundingRectWithSize:maximunSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
        
        CGRect dataFrame = CGRectMake(CGRectGetMaxX(imageView.frame) + 5, CGRectGetMaxY(label.frame), self.frame.size.width - 10 - imageView.frame.size.width, dataStringSize.height);
        
        subtitleLabe.frame = dataFrame;
        
        _tileSubtitleLabel = subtitleLabe;
        
        label.text = @"LED";
        
        label.font = [UIFont systemFontOfSize:18];
        
        subtitleLabe.text = string;
        
        subtitleLabe.font = [UIFont systemFontOfSize:12];
        
        subtitleLabe.numberOfLines = 0;
        
        subtitleLabe.textColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:imageView];
        [self.contentView addSubview:_tileLabel];
        [self.contentView addSubview:_tileSubtitleLabel];
        
//        self.imageView.image = [UIImage imageNamed:@"HomeLeft_Icon"];
//        self.textLabel.text = @"LED";
//        self.detailTextLabel.text = @"Allows you to control LED, it's color and blinking frequency.";
//        self.detailTextLabel.numberOfLines = 0;
//        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        // cell的设置
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.height = 80 ;
    
//    CGFloat imageX = 0;
//    CGFloat imageY = 5;
//    CGFloat imageH = self.height - 2 * imageY;
//    CGFloat imageW = self.width * 0.3;
//    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
//    
//    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
//    
//    self.detailTextLabel.x = self.textLabel.x;
}

#pragma setter 方法设置 tileImageView tileLabel tileSubtitleLabel 里面的数据


@end
