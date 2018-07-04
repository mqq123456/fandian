//
//  RespImGroupDetailModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//2.5.2	群组详情接口

#import "RespBaseModel.h"

@interface RespImGroupDetailModel : RespBaseModel

///MemberModel
@property (nonatomic,strong) NSMutableArray *members;

@end
