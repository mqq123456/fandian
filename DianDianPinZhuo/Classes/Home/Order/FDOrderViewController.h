//
//  FDOrderViewController.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"
#import "FDOrderBottomView.h"
#import "UIPopoverListView.h"
#import "VoucherModel.h"


@interface FDOrderViewController : RootGroupTableViewController

@property (nonatomic , copy) NSString *merchant_name;
@property (nonatomic , copy) NSString *merchant_id;
@property (nonatomic , copy) NSString *icon;

@property (nonatomic , copy) NSString *price;
@property (nonatomic , copy) NSString *people;
@property (nonatomic , copy) NSString *people_desc;
@property (nonatomic ,copy) NSString *kdate;
@property (nonatomic ,copy) NSString *kdate_desc;
@property (nonatomic ,copy) NSString *meal_id;
@property (nonatomic ,copy) NSString *menu_id;
@property (nonatomic ,copy) NSString *meal_time;
@property(nonatomic,strong) FDOrderBottomView *bottomView;
@property (nonatomic)BOOL isPayBack;
@property (nonatomic ,weak) UIPopoverListView *popoverListView;
@property (nonatomic ,strong) VoucherModel *voucherModel;
@property (nonatomic ,strong) NSMutableArray *voucherArray;
@property (nonatomic,assign) NSInteger payWay;//1是支付宝，2是微信
@property (nonatomic,copy) NSString *_voucher_cash;//优惠券金额
@property (nonatomic,copy) NSString *_paid;//实际付款金额
@property (nonatomic,copy) NSString *order_on;
@property (nonatomic,copy) NSString *order_kind;
@property (nonatomic,copy) NSString *vacancy_id;
@property (nonatomic,copy) NSString *table_id;
///是否包桌订单 0否 1是
@property (nonatomic,copy) NSString *is_bz;

///使用抵扣的积分数
@property (nonatomic ,copy) NSString *integral_point;
///活动名称
@property (nonatomic ,copy) NSString *activity_id;
///话题ID
@property (nonatomic ,copy) NSString *topic_id;
///发起话题为1，加入话题为0
@property (strong,nonatomic) NSString *initial_topic;
- (void)PayFail;
- (void)timeFialBtnClick;
- (void)orderCancel;

@end
