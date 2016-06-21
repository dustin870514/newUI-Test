//
//  NPTilesModules.m
//  Nexpaq project
//
//  Created by ben on 16/6/15.
//  Copyright © 2016年 ben. All rights reserved.
//

#import "NPTilesModules.h"

@implementation NPTilesModules

-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:@(self.id) forKey:@"id"];
    [aCoder encodeObject:@(self.template) forKey:@"template"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.background forKey:@"background"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super init]) {
        
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.template = [aDecoder decodeObjectForKey:@"template"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
        self.background = [aDecoder decodeObjectForKey:@"background"];
    }
    
    return self;
}

@end
