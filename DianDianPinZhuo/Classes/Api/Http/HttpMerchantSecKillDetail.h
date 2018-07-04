//
//  HttpMerchantSecKillDetail.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDKillDetailViewController;
@interface HttpMerchantSecKillDetail : NSObject
+(id)sharedInstance;

- (void)loadMerchantDetail:(FDKillDetailViewController *)controller;
@end
