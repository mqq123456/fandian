//
//  HQCouponsSelectViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/8/31.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "RootViewController.h"
@class VoucherModel;
@protocol HQCouponsSelectViewControllerDelegate <NSObject>

- (void)backWithVoucherModel:(VoucherModel *)voucherModel;

@end



@interface HQCouponsSelectViewController : RootViewController
@property (nonatomic ,copy) NSString *order_no;
@property (nonatomic ,assign)id<HQCouponsSelectViewControllerDelegate>delegate;
@property (nonatomic ,strong) VoucherModel *voucherModel;
@property (nonatomic ,copy)NSString *people;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,copy) NSString *meal_id;
@property (nonatomic ,copy) NSString *merchant_id;
@property (nonatomic ,assign) int page;
@property (nonatomic ,strong) UITableView *tableView;
@end
