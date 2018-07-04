//
//  FDOrderListFrame.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/7.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 时间字体
#define merchant_name_font [UIFont systemFontOfSize:15]
// 来源字体
#define time_font [UIFont systemFontOfSize:14]

#define state_font [UIFont systemFontOfSize:14]

#define people_num_font [UIFont systemFontOfSize:14]

#define btn_font [UIFont systemFontOfSize:13]

@class OrderModel;
@interface FDOrderListFrame : NSObject

@property (nonatomic, strong) OrderModel *status;

/**	时间 */
@property (nonatomic, assign) CGRect timeF;
/**	状态 */
@property (nonatomic, assign) CGRect stateF;
/**  */
@property (nonatomic, assign) CGRect content_viewF;
/**	头像 */
@property (nonatomic, assign) CGRect iconF;
/** 餐厅名称 */
@property (nonatomic, assign) CGRect merchant_nameF;
/** 就餐人数 */
@property (nonatomic, assign) CGRect people_numF;
/** 再吃一次 */
@property (nonatomic, assign) CGRect again_btnF;
/** 只有一个btn，有可能是去支付，退款，评价送积分 */
@property (nonatomic, assign) CGRect only_btnF;

@property (nonatomic, assign) CGFloat cellHeight;

@end
