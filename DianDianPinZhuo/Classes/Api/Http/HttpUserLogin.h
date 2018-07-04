//
//  HttpUserLogin.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDLoginViewController;
@interface HttpUserLogin : NSObject
//获取单例对象
+(id)sharedInstance;
/**
 *  登录
 *
 */
- (void)loadLoginClick:(id)sender weixin_account:(NSString *)weixin_account Controller:(FDLoginViewController *)controller;

- (void)delegateWithController:(FDLoginViewController *)controller;
@end
