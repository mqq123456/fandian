//
//  ReqUserGrowupPointModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//成长值接口

#import <Foundation/Foundation.h>

@interface ReqUserGrowupPointModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
@property (nonatomic) int page;
@end
