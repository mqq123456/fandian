//
//  FDEvaluationViewController.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"
#import "FDBonusView.h"
@class FDEvaluationSuccessView;
@interface FDEvaluationViewController : RootGroupTableViewController
@property (nonatomic ,copy) NSString *merchant_id;
@property (nonatomic ,copy) NSString *order_no;
@property (nonatomic ,copy) NSString *merchant_name;
@property (nonatomic ,copy) NSString *icon;
@property (nonatomic ,copy) NSString *creat_time;
@property (nonatomic ,copy) NSString *message_id;
@property (nonatomic) BOOL isFromMessage;
@property (nonatomic ,strong) NSMutableArray *star1;
@property (nonatomic ,strong) NSMutableArray *star2;
@property (nonatomic ,strong) NSMutableArray *star3;
@property (nonatomic ,strong) NSMutableArray *star4;
@property (nonatomic ,strong) NSMutableArray *star5;
@property (nonatomic ,strong) NSMutableArray *itemArray;
@property (nonatomic ,assign) BOOL fromOrderList;
@property (nonatomic ,strong) FDEvaluationSuccessView *bonusView;
- (void)sendTo_weixin_Click;
- (void)bonus_NO_Click;
@end
