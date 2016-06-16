//
//  NSString+cut_String.h
//  NexpaqMain-project
//
//  Created by Kevin on 16/3/18.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (cut_String)

- (instancetype)cutStringWithLocation:(NSInteger)location andLenth:(NSInteger)lenth;

- (instancetype)cutStringWithStartString:(NSString *)startString andEndString:(NSString *)endString;

- (instancetype)getHexStringFromString;

+ (NSArray *)bindEventWithMessageBody:(NSMutableString *)body;

@end
