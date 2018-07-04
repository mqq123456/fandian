//
//  HttpUserOrderList.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDMyOrderViewController;
@interface HttpUserOrderList : NSObject

@property (nonatomic ,assign) BOOL isCommentBack;
//获取单例对象
+(id)sharedInstance;
/**
 *  第一次加载
 *
 */
- (void)loadUserOrderListFirst:(FDMyOrderViewController *)controller;
/**
 *  上拉加载
 *
 */
- (void)loadUserOrderMore:(FDMyOrderViewController *)controller;
/**
 *  下拉加载
 *
 */
- (void)loadUserOrderTop:(FDMyOrderViewController *)controller;
@end
