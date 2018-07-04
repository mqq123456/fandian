//
//  HttpTopicSponsor.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDMerchantIntroductionViewController;
@interface HttpTopicSponsor : NSObject
+(id)sharedInstance;
-(void)sendWithController:(FDMerchantIntroductionViewController *)controller;

@end
