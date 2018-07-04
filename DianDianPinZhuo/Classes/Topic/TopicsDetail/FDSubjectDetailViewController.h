//
//  FDSubjectDetailViewController.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"
#import "FDTopics.h"
#import "MerchantModel.h"
#import "FDGuideView.h"
@class FDUsersFrame;
@interface FDSubjectDetailViewController : RootGroupTableViewController
@property (nonatomic ,strong) FDTopics *model;
@property (nonatomic ,strong) MerchantModel *merchant;
@property (nonatomic ,strong) NSMutableArray *commentArray;
@property (nonatomic ,strong) FDUsersFrame *usersFrame;
@property (nonatomic ,strong) NSMutableArray *seats;
@property (nonatomic ,weak) UIImageView *endImageView;
@property (nonatomic ,copy) NSString *latString;
@property (nonatomic ,copy) NSString *lngString;
@property (nonatomic ,copy) NSString *local_lng;
@property (nonatomic ,copy) NSString *local_lat;
@property (nonatomic ,copy) NSString *meal_id;
@property (nonatomic ,copy) NSString *meal_date;
//回复某人的kid
@property (copy, nonatomic) NSString * kid;
@property (nonatomic ,assign) int local;


@property (nonatomic ,copy) NSString *peopleNum;//人数
@property (nonatomic ,copy) NSString *kdate;//日期
@property (nonatomic , copy) NSString *meal_time;//时间
@property (nonatomic , copy)NSString * kdate_desc;///今天，明天
@property (nonatomic , copy)NSString * price;
@property (nonatomic , copy)NSString * icon;
@property (strong,nonatomic) NSString *menu_id;


@property (nonatomic ,copy) NSString *left_seat;
@property (nonatomic ,copy) NSString *order_seat;
@property (nonatomic ,copy) NSString *is_order;
@property (nonatomic ,weak) FDGuideView *guideView;
@property (nonatomic ,assign) BOOL fromHtml5;
///点击群组里的分享跳过来，不像是右上角的分享按钮
@property (nonatomic ,assign) BOOL share;
@property (nonatomic ,assign) BOOL is_from_push;
- (void)loadTopicDetail;
- (void)commentBackAndLoadTopicDetail;
- (void)commentDeleteBackAndLoadTopicDetail;
@end
