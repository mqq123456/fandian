//
//  FDMerchantListViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//  餐厅列表页

#import "RootTableViewController.h"


@interface FDMerchantListViewController : RootTableViewController

@property (nonatomic ,strong) NSArray *kdateArray;

@property (nonatomic ,copy) NSString *latString;
@property (nonatomic ,copy) NSString *lngString;
@property (nonatomic ,copy) NSString *local_lng;
@property (nonatomic ,copy) NSString *local_lat;
@property (nonatomic ,copy) NSString *peopleNum;
@property (nonatomic ,copy) NSString *people_desc;
@property (nonatomic ,copy) NSString *kdate_desc;
@property (nonatomic ,copy) NSString *kdate;//开餐日期
@property (nonatomic ,copy) NSString *meal_id;//开餐时间对应的id
@property (nonatomic ,copy) NSString *menu_id;//开餐时间对应的id
@property (nonatomic ,copy) NSString *img;//开餐时间对应的id
@property (nonatomic ,copy) NSString *content;//开餐时间对应的id
@property (nonatomic ,copy) NSString *meal_time;//开餐时间
@property (nonatomic ,strong) NSMutableArray *timeArray;//开餐时间数组
@property (nonatomic ,strong) NSMutableArray *adsArray;//广告
@property (nonatomic ,strong) NSMutableArray *data2;
@property (nonatomic ,strong) NSMutableArray *peoplesArray;
//对应下拉框
@property (nonatomic )NSInteger currentData1Index;
@property (nonatomic )NSInteger currentData2Index;

@property (nonatomic ,strong) NSMutableArray *kdates;
@property (nonatomic ,strong) NSMutableArray *kdescs;
@property (nonatomic ,strong) NSMutableArray *ktimes;
@property (nonatomic ,strong) NSMutableArray *kmeal_ids;
@property (nonatomic ,assign) NSInteger best_select_index;
@property (nonatomic ,assign) int local;
@property (nonatomic ,assign) NSInteger time_selected;
@property (nonatomic ,assign) int is_bz;
///已订满的提示
@property (nonatomic ,copy) NSString *soldout_hint;

@end
