//
//  HttpTopicPersonalDescribe.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDTopicTicketViewController;
@class FDTicket_New_ViewController;
@interface HttpOrderSelfDesc : NSObject
+(id)sharedInstance;
- (void)loadTopicPersonalDescribe:(NSString *)table_id andMy_Desc:(NSString *)my_desc andOrder_no:(NSString *)order_no viewController:(FDTicket_New_ViewController *)viewController;
@end
