//
//  PeopleModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleModel : NSObject
///拼桌人数
@property (strong,nonatomic) NSString *people;

///拼桌人数描述，如“1人拼桌”
@property (strong,nonatomic) NSString *desc;
@end
