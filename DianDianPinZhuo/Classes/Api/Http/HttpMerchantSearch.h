//
//  HttpMerchantSearch.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDMerchantListViewController;

@interface HttpMerchantSearch : NSObject
+(id)sharedInstance;
@property(nonatomic,copy)NSString *ApiUrl;
- (void)merchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng meal_id:(NSString *)meal_id people:(NSString *)people meal_date:(NSString *)meal_date local:(NSString *)local viewController:(FDMerchantListViewController *)controller;
- (void)MJRefreshTopmerchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng meal_id:(NSString *)meal_id people:(NSString *)people meal_date:(NSString *)meal_date local:(NSString *)local viewController:(FDMerchantListViewController *)controller;
- (void)MJRefreshMoremerchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng meal_id:(NSString *)meal_id people:(NSString *)people meal_date:(NSString *)meal_date local:(NSString *)local viewController:(FDMerchantListViewController *)controller;
@end
