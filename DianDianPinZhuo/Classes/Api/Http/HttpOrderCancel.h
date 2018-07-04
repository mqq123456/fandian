//
//  HttpOrderCancel.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDTicket_New_ViewController;
@class FDOrderViewController;
@class FDMyOrderViewController;
@class OrderModel;
@interface HttpOrderCancel : NSObject
//获取单例对象
+(id)sharedInstance;
- (void)PayFailWithOrder_no:(NSString *)order_no controller:(FDOrderViewController *)controller;
- (void)loadCancleOrder:(FDTicket_New_ViewController *)controller;
- (void)loadCancleOrderWithModel:(OrderModel *)model Controller:(FDMyOrderViewController *)controller;
@end
