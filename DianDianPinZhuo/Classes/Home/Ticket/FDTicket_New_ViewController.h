//
//  FDTicket_New_ViewController.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"
#import "OrderModel.h"
#import "UIPopoverListView.h"
#import "FDMenuView.h"
#import "FDBonusView.h"
#import "FDOderWaitingView.h"
#import "FDTicketFooterView.h"
#import "FDTicketShareView.h"
@class FDTopicWaitingView;

@interface FDTicket_New_ViewController : RootGroupTableViewController

@property (nonatomic ,strong) OrderModel *orderModel;

@property (nonatomic ,copy) NSString *order_no;
@property (nonatomic ,copy) NSString *menu_id;
///用于判断 1.下单之后跳转过，还是正常进入饭票，2.返回按钮是回到首页还是正常返回
@property (nonatomic,assign)BOOL isFromPay;
///红包的显示与隐藏
@property (nonatomic,assign)BOOL isFromPayShowBonus;

///退订之后 弹出的提示框
@property (nonatomic ,weak)   UIPopoverListView* popoverListView;
///
@property (nonatomic ,strong) NSMutableArray *menuArray;
///
@property (nonatomic ,strong) NSMutableArray *categoryArray;
///
@property (nonatomic ,strong) NSMutableArray *imagesURL;
///
@property (nonatomic ,weak)   FDMenuView *menu;
///一分钟刷新一次
@property (nonatomic ,strong) NSTimer *timer;
///没有数据的情况
@property (nonatomic ,assign)BOOL hasNoMassage;
///红包
@property (nonatomic ,strong) FDBonusView* bonusView;

///分享一元饭票
@property (nonatomic ,strong) FDTicketShareView* shareView;

///等待分桌
@property(nonatomic,strong)FDOderWaitingView *waitingView;

@property (nonatomic ,strong) FDTopicWaitingView *topicwaitingView;
///是否被点击，0未打开，1打开
@property(nonatomic, strong)NSMutableArray *selectedArray;
///每一段的用户数组数据
@property(nonatomic, strong)NSMutableArray *rowInSectionArray;
///加载订单详情
- (void)loadUserOrderDetail;
///刷新
- (void)loadUserOrderDetailRepeats;
///退款按钮
- (void)cancleRightItem;
- (void)noRightItem;
///退订成功
- (void)cancleSuccessed;
///退订失败
- (void)cancleFailed;
///分享到微信点击事件
- (void)sendTo_weixin_Click;
///取消分享
- (void)bonus_NO_Click;
@end
