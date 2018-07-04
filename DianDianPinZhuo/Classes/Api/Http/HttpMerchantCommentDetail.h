//
//  HttpMerchantCommentDetail.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/16.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDCommentDetailViewController;
@interface HttpMerchantCommentDetail : NSObject
+(id)sharedInstance;
- (void)loadUMerchantCommentDetailWithComment_id:(NSString *)comment_id controller:(FDCommentDetailViewController *)controller;
@end
