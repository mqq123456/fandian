//
//  ReqBaseAppkeyModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  加密串请求

#import <Foundation/Foundation.h>

@interface ReqBaseAppkeyModel : NSObject
///客户端的唯一标识码
@property (strong,nonatomic) NSString *uuid;
///设备系统平台，0:IOS  1:Android
@property (strong,nonatomic) NSString *plat;
///手机型号
@property (strong,nonatomic) NSString *ua;
///手机品牌
@property (strong,nonatomic) NSString *brand;
///IMEI码
@property (strong,nonatomic) NSString *imei;
///分辨率
@property (strong,nonatomic) NSString *fbl;
///操作系统版本号
@property (strong,nonatomic) NSString *ver;
///应用版本号
@property (strong,nonatomic) NSString *cver;
///渠道
@property (strong,nonatomic) NSString *channel;
///数据版本号
@property (strong,nonatomic) NSString *dver;
@end
