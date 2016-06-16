//
//  NPTilesModulesResults.m
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPTilesModulesResults.h"
#import "NPTilesModules.h"
#import "MJExtension.h"

@implementation NPTilesModulesResults

-(NSDictionary *)mj_objectClassInArray{

    return @{@"modulesArray" : [NPTilesModules class]};
}


@end
