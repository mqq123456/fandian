//
//  HttpMerchantCommonComment.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDEvaluationViewController;
@interface HttpMerchantCommonComment : NSObject
+(id)sharedInstance;
- (void)commentWithViewController:(FDEvaluationViewController *)controller;
@end
