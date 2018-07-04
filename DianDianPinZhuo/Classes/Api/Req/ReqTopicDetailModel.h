//
//  ReqTopicDetailModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqTopicDetailModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;

@property (nonatomic ,copy) NSString *topic_id;
@property (nonatomic ,copy) NSString *lat;

@property (nonatomic ,copy) NSString *lng;

@end
