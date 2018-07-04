//
//  HttpUserOrderDetail.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDTicket_New_ViewController;
@class FDEvaluationViewController;
@interface HttpUserOrderDetail : NSObject
//获取单例对象
+(id)sharedInstance;
- (void)loadUserOrderDetail:(FDTicket_New_ViewController *)controller;
#pragma mark - 一分钟刷新一次
- (void)loadUserOrderDetailRepeats:(FDTicket_New_ViewController *)controller;
- (void)userDetailWithEnvaluation:(FDEvaluationViewController *)controller;
@end
