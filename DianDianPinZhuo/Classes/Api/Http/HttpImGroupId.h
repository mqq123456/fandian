//
//  HttpImGroupId.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RootGroupTableViewController;

@interface HttpImGroupId : NSObject
+(id)sharedInstance;
- (void)imGroupIdWithOrder_no:(NSString *)order_no table_id:(NSString *)table_id viewController:(RootGroupTableViewController *)viewController button:(UIButton *)btn;
@end
