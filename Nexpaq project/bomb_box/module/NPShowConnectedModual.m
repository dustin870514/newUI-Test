//
//  NPShowConnectedModual.m
//  Nexpaq Beta project
//
//  Created by ben on 16/6/6.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPShowConnectedModual.h"
#import "UIView+Extension.h"
#import "NPConnectedModuals.h"
#import "AppDelegate.h"
#import "NPUIbutton.h"
#import "UIImage+Extension.h"
#import "NPBLE_Module_Info.h"
#import "NPBLE_Module.h"

#define PerRowActiveModuleLabeCount 2
#define PerColumActiveModuleLabeCount 3

@interface NPShowConnectedModual()

@property(nonatomic, strong)NPConnectedModuals *connectedModual;

@property(nonatomic, strong)NSNotificationCenter *notificationCenter;

@property(nonatomic, strong)AppDelegate *app;


@end

@implementation NPShowConnectedModual

-(AppDelegate *)app{
    
    if (_app == nil) {
    
        self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    }
    
    return _app;
}

-(NPConnectedModuals *)connectedModual{

    if (_connectedModual == nil) {
        
        self.connectedModual = [[NPConnectedModuals alloc] init];
    }
    
    return _connectedModual;
}


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        for (NSInteger index = 0 ; index < 6; index++) {
           
            CGFloat pointX = (index % PerRowActiveModuleLabeCount) * (self.width * 0.5 );// 0  145  0  145
            
            CGFloat pointY = (index / PerRowActiveModuleLabeCount) * (self.height / 3 );//0  0 50 50
            
            NPUIbutton *button = [[NPUIbutton alloc] initWithFrame:CGRectMake(pointX, pointY, self.width*0.5, self.height/3)];
            
            [button setTitle:@"Empty" forState:UIControlStateNormal];
            
            button.layer.borderWidth = 0.5;
            
            button.layer.borderColor = [UIColor redColor].CGColor;
            
            button.tag = index;
            
            [self addSubview:button];
        }
        
        _notificationCenter = [NSNotificationCenter defaultCenter];
        
        [_notificationCenter addObserver:self selector:@selector(refreshActiveModualView:) name:@"NPBLE_NEW_MODULE_CONNECTED" object:nil];
        
        [_notificationCenter addObserver:self selector:@selector(modualPushout:) name:@"NPBLE_MODULE_PUSHOUT" object:nil];
    }
    
    return self;
}

-(void)refreshActiveModualView:(NSNotification *)userInfo{
    
    NPBLE_Module *module = userInfo.userInfo[@"NPBLE_NEW_MODULE_CONNECTED"];
    
    NSInteger modualIndex = module.node_id.integerValue;
    
    NSString *product_id = module.product_id;//To be carried out according to the table to find the corresponding module name；
    
    for (NPUIbutton *button in self.subviews) {
        
        if (button.tag == modualIndex) {// show the connected modual by annimation, also save the modual at dictionary;
            
            [self updateTheConnectedModaulInformationAtIndex:button withTitle:@"LED" withTitleColor:[UIColor redColor] withImage:[UIImage imageNamed:@"icon_led"] atIndex:button.tag isExist:NO];
            
        }else{
            
            NPConnectedModuals *tempConnectedModual = [self.app.dict objectForKey:[NSString stringWithFormat:@"%ld",button.tag]];
            
            if (tempConnectedModual == nil) { //the connected modual is  not new ; Not just save
                
                [self buttonSetTitle:button withTitle:@"Empty" whitTitleColor:[UIColor whiteColor] withBackgroundColor:[UIColor lightGrayColor]];
                
                
            }else{ // the modual is Empty
                
                [self updateTheConnectedModaulInformationAtIndex:button withTitle:tempConnectedModual.name withTitleColor:[UIColor redColor] withImage:tempConnectedModual.image atIndex:button.tag isExist:YES];
            }
        }
    }
}

