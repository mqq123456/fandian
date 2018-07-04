//
//  HttpMerchantDetail.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDMerchantDetailController;
@class FDMerchantIntroductionViewController;
@interface HttpMerchantDetail : NSObject
+(id)sharedInstance;

- (void)merchantDetailWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng meal_id:(NSString *)meal_id merchant_id:(NSString *)merchant_id meal_date:(NSString *)meal_date local:(NSString *)local viewController:(FDMerchantDetailController *)controller bestSelect_index:(NSInteger)bestSelect_index;

- (void)merchantDetailWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng  merchant_id:(NSString *)merchant_id local:(NSString *)local viewController:(FDMerchantIntroductionViewController *)controller bestSelect_index:(NSInteger)bestSelect_index meal_id:(NSString *)meal_id meal_date:(NSString *)meal_date;
@end
