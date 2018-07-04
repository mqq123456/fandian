//
//  FDDetailViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/22.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//  餐厅详情

#import "RootGroupTableViewController.h"
#import "MerchantModel.h"
@interface FDDetailViewController : RootGroupTableViewController

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
@end

