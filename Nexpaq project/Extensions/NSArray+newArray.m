//
//  NSArray+newArray.m
//  nexpaq(new)
//
//  Created by Jordan Zhou on 16/4/7.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NSArray+newArray.h"

@implementation NSArray (newArray)

- (NSMutableArray *)newArrayWithArray:(NSMutableArray *)array{

    if (self.count >= array.count) {
        
        NSMutableArray *tmparr = self.mutableCopy;
        
        for (id obj in array) {
            
            for (id obj1 in self){
                
                if (obj == obj1) {
                    
                    [tmparr removeObject:obj1];
                    
                    break;
                }
                
            }
    }

        return tmparr;
        
  }else{
    
        NSMutableArray *tmparr = array.mutableCopy;
        
        for (id obj in self) {
            
            for (id obj1 in array) {
                
                if (obj == obj1) {
                    
                    [tmparr removeObject:obj1];
                    
                    break;
                }
            }
        }
       
        return tmparr;
    }
    
}

@end
