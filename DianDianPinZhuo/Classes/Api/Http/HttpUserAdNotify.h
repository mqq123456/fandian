//
//  HttpUserAdNotify.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUserAdNotify : NSObject
+(id)sharedInstance;
- (void)loadUserAdNotifyWithAd_id:(NSString *)ad_id;
@end
