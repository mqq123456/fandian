//
//  FDHomeViewController.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootViewController.h"
#import "FDAdView.h"
@class UIPopoverListView;
@interface FDHomeViewController : RootViewController
///广告
@property (nonatomic ,weak) UIPopoverListView *popoverListView;
@property (nonatomic ,strong)FDAdView* adView;
@property (nonatomic ,copy) NSString *integral_tip;//个人中心，我的钱包后面的提示
@property (nonatomic ,strong) NSMutableArray *adsArray;//广告
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UIView *rightBtnView;

@property (nonatomic ,strong) UIView *redDotView;
@property (nonatomic ,strong) UIView *redView;
@property (nonatomic ,strong) NSMutableArray *kdatesArray;//开餐
@property (nonatomic ,strong) NSMutableArray *kdates;//开餐日期数组
@property (nonatomic ,strong) NSMutableArray *kdescs;//开餐日期描述数组
@property (nonatomic ,strong) NSMutableArray *ktimes;//开餐时间数组
@property (nonatomic ,strong) NSMutableArray *kmeal_ids;//开餐时间对应的id数组
@property (nonatomic ,assign) NSInteger best_select_index;//默认选择位置

////人数
@property (strong,nonatomic) NSMutableArray *eatingDatesArray;
///返回到首页的左侧 右侧
@property (assign,nonatomic) BOOL left;
@property (assign,nonatomic) BOOL locationYES;
#pragma mark  更新版本
- (void)doneBtnClick;
- (void)cancleBtnClick;
- (void)adViewClick;
@end
