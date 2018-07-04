//
//  ReqUserEditModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  修改个人资料

#import <Foundation/Foundation.h>

@interface ReqUserEditModel : NSObject

///用户唯一标识
@property (strong,nonatomic) NSString *kid;

///头像ID:上传头像图片后得到的pic_id
@property int avator_id;

///昵称
@property (strong,nonatomic) NSString *nick_name;

///生日
@property (strong,nonatomic) NSString *birth;

///行业
@property (strong,nonatomic) NSString *industry;

@property (strong,nonatomic) NSString *occupation;//职业
@property (strong,nonatomic) NSString *hometown;//家乡
@property int sex;//性别 1：男 2：女
@property (strong,nonatomic) NSString *ages;//年龄层：60，70，80，90，00后

@property (strong,nonatomic) NSString *constellation;//星座

@property (strong,nonatomic) NSString *company;//公司

@property (strong,nonatomic) NSString *office_build;//写字楼
/**
 *  个人描述
 */
@property (strong,nonatomic) NSString *self_desc;//职业

@end
