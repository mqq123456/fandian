//
//  NSString+Verification.m
//  DianDianPinZhuo
//
//  Created by user on 15/8/21.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "NSString+Verification.h"

@implementation NSString (Verification)
- (BOOL)isTelephone
{
    NSString * MOBILE = @"^((13[0-9])|(15[^4,\\D])|(18[0,3-9]))\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
}
- (BOOL)isVcode
{
    NSString *      regex = @"(^[0-9]{6}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

+ (NSString *)getAstroWithDate:(NSString *)dateString {
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    
    //////
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[dateFormatter dateFromString:dateString];   //需要转化的字符串
    [dateFormatter setDateFormat:@"MM"];
    NSString *month=[dateFormatter stringFromDate:date];
    //NSLog(@"%@", month);
    [dateFormatter setDateFormat:@"dd"];
    NSString *day=[dateFormatter stringFromDate:date];
    //NSLog(@"%@", day);
    
    if (month==NULL || day==NULL) {
        return @"";
    }
    ///////
    
    NSString *result;
    int m=[month intValue];
    int d=[day intValue];
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    return result;
}

@end
