//
//  RespUserGrowupPointModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespUserGrowupPointModel : RespBaseModel
///成长值icon
@property (nonatomic,strong) NSString *icon;
///成长值
@property (nonatomic,strong) NSString *point;
///成长提示，如“成长奖励，敬请期待”
@property (nonatomic,strong) NSString *hint;
///
@property (nonatomic,strong) NSMutableArray *details;//GrowUpDetailModel

@end
