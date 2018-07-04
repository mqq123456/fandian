//
//  HttpUserBannerNotify.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUserBannerNotify : NSObject
+(id)sharedInstance;
- (void)loadUserBannerNotifyWithBanner_id:(NSString *)banner_id;
@end
