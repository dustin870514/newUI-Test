//
//  NSData+CRC.h
//  NexpaqMain-project
//
//  Created by Kevin on 16/3/17.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CRC)

- (unsigned short)crc16Checksum;

-(BOOL)crc16Check;

@end
