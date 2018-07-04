//
//  RespUserLoginModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  用户登陆接口返回

#import "RespBaseModel.h"
#import "UserModel.h"

@interface RespUserLoginModel : RespBaseModel

@property (strong,nonatomic) UserModel *user;

@end
