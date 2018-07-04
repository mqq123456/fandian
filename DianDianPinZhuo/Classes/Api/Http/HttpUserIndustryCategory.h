//
//  HttpUserIndustryCategory.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDInformationViewController;
@class FDPerfectInformationViewController;
@interface HttpUserIndustryCategory : NSObject
+(id)sharedInstance;
- (void)loadUserIndustryCategoryWithViewController:(FDInformationViewController *)controller;
- (void)loadUserIndustryCategoryWithFDPerfectInformationViewController:(FDPerfectInformationViewController *)controller;
@end
