//
//  FDTopicMerchantListFram.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define describe_LabelFont  [UIFont systemFontOfSize:17]
#define foodFont [UIFont systemFontOfSize:15]
#define merchant_nameFont [UIFont systemFontOfSize:16]
#define bottonFont [UIFont systemFontOfSize:14]
#define distanceFont [UIFont systemFontOfSize:14]
#define priceFont1 [UIFont systemFontOfSize:18]
#define table_num_countFont [UIFont systemFontOfSize:12]
#define taocan_label_font [UIFont systemFontOfSize:15]




@class MerchantModel;
@interface FDTopicMerchantListFram : NSObject
@property (nonatomic, strong) MerchantModel *status;

/** 图片 */
@property (nonatomic, assign) CGRect big_imageF;
@property (nonatomic, assign) CGRect image_newF;
/** 描述，半透明 */
@property (nonatomic, assign) CGRect describe_viewF;
/** 描述文字 */
@property (nonatomic, assign) CGRect describe_LabelF;
/** 几人桌 */
@property (nonatomic, assign) CGRect table_num_countF;
/** logo图 */
@property (nonatomic, assign) CGRect iconF;
/** 餐厅名称 */
@property (nonatomic, assign) CGRect merchant_nameF;
/** 特色 */
@property (nonatomic, assign) CGRect foodF;
/** 已有 */
@property (nonatomic, assign) CGRect yiyouF;
/** 已有人数 */
@property (nonatomic, assign) CGRect yiyou_peopleF;
/** 人预定 */
@property (nonatomic, assign) CGRect people_yudingF;
/** 剩余 */
@property (nonatomic, assign) CGRect remainingF;
/** 剩余人数 */
@property (nonatomic, assign) CGRect remaining_peopleF;
/** 个空位 */
@property (nonatomic, assign) CGRect people_kongweiF;
/** 单价 */
@property (nonatomic, assign) CGRect priceF;

@property (nonatomic, assign) CGRect lineF;
/** 餐厅距离 */
@property (nonatomic, assign) CGRect distanceF;
/** 距离图  */
@property (nonatomic, assign) CGRect distance_imageF;
/** 热门 */
@property (nonatomic, assign) CGRect hotF;
/** 新上 */
@property (nonatomic, assign) CGRect isNewF;
/** 餐厅订满 */
@property (nonatomic, assign) CGRect dingmanImageF;
/** 每人 */
@property (nonatomic, assign) CGRect meirenF;
/** 底部view */
@property (nonatomic, assign) CGRect bottonViewF;
@property (nonatomic, assign) CGRect xian_baozhuoF;

/** 底部view */
@property (nonatomic, assign) CGRect gap_viewF;

/** 套餐view */
@property (nonatomic, assign) CGRect taocan_viewF;
/** 图1  */
@property (nonatomic, assign) CGRect bao_image1F;
/** 图2 */
@property (nonatomic, assign) CGRect bao_image2F;
/** 新1  */
@property (nonatomic, assign) CGRect xin_image1F;
/** 新2 */
@property (nonatomic, assign) CGRect xin_image2F;
/** 套餐1 */
@property (nonatomic, assign) CGRect taocan_label1F;
/** 套餐2 */
@property (nonatomic, assign) CGRect taocan_label2F;

@property (nonatomic, assign) CGRect starF;


/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
