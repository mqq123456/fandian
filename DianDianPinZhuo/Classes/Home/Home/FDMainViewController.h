//
//  FDMainViewController.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/27.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//  首页

#import "RootViewController.h"
@class UIPopoverListView;
#import "FDAdView.h"
@interface FDMainViewController : RootViewController
@property (nonatomic ,strong) NSMutableArray *timeArray;//开餐时间，包括今天，明天
@property (nonatomic ,weak) UIPopoverListView *popoverListView;
@property (nonatomic ,strong) NSMutableArray *adsArray;//广告
@property (nonatomic ,strong) NSMutableArray *peoples_descArray;//广告
@property (nonatomic ,strong) NSMutableArray *peoplesArray;
@property (nonatomic ,strong) NSMutableArray *kdatesArray;//开餐
@property (nonatomic ,strong) NSMutableArray *kdates;//开餐日期数组
@property (nonatomic ,strong) NSMutableArray *kdescs;//开餐日期描述
@property (nonatomic ,strong) NSMutableArray *ktimes;//开餐时间数组
@property (nonatomic ,strong) NSMutableArray *kmeal_ids;//开餐时间对应的id
@property (nonatomic ,assign) NSInteger best_select_index;
@property (nonatomic ,assign) NSInteger time_select_index;
@property (nonatomic ,assign) NSInteger people_selected_index;
@property (nonatomic ,assign) NSInteger last_best_index;
@property (nonatomic ,assign) int local;
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UIButton *locationBtn;
@property (nonatomic ,strong) NSMutableArray *eatingDatesArray;//堆时间button的数组
@property (nonatomic ,copy) NSString *latString;
@property (nonatomic ,copy) NSString *lngString;
@property (nonatomic ,copy) NSString *local_lng;
@property (nonatomic ,copy) NSString *local_lat;
@property (nonatomic ,copy) NSString *peopleNum;
@property (nonatomic ,copy) NSString *kdate;
@property (nonatomic ,copy) NSString *kdate_desc;
@property (nonatomic ,copy) NSString *meal_id;
@property (nonatomic ,copy) NSString *meal_time;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIButton *lookBtn;
@property (weak, nonatomic) IBOutlet UILabel *lookLabel;
///订单id
@property (nonatomic ,copy)NSString* order_id;
///就餐时间
@property (weak, nonatomic) IBOutlet UIButton *eatingTimaBtn;

@property (nonatomic ,strong) NSMutableArray *listAdsArray;

///广告
@property (nonatomic ,strong)FDAdView* adView;
@property (nonatomic ,assign) int is_msg;

@property (nonatomic ,copy) NSString *integral_tip;
- (void)orderVC:(UIButton *)sender;
- (void)ticketVC:(UIButton *)sender;
- (void)doneBtnClick;
- (void)cancleBtnClick;
- (void)adViewClick;

@end
