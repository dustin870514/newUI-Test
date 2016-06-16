//
//  NPBLE_ParseManager.m
//  Nexpaq Beta project
//
//  Created by Jordan Zhou on 16/4/28.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NPBLE_ParseManager.h"
#import "NSString+cut_String.h"
#import "NSString+stringToHexString.h"
#import "NPCalcStringUtility.h"
#import "NPFileManager.h"
#import "NPBLE_Control.h"
#import "NPBLE_Module.h"
#import "NPBLE_Parse.h"
//#import "NotifycationName_defineHeader.h"

@interface NPBLE_ParseManager ()



@end

@implementation NPBLE_ParseManager

+ (NPBLE_Control *)NPBLE_ParseControlWithModule:(NPBLE_Module *)module   andDevice:(NPBLE_Device *)device andHTMLCommand:(NSString *)command{
    
    NSInteger product_id = [module.product_id integerValue];
    
    NSInteger node_id = [module.node_id integerValue];
    
    NSString *name = [command cutStringWithStartString:@":\"" andEndString:@"\","];
    
    if ([name isEqualToString:@"GetBatteryList"]) {// battery module
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFYCATION_ISBATTERRYMODULE object:nil];
        
        return nil;
    }
    
    NSString *param = [command cutStringWithStartString:@"[" andEndString:@"]"];
    
    NSArray *params = [param componentsSeparatedByString:@","];
    
    NSMutableString *mString = [NSMutableString string];
    
    for (NSString *subParam in params) {
        
        NSString *hexStr = [subParam hexStringFromString];
        
        [mString appendString:hexStr];
    }
    
    NSData *data = [NSData dataWithContentsOfFile:[NPFileManager resourcePathWithProduct_id:product_id andName:[NSString stringWithFormat:@"%@_control.txt",module.version.control]]];
    
    NSArray *module_control = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    for (NSDictionary *dict in module_control) {
        
        if ([dict[@"name"] isEqualToString: name]) {
            
            NPBLE_Control *control = [NPBLE_Control controlWithDict:dict];
            
            control.param = mString;
            
            control.node_id = node_id;
            
            control.device = device;
            
            return control;
            
        }
    }
    
    return nil;
}

+ (NSString *)NPBLE_ParseSenorDataWithModule:(NPBLE_Module *)module andDataString:(NSString *)dataString{
    
    NSArray *parses = [NPBLE_Parse parsesWithModule:module];
    
    NSMutableString *tmpString = [NSMutableString string];
    
    if (parses == nil) return nil;
    
    for (NPBLE_Parse *parse in parses) {
        
        if ([parse.fun isEqualToString:@"state"]) {
            
            NSMutableString *tmp_string = [NSMutableString string];
            
            for (NSNumber *index in parse.data) {
                
                NSString *stateString = [dataString cutStringWithLocation:index.intValue * 2 andLenth:2];
                
                [tmp_string appendString:stateString];
                
            }
            
            NSString *resultString = parse.state[tmp_string];
            
            NSString *subString = [NSString stringWithFormat:@"\\\"%@\\\":\\\"%@\\\"",parse.fun,resultString];
            
            if (tmpString.length == 0) {
                
                tmpString = subString.copy;
                
            }else{
                
                tmpString = [NSString stringWithFormat:@"%@,%@",tmpString,subString].copy;
            }
            
        }else{
            
            NSMutableArray *param_arr = [NSMutableArray array];
            
            for (NSNumber *index in parse.data) {
                
                NSString *stateString = [dataString cutStringWithLocation:index.intValue * 2  andLenth:2];
                
                int number = (int)[stateString numberWithHexString];
                
                [param_arr addObject:@(number)];
                
            }
            
            NSMutableString *formatString = [NSMutableString stringWithString:parse.format];
            
            for (NSNumber *nubmer in param_arr) {
                
                NSRange range = [formatString rangeOfString:@"%d"];
                
                [formatString replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%@",nubmer]];
            }
            
            [formatString stringByReplacingOccurrencesOfString:@" "withString:@""];
            
            NSString *result = [NPCalcStringUtility calcComplexFormulaString:formatString];
            
            NSString *subString = [NSString stringWithFormat:@"\\\"%@\\\":%@",parse.fun,result];
            
            if (tmpString.length == 0) {
                
                tmpString = subString.copy;
                
            }else{
                
                tmpString = [NSString stringWithFormat:@"%@,%@",tmpString,subString].copy;
            }
        }
    }
    
    return tmpString.copy;
}






@end
