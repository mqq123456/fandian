//
//  FDMerchantDetailController.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"
#import "MerchantModel.h"
#import "XHScrollMenu.h"
#import "FDMerchantDetailBottomView.h"
@class FDMerchantDetailShareModel;
@interface FDMerchantDetailController : RootGroupTableViewController


@property (nonatomic ,strong) MerchantModel *model;
@property (nonatomic, strong) XHScrollMenu *scrollMenu;

@property (nonatomic ,strong) FDMerchantDetailBottomView *bottomView;
//经纬度
@property (nonatomic ,copy) NSString *latString;
@property (nonatomic ,copy) NSString *lngString;
@property (nonatomic ,copy) NSString *local_lng;
@property (nonatomic ,copy) NSString *local_lat;
@property (nonatomic ,copy) NSString *is_bz;
@property (nonatomic , copy)NSString * local;
@property (nonatomic ,strong) NSMutableArray *imagesURL;
@property (nonatomic ,strong) NSMutableArray *menuArray;
@property (nonatomic ,strong) NSMutableArray *categoryArray;
@property (nonatomic ,strong) NSMutableArray *commentArray;

@property (nonatomic ,copy) NSString *peopleNum;//人数
@property (nonatomic ,copy) NSString *kdate;//日期
@property (nonatomic ,copy) NSString *meal_id;//时间对应id
@property (nonatomic , copy) NSString *meal_time;//时间
@property (nonatomic , copy)NSString * kdate_desc;///今天，明天
@property (nonatomic , assign)int merchant_id;

///已订满的提示，对应上面状态3
@property (nonatomic , copy)NSString * soldout_hint;
///餐厅未开餐餐点已过的提示，对应上面状态4
@property (nonatomic , copy)NSString * meal_time_end_hint;
///已过期时段的提示，对应上面状态2
@property (nonatomic , copy)NSString * meal_time_expired_hint;



@property (nonatomic ,strong) NSMutableArray *kdescs;//开餐日期描述
@property (nonatomic ,strong) NSMutableArray *ktimes;//开餐时间数组
@property (nonatomic ,strong) NSMutableArray *kmeal_ids;//开餐时间对应的id
@property (nonatomic ,strong) NSMutableArray *kmeal_state;
@property (nonatomic ,strong) NSMutableArray *is_discounts;
@property (nonatomic ,assign) NSInteger best_select_index;
@property (nonatomic ,assign) NSInteger select_index;
@property (nonatomic ,strong) NSMutableArray *timeArray;
@property (nonatomic ,strong) NSMutableArray *kdates;
@property (nonatomic ,strong) NSMutableArray *seats;
@property (nonatomic ,strong) NSMutableArray *friend_hint;
@property (nonatomic ,copy) NSString *left_seat;
@property (nonatomic ,copy) NSString *order_seat;
@property (nonatomic ,copy) NSString *people_hint;
@property (nonatomic ,copy) NSString *price;
@property (nonatomic ,copy) NSString *original_price;
@property (nonatomic ,copy) NSString *jzjg;
@property (nonatomic ,copy) NSString *total_deduction;
@property (nonatomic ,copy) NSString *paid;
@property (nonatomic ,copy) NSString *menu_id;
@property (nonatomic ,copy) NSString *people_desc;

@property (nonatomic ,assign) int left_right;//left==yes,right==no
@property (nonatomic ,copy) NSString *is_western_restaurant;
///套餐，可能2中套餐
@property (nonatomic, strong) NSMutableArray *menus_copy;
@property (nonatomic, strong) FDMerchantDetailShareModel *shareModel;
- (void)loadMerchantDetailBack;
- (void)pushToCommentController;
@end
