//
//  FDSponsorTopicViewController.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"

@interface FDSponsorTopicViewController : RootGroupTableViewController
///用户上传的图片
@property (strong,nonatomic) NSString *img;
@property (strong,nonatomic) NSString *people;
///开餐日期：(loading接口获取为准)
@property (strong,nonatomic) NSString *meal_date;
@property (strong,nonatomic) NSString *meal_time;
@property (strong,nonatomic) NSString *kdate_desc;
@property (strong,nonatomic) NSString *menu_id;
@property (nonatomic ,assign) NSInteger best_select_index;
@property (nonatomic ,assign) NSInteger time_select_index;
@property (strong,nonatomic) NSString *meal_id;
@property (nonatomic ,strong) NSString *content;
@property (strong,nonatomic) NSString *default_topic_title;
@end
