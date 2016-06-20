//
//  NPGatewayUser.m
//  Nexpaq project
//
//  Created by ben on 16/6/17.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPGatewayUser.h"
#import "MJExtension.h"
#import "NPGatewaysModule.h"

@implementation NPGatewayUser

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"gateways" : [NPGatewaysModule class]};
}

+ (Class)objectClassInArray:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"gateways"]) {
        
        return [NPGatewaysModule class];
    }
    return nil;
}

@end
