//
//  Md5.m
//  UIText
//
//  Created by 李志强 on 15/7/21.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "Md5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation Md5


+ (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (uint32_t)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
