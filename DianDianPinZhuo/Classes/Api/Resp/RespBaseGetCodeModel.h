//
//  RespBaseGetCodeModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  获取手机验证码接口返回

#import "RespBaseModel.h"

@interface RespBaseGetCodeModel : RespBaseModel

@property (strong,nonatomic) NSString *vcode;

@end
