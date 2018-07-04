//
//  TablesModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TablesModel : NSObject

///桌号，如：1
@property (strong,nonatomic) NSString *table_no;

///桌名描述，如：号桌
@property (strong,nonatomic) NSString *table_desc;

///人数，如3
@property (strong,nonatomic) NSString *table_people;
///总下单用户人数
@property (strong,nonatomic) NSString *total_order_people;
///共8人
@property (strong,nonatomic) NSString *total_people_desc;
///桌子id，用于请求进入群组
@property (strong,nonatomic) NSString *table_id;
@property (strong,nonatomic) NSString *total_people;
@property (strong,nonatomic) NSMutableArray *members;///membersModel
///讨论组ID，没有则为0
@property (strong,nonatomic) NSString *group_id;

@property (strong,nonatomic) NSString *group_name;
/**
 *  每一桌内的空位数，待用
 */
@property (strong,nonatomic) NSString *empty_seat;

@end
