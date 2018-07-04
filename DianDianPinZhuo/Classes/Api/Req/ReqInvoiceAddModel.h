//
//  ReqInvoiceAddModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//2.6.2	新增发票接口

#import <Foundation/Foundation.h>

@interface ReqInvoiceAddModel : NSObject
///用户唯一标识
@property(nonatomic,copy)NSString *kid;
///可开发票金额
@property(nonatomic,copy)NSString *invoice_amount;
///发票抬头
@property(nonatomic,copy)NSString *invoice_title;
///收件人
@property(nonatomic,copy)NSString *invoice_receiver;
///收件人电话
@property(nonatomic,copy)NSString *invoice_phone;
///收件人详细地址
@property(nonatomic,copy)NSString *invoice_address;
///省
@property(nonatomic,copy)NSString *invoice_province;
///市
@property(nonatomic,copy)NSString *invoice_city;
///区
@property(nonatomic,copy)NSString *invoice_district;

@end
