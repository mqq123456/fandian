//
//  HQMD5Tool.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "HQMD5Tool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HQMD5Tool
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG) strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}
@end
