//
//  NPTileView.m
//  NPMetroUIDemo
//
//  Created by Jordan Zhou on 16/6/15.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPTileView.h"
#import "UIView+setFrame.h"
#import "NPTile.h"
#import "NPTileTextAttribute.h"

#define kNPTileIconLeftPath      @"left"
#define kNPTileIconRightPath     @"right"
#define kNPTileIconMiddlePath    @"middle"
#define kNPTileTextLeftAtt       @"left"
#define kNPTileTextRightAtt      @"right"
#define kNPTileTextMiddleAtt     @"middle"

#define kNPTileStatusDefault    @"default"

@interface NPTileView ()

@property (nonatomic, assign) NPTileTemplate tileTemplate;

@property (nonatomic, strong) UIImageView *statusView;

@property (nonatomic, strong) UIImageView *iconView_0;

@property (nonatomic, strong) UIImageView *iconView_1;

@property (nonatomic, strong) UIImageView *iconView_2;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *textLable_0;

@property (nonatomic, strong) UILabel *textLable_1;

@property (nonatomic, strong) UILabel *textLable_2;

@end

@implementation NPTileView

- (instancetype)initWithTileTemplate:(NPTileTemplate)tileTemplate{

    if (self = [super init]) {
        
        self.tileTemplate = tileTemplate;
        
        self.layer.cornerRadius = 5;
        
        self.position = -1;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUpSubViews];
    }
  
    return self;
}


+ (instancetype)tileViewWithTemplate:(NSInteger)tileTemplate{
    
    NPTileTemplate tileTemplateE = [self switchIntegerToNPTileTemplate:tileTemplate];

    return [[self alloc] initWithTileTemplate:tileTemplateE];
}

+ (instancetype)tileViewWithTemplate:(NSInteger)tileTemplate andPosition:(NSInteger)position{

    NPTileView *tileView = [self tileViewWithTemplate:tileTemplate];
    
    tileView.position = position;
    
    return tileView;
}

- (void)setTileTypeWithTileTemplate:(NPTileTemplate)tileTemplate{

    switch (tileTemplate) {
        
        case NPTileTemplateOne:
            
            self.type = 0;
            
            break;
            
            case NPTileTemplateTwo:
            case NPTileTemplateThree:
            
            self.type = 1;
            
            break;
            
            case NPTileTemplateFour:
            case NPTileTemplateFive:
            case NPTileTemplateSix:
            case NPTileTemplateSeven:
            
            self.type = 2;
            
            break;
            
        default:
            
            self.type = 3;
            
            break;
    }
}



- (void)setUpSubViews{
   
    switch (self.tileTemplate) {
        case NPTileTemplateOne:
            
            self.iconView_0.width = self.width * 0.6;
            self.iconView_0.height = self.iconView_0.width;
            self.iconView_0.x = (self.width - self.iconView_0.width) * 0.5;
            self.iconView_0.y = (self.height - self.iconView_0.height) * 0.5;
            [self addSubview:self.iconView_0];
    
            break;
            
        case NPTileTemplateTwo:
        
            self.iconView_0.width = self.width * 0.6;
            self.iconView_0.height = self.iconView_0.width;
            self.iconView_0.x = (self.width - self.iconView_0.width) * 0.5;
            self.iconView_0.y = (self.height - self.iconView_0.height) * 0.5;
            [self addSubview:self.iconView_0];
            
            self.titleLabel.x = 0;
            self.titleLabel.y = 0;
            self.titleLabel.height = self.height * 0.2;
            self.titleLabel.width = self.width;
            [self addSubview:self.titleLabel];
            
            break;
            
        case NPTileTemplateThree:
            
            self.iconView_0.width = self.width * 0.2;
            self.iconView_0.height =self.iconView_0.width;
            self.iconView_0.x = 0;
            self.iconView_0.y = 0;
            [self addSubview:self.iconView_0];
            
            self.textLable_0.width = self.width * 0.6;
            self.textLable_0.height = self.textLable_0.width;
            self.textLable_0.x = (self.width - self.textLable_0.width) * 0.5;
            self.textLable_0.y = (self.height - self.textLable_0.height) * 0.5;
            [self addSubview:self.textLable_0];
            
            break;
            
        case NPTileTemplateThirteen:
            
            self.iconView_0.x = 0;
            self.iconView_0.y = 0;
            self.iconView_0.width = (self.width  -  2 * self.margin) / 3 * 0.2  ;
            self.iconView_0.height = self.iconView_0.width;
            [self addSubview:self.iconView_0];
            
            self.textLable_0.x = self.iconView_0.width;
            self.textLable_0.y = self.iconView_0.height;
            self.textLable_0.width = (self.width  -  2 * self.margin) / 3 * 0.6;
            self.textLable_0.height = self.textLable_0.width;
            [self addSubview:self.textLable_0];
            
            self.iconView_1.x = (self.width + self.margin) / 3;
            self.iconView_1.y = 0;
            self.iconView_1.width = self.iconView_0.width;
            self.iconView_1.height = self.iconView_0.height;
            [self addSubview:self.iconView_1];
            
            self.textLable_1.x = self.iconView_1.width + self.iconView_1.x;
            self.textLable_1.y = self.iconView_1.height;
            self.textLable_1.width = (self.width  -  2 * self.margin) / 3 * 0.6;
            self.textLable_1.height = self.textLable_1.width;
            [self addSubview:self.textLable_1];
            
            self.iconView_2.x = (self.width + self.margin) * 2 / 3;
            self.iconView_2.y = 0;
            self.iconView_2.width = self.iconView_0.width;
            self.iconView_2.height = self.iconView_0.height;
            [self addSubview:self.iconView_2];
            
            self.textLable_2.x = self.iconView_2.width + self.iconView_2.x;
            self.textLable_2.y = self.iconView_2.height;
            self.textLable_2.width = (self.width  -  2 * self.margin) / 3 * 0.6;
            self.textLable_2.height = self.textLable_2.width;
            [self addSubview:self.textLable_2];
            
            
        default:
            break;
    }
    
    self.statusView.x = self.width - self.height * 0.2;
    
    self.statusView.y = self.height * 0.8;
    
    self.statusView.width = self.height * 0.2;
    
    self.statusView.height = self.statusView.width;
    
    [self addSubview:self.statusView];
}

