//
//  NSString+checkCRC.m
//  Nexpaq(ios-beta)
//
//  Created by Jordan Zhou on 16/4/8.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NSString+checkCRC.h"
#import "NSString+ToData.h"
#import "NSData+CRC.h"

@implementation NSString (checkCRC)

- (BOOL)uuidCheckCRCIsMatch{

    NSString *content = [self cutStringWithLocation:2 andLenth:22 * 2];
    
    NSData *contentData = [content convertHexStrToData];
    
    NSString *CRC = [[NSString stringWithFormat:@"%04x",[contentData crc16Checksum]] uppercaseString];
    
    return [CRC isEqualToString:[self cutStringWithLocation:46 andLenth:4]];

}

@end
