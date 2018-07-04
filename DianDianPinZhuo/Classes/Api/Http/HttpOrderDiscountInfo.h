//
//  HttpOrderDiscountInfo.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDSubmitOrderViewController;
@interface HttpOrderDiscountInfo : NSObject
+(id)sharedInstance;

- (void)loadOrderDiscountInfoWithMerchant_id:(NSString *)merchant_id meal_id:(NSString *)meal_id meal_date:(NSString *)meal_date menu_id:(NSString *)menu_id people:(NSString *)people topic_id:(NSString *)topic_id is_bz:(NSString *)is_bz controller:(FDSubmitOrderViewController *)controller;

@end
