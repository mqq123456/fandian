//
//  HttpMerchantSearchNear.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDNearMerchantViewController;
@interface HttpMerchantSearchNear : NSObject
+(id)sharedInstance;

- (void)merchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng local:(NSString *)local viewController:(FDNearMerchantViewController *)controller;
- (void)MJRefreshTopmerchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng local:(NSString *)local viewController:(FDNearMerchantViewController *)controller;
- (void)MJRefreshMoremerchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng local:(NSString *)local viewController:(FDNearMerchantViewController *)controller;
@end

