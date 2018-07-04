//
//  InvoicesModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvoicesModel : NSObject
///发票金额
@property(nonatomic,copy)NSString *amount;
///创建时间
@property(nonatomic,copy)NSString *create_time;
///发票状态，0待开票，1已开票
@property(nonatomic,copy)NSString *state;

@end
