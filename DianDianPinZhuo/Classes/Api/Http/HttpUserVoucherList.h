//
//  HttpUserVoucherList.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FDOrderViewController.h"

@class FDCouponsViewController;
@class HQCouponsSelectViewController;

@interface HttpUserVoucherList : NSObject
//获取单例对象
+(id)sharedInstance;
/**
 *  下订单加载优惠券
 *
 */
//- (void)loadUserVoucherList:(FDOrderViewController *)controller;

/**
 *  优惠券列表
 *
 */
- (void)loadUserCouponsListFirst:(FDCouponsViewController *)controller;

- (void)loadUserCouponsListTop:(FDCouponsViewController *)controller;

- (void)loadUserCouponsListMore:(FDCouponsViewController *)controller;

/**
 *  优惠券选择页
 */
- (void)loadCouponsSelectViewControllerListMore:(HQCouponsSelectViewController *)controller;
- (void)loadUserVoucherList:(HQCouponsSelectViewController *)controller;

@end