-(void)modualPushout:(NSNotification *)note{

    NPBLE_Module *modual = note.userInfo[@"NPBLE_MODULE_PUSHOUT"];
    
    NSInteger modualIndex = modual.node_id.integerValue;
    
    for (NPUIbutton *button in self.subviews) {
        
        if (button.tag == modualIndex) {
            
            [self buttonSetTitle:button withTitle:@"Empty" whitTitleColor:[UIColor whiteColor] withBackgroundColor:[UIColor lightGrayColor]];
            
            [self.app.dict removeObjectForKey:[NSString stringWithFormat:@"%ld",modualIndex]];
        
        }else{
        
            NPConnectedModuals *tempConnectedModual = [self.app.dict objectForKey:[NSString stringWithFormat:@"%ld",button.tag]];
            
            if (tempConnectedModual == nil) {
                
                [self buttonSetTitle:button withTitle:@"Empty" whitTitleColor:[UIColor whiteColor] withBackgroundColor:[UIColor lightGrayColor]];
                
            }else{
            
                [self updateTheConnectedModaulInformationAtIndex:button withTitle:tempConnectedModual.name withTitleColor:[UIColor redColor] withImage:tempConnectedModual.image atIndex:button.tag isExist:YES];
                
            }
        }
    }
}

-(void)buttonSetTitle:(UIButton *)button withTitle:(NSString *)title whitTitleColor:(UIColor *)titleColor withBackgroundColor:(UIColor *)backgroundColor{
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    [button setImage:nil forState:UIControlStateNormal];
    
    [button setBackgroundColor:backgroundColor];
    
}

-(void)updateTheConnectedModaulInformationAtIndex:(NPUIbutton *)button withTitle:(NSString *)title withTitleColor:(UIColor *)color withImage:(UIImage *)image atIndex:(NSInteger)index isExist:(BOOL)isExist{

    if (isExist) {
        
        [button setTitleColor:color forState:UIControlStateNormal];
        
        [button setTitle:title forState:UIControlStateNormal];
        
        [button setImage:[image resizedImage:image] forState:UIControlStateNormal];
        
        button.backgroundColor = [UIColor whiteColor];
        
    }else{
            
        [UIView animateWithDuration:0.3 animations:^{
                
                button.backgroundColor = [UIColor clearColor];
                
            }completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    button.backgroundColor = [UIColor lightGrayColor];
                    
                }completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        button.backgroundColor = [UIColor clearColor];
                        
                    }completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.3 animations:^{
                            
                            button.backgroundColor = [UIColor lightGrayColor];
                            
                        }completion:^(BOOL finished) {
                            
                            [UIView animateWithDuration:0.3 animations:^{
                                
                                button.backgroundColor = [UIColor clearColor];
                                
                            }completion:^(BOOL finished) {
                                
                                [UIView animateWithDuration:0.3 animations:^{
                                    
                                    button.backgroundColor = [UIColor lightGrayColor];
                                    
                                }completion:^(BOOL finished) {
                                    
                                    [UIView animateWithDuration:0.3 animations:^{
                                        
                                        button.backgroundColor = [UIColor clearColor];
                                        
                                    }completion:^(BOOL finished) {
                                        
                                        [button setTitleColor:color forState:UIControlStateNormal];
                                        
                                        [button setTitle:title forState:UIControlStateNormal];
                                        
                                        [button setImage:[image resizedImage:image] forState:UIControlStateNormal];
                                        
                                        [button setBackgroundColor:[UIColor whiteColor]];
                                        
                                        self.connectedModual.name = @"LED";//在此保存，防止layoutSubviews在动画前就取到数据
                                        
                                        self.connectedModual.image = [UIImage imageNamed:@"icon_led"];
                                        
                                        self.connectedModual.arrayIndex = index;
                                        
                                        [self.app.dict setObject:self.connectedModual forKey:[NSString stringWithFormat:@"%ld",index]];
                                        
                                    }];
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];

    for (UIButton *button in self.subviews) {
        
        NPConnectedModuals *tempConnectedModual = [self.app.dict objectForKey:[NSString stringWithFormat:@"%ld",button.tag]];
        
        if (tempConnectedModual) {
            
            [self updateTheConnectedModaulInformationAtIndex:button withTitle:tempConnectedModual.name withTitleColor:[UIColor redColor] withImage:tempConnectedModual.image atIndex:button.tag isExist:YES];
        }else{
            
            [self buttonSetTitle:button withTitle:@"Empty" whitTitleColor:[UIColor whiteColor] withBackgroundColor:[UIColor lightGrayColor]];
        }

        
    }
}

@end
