//
//  RespBaseTopicDetailModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"
#import "FDTopics.h"
#import "MerchantModel.h"
@interface RespBaseTopicDetailModel : RespBaseModel
@property (nonatomic ,strong) FDTopics *topic;
@property (nonatomic ,strong) MerchantModel *merchant;
@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic ,copy) NSString *meal_id;
@property (nonatomic ,copy) NSString *meal_date;
@property (nonatomic ,copy) NSString *left_seat;
@property (nonatomic ,copy) NSString *order_seat;
@property (nonatomic ,copy) NSString *meal_time;
@property (nonatomic ,copy) NSString *kdate_desc;
@property (nonatomic ,copy) NSString *is_order;
@property (nonatomic ,copy) NSString *menu_id;


@property (nonatomic ,strong) NSMutableArray *seats;



@end
