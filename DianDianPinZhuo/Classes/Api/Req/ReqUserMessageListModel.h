//
//  ReqUserMessageListModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqUserMessageListModel : NSObject

///用户唯一标识
@property (nonatomic,copy)NSString *kid;

///页码ID，默认1
@property int page;
@end
