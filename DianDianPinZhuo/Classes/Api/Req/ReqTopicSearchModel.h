//
//  ReqTopicSearchModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqTopicSearchModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///用户上传的图片
@property (strong,nonatomic) NSString *lng;
///用户是否要请大家吃饭（0 是，1 否）
@property (strong,nonatomic) NSString *lat;
///开餐时间ID:(loading接口获取为准)
@property (assign,nonatomic) int page;
///开餐日期：(loading接口获取为准)
@property (strong,nonatomic) NSString *class_id;
@end
