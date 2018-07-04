//
//  UserModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  用户

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (strong,nonatomic) NSString *birth;
///用户的唯一标识,需要登录的接口使用
@property (strong,nonatomic) NSString *kid;
///昵称
@property (strong,nonatomic) NSString *nick_name;
///头像URL
@property (strong,nonatomic) NSString *head;
///用户性别 1：男 2：女  0：未设置
@property (strong,nonatomic) NSString *sex;
///手机号
@property (strong,nonatomic) NSString *phone;
///年龄层：60，70，80，90，00后
@property (strong,nonatomic) NSString *ages;
///行业
@property (strong,nonatomic) NSString *industry;
///职业
@property (strong,nonatomic) NSString *occupation;
///家乡
@property (strong,nonatomic) NSString *hometown;
///星座
@property (strong,nonatomic) NSString *constellation;
///公司
@property (strong,nonatomic) NSString *company;
///写字楼
@property (strong,nonatomic) NSString *office_build;
///口味
@property (strong,nonatomic) NSString *taste;

///成长值
@property (strong,nonatomic) NSString *growup_point;
///积分
@property (strong,nonatomic) NSString *integral_point;
///优惠券个数
@property (strong,nonatomic) NSString *voucher_count;
///未评价数量
@property (strong,nonatomic) NSString *orderSum;

///IM账户密码
@property (strong,nonatomic) NSString *im_password;

@property (strong,nonatomic) NSString *app_invite_url;

@property (strong,nonatomic) NSString *weixin_invite_url;

@property (strong,nonatomic) NSString *weixin_invite_title;

@property (strong,nonatomic) NSString *weixin_invite_content;

@property (assign,nonatomic) int is_msg;


@property (strong,nonatomic) NSString *ages_hint;

@property (strong,nonatomic) NSString *occupation_hint;

@property (strong,nonatomic) NSString *hometown_hint;

@property (strong,nonatomic) NSString *company_hint;

@property (strong,nonatomic) NSString *constellation_hint;

@property (strong,nonatomic) NSString *ages_default;

@property (strong,nonatomic) NSString *occupation_default;

@property (strong,nonatomic) NSString *hometown_default;

@property (strong,nonatomic) NSString *company_default;

@property (strong,nonatomic) NSString *constellation_default;
/**
 *  个人描述
 */
@property (strong,nonatomic) NSString *self_desc;

/**
 *  个人描述
 */
@property (strong,nonatomic) NSString *complete_info;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
