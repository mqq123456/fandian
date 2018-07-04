//
//  HttpImGroupExit.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatGroupDetailViewController;
@interface HttpImGroupExit : NSObject
//获取单例对象
+(id)sharedInstance;
/**
 *  退出群组
 *
 */
- (void)loadExitGroup:(ChatGroupDetailViewController *)controller;
/**
 *  群组成员
 */

- (void)loadFetchGroupInfo:(ChatGroupDetailViewController *)controller;
@end
