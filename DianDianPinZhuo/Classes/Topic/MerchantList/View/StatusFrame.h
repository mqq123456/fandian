//
//  StatusFrame.h
//  meilizhiyue
//
//  Created by 盛杰 on 15/5/3.
//  Copyright (c) 2015年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MerchantModel;
@interface StatusFrame : NSObject
@property (nonatomic, strong) MerchantModel *status;

/** 上部的距离view */
@property (nonatomic, assign) CGRect headViewF;
/** 餐厅距离 */
@property (nonatomic, assign) CGRect head_distanceF;


/** 中间view */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconF;
/** 餐厅名称 */
@property (nonatomic, assign) CGRect merchant_nameF;
/** 星星 */
@property (nonatomic, assign) CGRect starF;
/** 特色 */
@property (nonatomic, assign) CGRect foodF;
/** 热门 */
@property (nonatomic, assign) CGRect hotF;
/** 新上 */
@property (nonatomic, assign) CGRect isNewF;
/** 餐厅订满 */
@property (nonatomic, assign) CGRect dingmanImageF;


/** 底部view */
@property (nonatomic, assign) CGRect bottonViewF;
/** 距离 */
@property (nonatomic, assign) CGRect distanceF;
/** 价格 */
@property (nonatomic, assign) CGRect priceF;
/** 每人 */
@property (nonatomic, assign) CGRect meirenF;


/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
///是否包桌
@property (nonatomic, assign) CGFloat is_bz;



@end