+ (NPTileTemplate)switchIntegerToNPTileTemplate:(NSInteger)integer{

    switch (integer) {
        case 1:
            
            return NPTileTemplateOne;
            
            break;
        case 2:
            
            return NPTileTemplateTwo;
            
            break;
        case 3:
            
            return NPTileTemplateThree;
            
            break;
        case 4:
            
            return NPTileTemplateFour;
            
            break;
        case 5:
            
            return NPTileTemplateFive;
            
            break;
        case 6:
            
            return NPTileTemplateSix;
            
            break;
        case 7:
            
            return NPTileTemplateSeven;
            
            break;
        case 8:
            
            return NPTileTemplateEight;
            
            break;
        case 9:
            
            return NPTileTemplateNine;
            
            break;
        case 10:
            
            return NPTileTemplateTen;
            
            break;
        case 11:
            
            return NPTileTemplateEleven;
            
            break;
        case 12:
            
            return NPTileTemplateTwelve;
            
            break;
        case 13:
            
            return NPTileTemplateThirteen;
            
            break;
    }
    
    return 0;

}

#pragma mark - setter && getter


- (void)setTile:(NPTile *)tile{

    _tile = tile;
    
    self.iconView_0.image = [UIImage imageWithContentsOfFile:tile.iconImagePaths[kNPTileIconLeftPath]];
    
    self.iconView_1.image = [UIImage imageWithContentsOfFile:tile.iconImagePaths[kNPTileIconMiddlePath]];
    
    self.iconView_2.image = [UIImage imageWithContentsOfFile:tile.iconImagePaths[kNPTileIconRightPath]];
    
    self.titleLabel.text = tile.title;
    
    NPTileTextAttribute *tileTextLeftAtt = tile.textAtts[kNPTileTextLeftAtt];
    
    self.textLable_0.font = [UIFont systemFontOfSize:tileTextLeftAtt.size];
        
    self.textLable_0.textColor = tileTextLeftAtt.color;
    
    NPTileTextAttribute *tileTextMiddleAtt = tile.textAtts[kNPTileTextMiddleAtt];
    
    self.textLable_1.font = [UIFont systemFontOfSize:tileTextMiddleAtt.size];
    
    self.textLable_1.textColor = tileTextLeftAtt.color;
    
    NPTileTextAttribute *tileTextRightAtt = tile.textAtts[kNPTileTextRightAtt];
    
    self.textLable_2.font = [UIFont systemFontOfSize:tileTextRightAtt.size];
    
    self.textLable_2.textColor = tileTextRightAtt.color;
    
    self.statusView.image = [UIImage imageWithContentsOfFile:tile.statusImagePaths[kNPTileStatusDefault]];
  
}

- (void)setTileTemplate:(NPTileTemplate)tileTemplate{

    _tileTemplate = tileTemplate;
    
    [self setTileTypeWithTileTemplate:tileTemplate];
}

- (void)setFrame:(CGRect)frame{

    [super setFrame:frame];
    
    [self setUpSubViews];
}

- (UIImageView *)statusView{

    if (_statusView == nil) {
        
        _statusView = [[UIImageView alloc] init];
    }
    
    return _statusView;
}

- (UIImageView *)iconView_0{

    if (_iconView_0 == nil) {
        
        _iconView_0 = [[UIImageView alloc] init];
    }
   
    return _iconView_0;
}

- (UIImageView *)iconView_1{

    if (_iconView_1 == nil) {
        
        _iconView_1 = [[UIImageView alloc] init];
    }
  
    return _iconView_1;
}

- (UIImageView *)iconView_2{

    if (_iconView_2 == nil) {
        
        _iconView_2 = [[UIImageView alloc] init];
    }
  
    return _iconView_2;
}

- (UILabel *)titleLabel{

    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        _titleLabel.textColor = [UIColor blackColor];
    }
  
    return _titleLabel;
}

- (UILabel *)textLable_0{

    if (_textLable_0 == nil) {
        
        _textLable_0 = [[UILabel alloc] init];
        
        _textLable_0.text = @"NexPaq";
    }
    
    return _textLable_0;
}

- (UILabel *)textLable_1{

    if (_textLable_1 == nil) {
        
        _textLable_1 = [[UILabel alloc] init];
        
        _textLable_1.text = @"NexPaq";
    }
  
    return _textLable_1;
}

- (UILabel *)textLable_2{

    if (_textLable_2 == nil) {
        
        _textLable_2 = [[UILabel alloc] init];
        
        _textLable_2.text = @"NexPaq";
    }
  
    return _textLable_2;
}

@end
