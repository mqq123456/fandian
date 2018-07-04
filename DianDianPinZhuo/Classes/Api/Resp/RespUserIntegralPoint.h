//
//  RespUserIntegralPoint.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"
#import "DetailsDefray.h"
#import "DetailsIncome.h"
@interface RespUserIntegralPoint : RespBaseModel
///总积分数值
@property (nonatomic ,strong) NSString *point;
///
@property (nonatomic,strong) NSMutableArray *incomeArray;
@property (nonatomic,strong) NSMutableArray *defrayArray;
@end
