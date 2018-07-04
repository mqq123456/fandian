//
//  HttpOrderBook.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FDOrderViewController;
@interface HttpOrderBook : NSObject
//获取单例对象
+(id)sharedInstance;

/**
 *  去下单
 *
 */
- (void)orderClick:(FDOrderViewController *)controller button:(UIButton *)button;

@end
