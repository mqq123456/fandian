//
//  ReqUserMessageDelModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqUserMessageDelModel : NSObject

///用户唯一标识
@property (nonatomic,copy)NSString *kid;

///系统产生的消息ID（非友盟）,如果有多个则用英文逗号隔开，形如：1,222,134,57676
@property (nonatomic ,copy)NSString *ids;

@end
