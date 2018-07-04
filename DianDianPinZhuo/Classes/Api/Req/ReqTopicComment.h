//
//  ReqTopicComment.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqTopicComment : NSObject
@property (strong,nonatomic) NSString *kid;
@property (strong,nonatomic) NSString *reply_kid;
@property (strong,nonatomic) NSString *topic_id;
@property (strong,nonatomic) NSString *content;


@end
