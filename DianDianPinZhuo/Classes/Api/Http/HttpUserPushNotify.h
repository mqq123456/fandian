//
//  HttpUserPushNotify.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUserPushNotify : NSObject
+(id)sharedInstance;
- (void)loadUserPushNotifyWithPush_id:(NSString *)push_id;
@end
