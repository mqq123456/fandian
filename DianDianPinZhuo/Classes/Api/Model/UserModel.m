//
//  UserModel.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  用户

#import "UserModel.h"

@implementation UserModel
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    UserModel *userModel=[[UserModel alloc]init];
    userModel.kid=dict[@"kid"];
    userModel.nick_name=dict[@"nick_name"];
    userModel.head=dict[@"head"];
    userModel.sex=dict[@"sex"];
    userModel.phone=dict[@"phone"];
    userModel.ages=dict[@"ages"];
    userModel.industry=dict[@"industry"];
    userModel.occupation=dict[@"occupation"];
    userModel.hometown=dict[@"hometown"];
    userModel.im_password = dict[@"im_password"];
    
    userModel.constellation=dict[@"constellation"];
    userModel.company=dict[@"company"];
    userModel.office_build = dict[@"office_build"];
    return userModel;
}

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.kid forKey:@"kid"];
    [encoder encodeObject:self.nick_name forKey:@"nick_name"];
    [encoder encodeObject:self.head forKey:@"head"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.ages forKey:@"ages"];
    [encoder encodeObject:self.industry forKey:@"industry"];
    [encoder encodeObject:self.occupation forKey:@"occupation"];
    [encoder encodeObject:self.hometown forKey:@"hometown"];
    [encoder encodeObject:self.im_password forKey:@"im_password"];
    
    [encoder encodeObject:self.constellation forKey:@"constellation"];
    [encoder encodeObject:self.office_build forKey:@"office_build"];
    [encoder encodeObject:self.company forKey:@"company"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.kid = [decoder decodeObjectForKey:@"kid"];
        self.nick_name = [decoder decodeObjectForKey:@"nick_name"];
        self.head = [decoder decodeObjectForKey:@"head"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.ages = [decoder decodeObjectForKey:@"ages"];
        self.industry = [decoder decodeObjectForKey:@"industry"];
        self.occupation = [decoder decodeObjectForKey:@"occupation"];
        self.hometown = [decoder decodeObjectForKey:@"hometown"];
        self.im_password = [decoder decodeObjectForKey:@"im_password"];
        self.company = [decoder decodeObjectForKey:@"company"];
        self.office_build = [decoder decodeObjectForKey:@"office_build"];
        self.constellation = [decoder decodeObjectForKey:@"constellation"];
    }
    return self;
}

@end