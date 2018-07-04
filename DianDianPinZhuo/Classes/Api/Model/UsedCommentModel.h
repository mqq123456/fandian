//
//  UsedCommentModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/8/24.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsedCommentModel : NSObject

///常用评论ID
@property (strong,nonatomic) NSString *cc_id;
///评论内容
@property (strong,nonatomic) NSString *content;
///所属星级：1-5星
@property (strong,nonatomic) NSString *star;

@end
