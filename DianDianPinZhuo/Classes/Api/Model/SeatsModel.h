//
//  SeatsModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeatsModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *seat_num;
///用户呢称
@property (strong,nonatomic) NSString *seat_desc;
///用户头像地址
@property (strong,nonatomic) NSString *seat_state;

@end
