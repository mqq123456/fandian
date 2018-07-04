//
//  NSString+Urldecode.m
//  normandy
//
//  Created by user on 15/6/27.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import "NSString+Urldecode.h"

@implementation NSString (Urldecode)
- (NSString *)stringByDecodingURLFormat
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}
@end
