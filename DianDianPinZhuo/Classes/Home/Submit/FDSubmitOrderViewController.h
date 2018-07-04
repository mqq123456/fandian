//
//  FDSubmitOrderViewController.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//


#import "RootGroupTableViewController.h"

#import "RespOrderDiscountInfoModel.h"

@interface FDSubmitOrderViewController : RootGroupTableViewController
@property(nonatomic,copy)NSString * merchant_id;
@property(nonatomic,copy)NSString * merchant_name;
@property(nonatomic,copy)NSString * icon;
@property(nonatomic,copy)NSString * kdate;
@property(nonatomic,copy)NSString * kdate_desc;
@property(nonatomic,copy)NSString * meal_time;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * people;
@property(nonatomic,copy)NSString * people_desc;
@property(nonatomic,copy)NSString * meal_id;
@property(nonatomic,copy)NSString * menu_id;
@property(nonatomic,copy)NSString * order_kind;

///使用抵扣的积分数
@property (nonatomic ,copy) NSString *integral_point;
///活动名称
@property (nonatomic ,copy) NSString *activity_name;
///活动扣减的金额
@property (nonatomic ,copy) NSString *activity_cash;
@property (nonatomic ,copy) NSString *activity_id;

///话题ID
@property (nonatomic ,copy) NSString *topic_id;
///发起话题为1，加入话题为0
@property (strong,nonatomic) NSString *initial_topic;

@property (nonatomic ,strong) RespOrderDiscountInfoModel *model;

@property(nonatomic,assign) BOOL selectedJF;
@property (nonatomic,copy)NSString *is_bz;
@property (nonatomic,assign)BOOL xican;

@end
