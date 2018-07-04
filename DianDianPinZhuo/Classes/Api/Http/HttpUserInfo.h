//
//  HttpUserInfo.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDPersonalCenterViewController;
@class FDUserDetailViewController;

@class FDLoginViewController;
@class ChatViewController;

@interface HttpUserInfo : NSObject
+(id)sharedInstance;
- (void)loadUserInfoWithViewController:(FDPersonalCenterViewController *)viewController;
- (void)loadUserDetailViewController:(FDUserDetailViewController *)viewController kid:(NSString *)kid;

- (void)loadWithLoginViewController:(FDLoginViewController *)controller kid:(NSString *)kid;

- (void)loadUserInfoInGroupWithViewController:(ChatViewController *)viewController;

@end
