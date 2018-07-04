//
//  AreaModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject
///省
@property(nonatomic,copy)NSString *province;
///市
@property(nonatomic,copy)NSString *city;
///区
@property(nonatomic,copy)NSString *district;

@end
