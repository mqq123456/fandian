//
//  IndustriesModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  行业

#import <Foundation/Foundation.h>

@interface IndustriesModel : NSObject
///行业ID
@property (strong,nonatomic) NSString *industry_id;
///行业名称
@property (strong,nonatomic) NSString *industry_name;

+ (instancetype)industriesWithDict:(NSDictionary *)dict;
@end
