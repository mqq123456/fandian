//
//  ReqTopicSponsorModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqTopicSponsorModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///用户发起的话题内容
@property (strong,nonatomic) NSString *content;
///用户上传的图片
@property (strong,nonatomic) NSString *img;
///用户是否要请大家吃饭（0 是，1 否）
@property (strong,nonatomic) NSString *is_eat;
///开餐时间ID:(loading接口获取为准)
@property (strong,nonatomic) NSString *meal_id;
///开餐日期：(loading接口获取为准)
@property (strong,nonatomic) NSString *meal_date;
///商户id
@property (strong,nonatomic) NSString *merchant_id;
///拼桌的人数（is_eat=1 默认为包桌10人）
@property (strong,nonatomic) NSString *people;
///用户简单的自我介绍
@property (strong,nonatomic) NSString *myself_desc;
@property (strong,nonatomic) NSString *avator_id;
@property (strong,nonatomic) NSString *class_id;
@end
