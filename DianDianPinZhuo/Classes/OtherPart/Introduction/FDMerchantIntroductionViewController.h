//
//  FDMerchantIntroductionViewController.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/28.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"
#import "MerchantModel.h"

@interface FDMerchantIntroductionViewController : RootGroupTableViewController

@property (nonatomic ,assign) BOOL is_to_topic_join;
@property (nonatomic ,assign) BOOL is_introduction;
@property (nonatomic ,strong) MerchantModel *model;
//经纬度
@property (nonatomic ,copy) NSString *latString;
@property (nonatomic ,copy) NSString *lngString;
@property (nonatomic ,copy) NSString *local_lng;
@property (nonatomic ,copy) NSString *local_lat;
@property (nonatomic ,copy) NSString *peopleNum;//人数
@property (nonatomic ,copy) NSString *kdate;//日期
@property (nonatomic ,copy) NSString *meal_id;//时间对应id
@property (nonatomic , copy) NSString *meal_time;//时间
@property (nonatomic , copy)NSString * kdate_desc;///今天，明天
@property (nonatomic , copy)NSString * local;

@property (nonatomic , copy)NSString * menu_id;
@property (nonatomic ,strong) NSMutableArray *imagesURL;
@property (nonatomic ,strong) NSMutableArray *menuArray;
@property (nonatomic ,strong) NSMutableArray *categoryArray;
@property (nonatomic ,strong) NSMutableArray *commentArray;
@property (nonatomic ,strong) NSMutableArray *merchantArray;
@property (nonatomic ,strong) NSMutableArray *small_menusArray;
@property (nonatomic ,strong) NSMutableArray *small_categoryArray;
@property (nonatomic ,strong) NSMutableArray *small_imagesURL;
@property (nonatomic ,copy) NSString *clean_plate_hint;//光盘行动提示
@property (nonatomic ,copy) NSString *small_menu_hint;//环保菜单提示，如“查看环保菜单”
@property (nonatomic ,copy) NSString *small_menu_title;


@property (nonatomic ,strong) NSMutableArray *kdescs;//开餐日期描述
@property (nonatomic ,strong) NSMutableArray *ktimes;//开餐时间数组
@property (nonatomic ,strong) NSMutableArray *kmeal_ids;//开餐时间对应的id
@property (nonatomic ,assign) NSInteger best_select_index;
@property (nonatomic ,assign) NSInteger select_index;
@property (nonatomic ,strong) NSMutableArray *timeArray;
@property (nonatomic ,strong) NSMutableArray *kdates;
@property (nonatomic ,strong) NSMutableArray *seats;
@property (nonatomic ,strong) NSMutableArray *friend_hint;
@property (nonatomic ,copy) NSString *left_seat;
@property (nonatomic ,copy) NSString *order_seat;
@property (nonatomic ,copy) NSString *price;
@property (nonatomic ,copy) NSString *people_desc;
@property (nonatomic ,copy) NSString *topic_id;
@property (nonatomic,copy) NSString *people_hint;
@property (nonatomic ,copy) NSString *img;
@property (nonatomic,copy) NSString *content;
@property (nonatomic ,assign) BOOL is_from_topic;
@property (nonatomic ,assign) NSString *is_bz;


@property (nonatomic , assign)int merchant_id;

@property (nonatomic ,assign) int left_right;//left==yes,right==no

///套餐，可能2中套餐
@property (nonatomic, strong) NSMutableArray *menus_copy;

- (void)pushToCommentController;
- (void)loadMerchantDetailBack;
@end
