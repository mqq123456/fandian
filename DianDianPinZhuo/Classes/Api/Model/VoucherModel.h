//
//  VoucherModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  优惠券

#import <Foundation/Foundation.h>

@interface VoucherModel : NSObject
///订单ID
@property int voucher_id;

///名称
@property (strong,nonatomic) NSString *voucher_name;

///来源：系统赠送
@property (strong,nonatomic) NSString *voucher_source;

///价值金钱
@property (strong,nonatomic) NSString *cash;

///超时时间
@property (strong,nonatomic) NSString *expire_time;
@property (strong,nonatomic) NSString *most_discount_cash;
///图片地址
@property (strong,nonatomic) NSString *img;

///人数
@property (strong,nonatomic) NSString *people;

///限制条件，这是一个字符串数组，{’’条件一’,’’条件二’,’’条件三’}，有几个显示几个
@property (nonatomic ,strong) NSMutableArray *limits;

///优先使用：0否，1是
@property (strong,nonatomic) NSString *first_use;
@property (strong,nonatomic) NSString *voucher_type;
@property (strong,nonatomic) NSString *discount;
@end
