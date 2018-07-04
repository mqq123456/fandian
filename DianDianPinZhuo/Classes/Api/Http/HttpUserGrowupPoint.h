//
//  HttpUserGrowupPoint.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDGrowingViewController;
@interface HttpUserGrowupPoint : NSObject

//获取单例对象
+(id)sharedInstance;

- (void)MJRefreshTopPage:(int)page controller:(FDGrowingViewController *)controller;
- (void)loadFristPage:(int)page controller:(FDGrowingViewController *)controller;
- (void)MJRefreshMorePage:(int)page controller:(FDGrowingViewController *)controller;

@end
