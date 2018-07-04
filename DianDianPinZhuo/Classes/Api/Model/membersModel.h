//
//  membersModel.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/2/1.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface membersModel : NSObject
///普通饭票－用户唯一标识
@property(nonatomic,copy) NSString * kid;
///普通饭票－用户呢称
@property(nonatomic,copy) NSString *nick_name;
///普通饭票－用户头像地址
@property(nonatomic,copy) NSString *icon;
///普通饭票－订单人数
@property(nonatomic,copy) NSString *people;
///普通饭票－行业
@property(nonatomic,copy) NSString *industry;
///普通饭票－职业
@property(nonatomic,copy) NSString *occupation;
///普通饭票－自我描述
@property(nonatomic,copy) NSString *self_desc;

///普通饭票－行业
@property(nonatomic,copy) NSString *company;
///普通饭票－职业
@property(nonatomic,copy) NSString *age;
///普通饭票－自我描述
@property(nonatomic,copy) NSString *sex;



///话题饭票-用户呢称
@property(nonatomic,copy) NSString *nickname;
///话题饭票-用户头像地址
@property(nonatomic,copy) NSString *img;
///话题饭票-自我描述
@property(nonatomic,copy) NSString *myself_desc;
@end
