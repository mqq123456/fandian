//
//  RespTopicPersonalDescribeModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespTopicPersonalDescribeModel : RespBaseModel
/////话题的内容
//@property(nonatomic,copy)NSString *content;
/////发起话题人的头像
//@property(nonatomic,copy)NSString *img;
/////发起话题人的昵称
//@property(nonatomic,copy)NSString *nickname;
/////发起话题人的自我描述
//@property(nonatomic,copy)NSString *myself_desc;
/////该话题是否免费
//@property(nonatomic,copy)NSString *is_free;
/////开餐时间
//@property(nonatomic,copy)NSString *meal_time;
//
/////服务器当前时间戳
//@property(nonatomic,copy)NSString *server_stamp;
/////分桌剩余时间
//@property(nonatomic,copy)NSString *table_alloc_left_time;
/////商户ID
//@property(nonatomic,copy)NSString *merchant_id;
/////商户名称
//@property(nonatomic,copy)NSString *merchant_name;
//
/////商户地址
//@property(nonatomic,copy)NSString *address;
/////同桌的描述
//@property(nonatomic,copy)NSString *table_desc;
/////是否已分桌（0 未分桌，1 分桌）
//@property(nonatomic,copy)NSString *is_table;
/////是几号桌
//@property(nonatomic,copy)NSString *table_name;
/////默认提示，已加入的饭友
//@property(nonatomic,copy)NSString *rice_friend;
/////users
//@property(nonatomic,strong)NSMutableArray *users;

///标题，饭友描述
@property(nonatomic,copy)NSString *ricefriend_title;
///饭友的一句话描述默认提示
@property(nonatomic,copy)NSString *ricefriend_desc;
@end
