//
//  HttpMessageList.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDMessageViewController;
@class FDMessageEditViewController;
@interface HttpMessageList : NSObject

//获取单例对象
+(id)sharedInstance;

- (void)MJRefreshTopController:(FDMessageViewController *)controller;
- (void)loadFristController:(FDMessageViewController *)controller;
- (void)MJRefreshMoreController:(FDMessageViewController *)controller;

/**
 *  消息编辑下拉
 *
 */
- (void)MJRefreshEditTopController:(FDMessageEditViewController *)controller;
/**
 *  消息编辑第一次
 *
 */
- (void)loadFristEditController:(FDMessageEditViewController *)controller deleteStr:(NSString *)delect;
/**
 *  消息编辑上拉
 *
 */
- (void)MJRefreshEditMoreController:(FDMessageEditViewController *)controller;

@end
