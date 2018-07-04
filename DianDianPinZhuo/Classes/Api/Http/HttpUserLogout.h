//
//  HttpUserLogout.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FDConfigViewController;
@interface HttpUserLogout : NSObject
//获取单例对象
+(id)sharedInstance;
/**
 *  退出登录
 *
 */
- (void)loadUserLogOutBtnClick:(UIButton *)button Controller:(FDConfigViewController *)controller;
@end
