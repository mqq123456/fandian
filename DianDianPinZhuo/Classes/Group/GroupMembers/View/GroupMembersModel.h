//
//  GroupMembersModel.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMembersModel : NSObject

@property (nonatomic, copy) NSString *kid;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *industry;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *age;
@property (strong,nonatomic) NSString *sex;
@property (nonatomic, strong) NSString *office_build;

@end
