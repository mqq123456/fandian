//
//  HttpUserKid.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContactListViewController;
@interface HttpUserKid : NSObject
+(id)sharedInstance;
- (void)userkidWithKids:(NSString *)kids viewController:(ContactListViewController *)viewController;
- (void)userkidWithKids:(NSString *)kids;
@end
