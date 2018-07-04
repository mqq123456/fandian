//
//  FDMyOrderViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootTableViewController.h"
@class OrderModel;
@interface FDMyOrderViewController : RootTableViewController
@property (nonatomic ,copy) NSString *state;
#pragma mark - 第一次加载
- (void)loadUserOrderListFrist;
@property (nonatomic ,strong) OrderModel *selected_btn_model;///按钮点击的OrderModel
@end
