//
//  NSString+Verification.h
//  DianDianPinZhuo
//
//  Created by user on 15/8/21.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verification)
- (BOOL)isTelephone;
- (BOOL)isVcode;
+ (NSString *)getAstroWithDate:(NSString *)date;

@end
