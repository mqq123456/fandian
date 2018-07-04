//
//  ReqUserPushNotifyModel.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqUserPushNotifyModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///push的标识，通过极光push的push_id参数获取
@property (strong,nonatomic) NSString *push_id;

@end
