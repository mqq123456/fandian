//
//  HttpUserWeixinCheck.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDLoginViewController;
@interface HttpUserWeixinCheck : NSObject
+(id)sharedInstance;
- (void)weixinCheckWithController:(FDLoginViewController *)controller;
@end
