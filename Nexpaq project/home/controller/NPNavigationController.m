//
//  NPNavigationController.m
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 dustin. All rights reserved.
//

#import "NPNavigationController.h"

// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation NPNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{

    [self setupNavigationBarTheme];
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    // UITextAttributeFont  --> NSFontAttributeName(iOS7)
#warning 过期 : 并不代表不能用, 仅仅是有最新的方案可以取代它
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:18];
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
}


@end
