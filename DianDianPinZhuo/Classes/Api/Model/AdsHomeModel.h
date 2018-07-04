//
//  AdsHomeModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdsHomeModel : NSObject

/**
 *  如1,2,3
 */
@property (nonatomic ,copy) NSString *ads_id;

/**
 *  url	coupon表示优惠券页面,login表示登录页面，其它则为H5具体地址
 */
@property (nonatomic ,copy) NSString *url;

/**
 *  图片地址
 */
@property (nonatomic ,copy) NSString *img;

@property (nonatomic ,copy) NSString *title;

@end
