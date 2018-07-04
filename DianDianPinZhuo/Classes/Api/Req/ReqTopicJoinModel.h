//
//  ReqTopicJoinModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqTopicJoinModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///用户发起的话题内容
@property (strong,nonatomic) NSString *topic_id;

@property (strong,nonatomic) NSString *is_eat;
///选择的话题人数
@property (strong,nonatomic) NSString *people;

@end
