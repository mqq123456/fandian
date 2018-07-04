//
//  HttpUserMessageDel.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDMessageEditViewController;
@interface HttpUserMessageDel : NSObject
//获取单例对象
+(id)sharedInstance;

/**
 *  删除消息
 *
 */
- (void)loadDeleteMessage:(FDMessageEditViewController *)controller;

@end
