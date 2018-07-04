//
//  HttpMerchantComment.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDEvaluationViewController;

@interface HttpMerchantComment : NSObject
+(id)sharedInstance;
- (void)merchantCommentWithMerchant_id:(int)merchant_id content:(NSString *)content star:(int)star cc_ids:(NSString *)ccids viewController:(FDEvaluationViewController *)viewController order_no:(NSString *)order_no imgs:(NSString *)imgs;
@end
