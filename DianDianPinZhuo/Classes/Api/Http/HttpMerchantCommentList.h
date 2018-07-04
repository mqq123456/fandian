//
//  HttpMerchantCommentList.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HQCommentViewController;

@interface HttpMerchantCommentList : NSObject

+(id)sharedInstance;
- (void)commentListWithMerchant_id:(NSString *)merchant_id controller:(HQCommentViewController *)controller;
- (void)loadMoreMerchantCommentListMerchant_id:(NSString *)merchant_id controller:(HQCommentViewController *)controller;

@end
