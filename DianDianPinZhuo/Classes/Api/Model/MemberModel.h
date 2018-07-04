//
//  MemberModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject

///用户唯一标识
@property(nonatomic,copy)NSString *kid;
///用户呢称
@property(nonatomic,copy)NSString *nick_name;
///用户头像地址
@property(nonatomic,copy)NSString *icon;
///用户头像地址
@property(nonatomic,copy)NSString *img;
///订单人数
@property(nonatomic,copy)NSString *people;
///职业
@property(nonatomic,copy)NSString *occupation;

@end

