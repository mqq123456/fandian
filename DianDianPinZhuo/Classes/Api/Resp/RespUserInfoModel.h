//
//  RespUserInfoModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"
#import "UserModel.h"
@interface RespUserInfoModel : RespBaseModel
@property (nonatomic ,strong) UserModel *user;
@end
