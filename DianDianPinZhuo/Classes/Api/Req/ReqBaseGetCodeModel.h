//
//  ReqBaseGetCodeModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  获取手机验证码

#import <Foundation/Foundation.h>

@interface ReqBaseGetCodeModel : NSObject
///用户手机号码
@property (strong,nonatomic) NSString *phone;

@end
