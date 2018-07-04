//
//  KdateModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KdateModel : NSObject

///开餐日期
@property (strong,nonatomic) NSString *kdate;

///开餐描述
@property (strong,nonatomic) NSString *kdate_desc;

@property (strong,nonatomic) NSMutableArray *meals;

@end
