//
//  RespImGroupIdModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//2.5.1	群组ID接口

#import "RespBaseModel.h"

@interface RespImGroupIdModel : RespBaseModel

///群组ID，如果为0则表示没有讨论组（包桌或该桌仅一人）
@property(nonatomic,copy)NSString *group_id;
///群组名
@property(nonatomic,copy)NSString *group_name;

@end
