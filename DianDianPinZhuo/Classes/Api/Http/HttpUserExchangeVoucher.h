//
//  HttpUserExchangeVoucher.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FDInvitationCodeViewController;
@interface HttpUserExchangeVoucher : NSObject
+(id)sharedInstance;
- (void)userExchangeVoucher_occ_code:(NSString *)occ_code andViewController:(FDInvitationCodeViewController *)viewController sender:(UIButton *)sender;

@end
