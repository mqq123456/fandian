//
//  RespImGroupMemberInfos.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespImGroupMemberInfos : RespBaseModel
@property (nonatomic , strong) NSMutableArray *members;
@property (nonatomic , copy) NSString *notice;
@property (nonatomic , copy) NSString *members_count;

@end
