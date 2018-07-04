//
//  RespImUserDetailModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespImUserDetailModel : RespBaseModel
///用户呢称
@property (nonatomic,strong) NSString *nick_name;
///用户头像地址
@property (nonatomic,strong) NSString *icon;
///用户唯一标识，便于安卓封装对象
@property (nonatomic,strong) NSString *kid;
@end
