//
//  ReqBaseLoadingModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  Loading

#import <Foundation/Foundation.h>

@interface ReqBaseLoadingModel : NSObject
///平台类型0:ios,1:android
@property (strong,nonatomic) NSString *platform;
///设备型号
@property (strong,nonatomic) NSString *ua;
///设备品牌
@property (strong,nonatomic) NSString *brand;
///设备IMEI
@property (strong,nonatomic) NSString *imei;

@property (strong,nonatomic) NSString *fbl;

///
@property (strong,nonatomic) NSString *ver;

///应用版本号
@property (strong,nonatomic) NSString *cver;

///渠道
@property (strong,nonatomic) NSString *channel;

///数据版本号
@property (strong,nonatomic) NSString *dver;

///友盟生成的device码，用于友盟发通知
@property (strong,nonatomic) NSString *device_token;

///用户登录后获取到的kid，没登录的置空
@property (strong,nonatomic) NSString *kid;

@property (strong,nonatomic) NSString *local_lng;

@property (strong,nonatomic) NSString *local_lat;

@end
