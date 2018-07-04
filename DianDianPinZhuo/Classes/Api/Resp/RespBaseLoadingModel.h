//
//  RespBaseLoadingModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//	Loading接口返回

#import "RespBaseModel.h"
#import "VersionModel.h"
#import "OrderMsgModel.h"
@interface RespBaseLoadingModel : RespBaseModel
///版本
@property (strong,nonatomic) VersionModel *version;
///订单
@property (strong,nonatomic) OrderMsgModel *orderMsgModel;
///职业
@property (strong,nonatomic) NSMutableArray *industries;//industriesModel
///开餐时间
@property (strong,nonatomic) NSMutableArray *kdates;//KdateModel
///APP下载URL：关于页面del
@property (strong,nonatomic) NSString *down_url;
///客服电话
@property (strong,nonatomic) NSString *service;
///邀请H5地址
@property (strong,nonatomic) NSString *invite_url;
///
@property (strong,nonatomic) NSString *device_token;
///协议URL地址
@property (strong,nonatomic) NSString *agreement_url;
///banner广告
@property (strong,nonatomic) NSMutableArray *ads;//AdssModel
///超时时间：180(单位秒）
@property (strong,nonatomic) NSString *order_timeout;
///这是一个下订单前的提示信息字符串数组
@property (nonatomic,strong) NSMutableArray *order_tips;
@property (nonatomic,strong) NSMutableArray *topic_tips;

///这是一个下秒杀订单前的提示信息字符串数组
@property (nonatomic,strong) NSMutableArray *seckill_order_tips;
///抵扣券使用规则的URL地址
@property (nonatomic,strong) NSString *voucher_qa_url;
///提前预定提示标题
@property (nonatomic,strong) NSString *advanced_order_tips_title;
///提前预定提示，点击问号显示
@property (nonatomic,strong) NSString *advanced_order_tips_content;
//第一次进群提示
@property (nonatomic,strong) NSString *groups_notice;
///是否有未读消息：1是，0否
@property (nonatomic,copy) NSString *is_msg;
///拼桌人数
@property (nonatomic,strong) NSMutableArray *peoples;///peopleModel
///抵扣券 发票
@property (nonatomic,strong) NSString *integral_tip;
///附近就餐人数
@property (strong,nonatomic) NSString *nearby_people;
///附近就餐人数描述
@property (strong,nonatomic) NSString *nearby_people_desc;
///附近话题总数
@property (strong,nonatomic) NSString *nearby_topic;
///附近话题总数描述
@property (strong,nonatomic) NSString *nearby_topic_desc;
//话题分类id
@property (strong,nonatomic) NSMutableArray *topic_class_id;

//话题分类名字
@property (strong,nonatomic) NSMutableArray *topic_class_name;
//座位数
@property (strong,nonatomic) NSMutableArray *seats;//seatModel

@end
