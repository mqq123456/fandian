//
//  ReqUserUpdateDevice.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqUserUpdateDevice : NSObject
///用户帐号:手机号
@property (strong,nonatomic) NSString *kid;
///友盟生成的device码，用于友盟发通知
@property (strong,nonatomic) NSString *device_token;
@property (strong,nonatomic) NSString *cver;
@property (strong,nonatomic) NSString *imei;
@property (strong,nonatomic) NSString *platform;
///渠道：请找产品经理要
@property (strong,nonatomic) NSString *channel;

@end
