//
//  HttpImUserDetail.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/7.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDScanViewController;
@interface HttpImUserDetail : NSObject

+(id)sharedInstance;
- (void)loadImUserDetailWithKid:(NSString *)kid viewController:(FDScanViewController *)controller;
@end
