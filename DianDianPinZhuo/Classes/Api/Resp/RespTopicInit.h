//
//  RespTopicInit.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespTopicInit : RespBaseModel

@property (nonatomic ,copy) NSString *is_today_finished;   //今日是否已截止，1是0否
@property (nonatomic ,copy) NSString *today_finished_hint;  //今日已截止文案提示
@property (nonatomic ,copy) NSString *default_topic_title; //默认话题标题
@end
