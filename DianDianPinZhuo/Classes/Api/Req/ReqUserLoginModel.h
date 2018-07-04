//
//  ReqUserLoginModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  用户登陆

#import <Foundation/Foundation.h>

@interface ReqUserLoginModel : NSObject
///用户帐号:手机号
@property (strong,nonatomic) NSString *phone;
///手机验证码
@property (strong,nonatomic) NSString *vcode;
///友盟生成的device码，用于友盟发通知
@property (strong,nonatomic) NSString *device_token;
@property (strong,nonatomic) NSString *local_lng;

@property (strong,nonatomic) NSString *local_lat;

@property (strong,nonatomic) NSString *cver;
@property (strong,nonatomic) NSString *imei;

@property (strong,nonatomic) NSString *platform;
///渠道：请找产品经理要
@property (strong,nonatomic) NSString *channel;
/**
 *  用户注册来源
 */
@property (strong,nonatomic) NSString *source;
/**
 *  用户微信账号
 */
@property (strong,nonatomic) NSString *weixin_account;

@property (strong,nonatomic) NSString *weixin_head;

@property (strong,nonatomic) NSString *weixin_nickname;


@end
