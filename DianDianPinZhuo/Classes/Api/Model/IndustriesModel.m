
//
//  IndustriesModel.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  行业

#import "IndustriesModel.h"

@implementation IndustriesModel
+ (instancetype)industriesWithDict:(NSDictionary *)dict
{
    IndustriesModel *industry = [[self alloc] init];
    industry.industry_id = dict[@"industry_id"];
    industry.industry_name = dict[@"industry_name"];

    return industry;
}

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.industry_id forKey:@"industry_id"];
    [encoder encodeObject:self.industry_name forKey:@"industry_name"];

}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.industry_id = [decoder decodeObjectForKey:@"industry_id"];
        self.industry_name = [decoder decodeObjectForKey:@"industry_name"];
    }
    return self;
}

@end
