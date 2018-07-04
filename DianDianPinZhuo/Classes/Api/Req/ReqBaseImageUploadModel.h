//
//  ReqBaseImageUploadModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  图片上传

#import <Foundation/Foundation.h>

@interface ReqBaseImageUploadModel : NSObject
///用户标识号
@property (strong,nonatomic) NSString *kid;
///客户端的唯一标识码
@property int uuid;
///图片的二进制数据，需要BASE64编码
@property (strong,nonatomic) NSString *img;

@end
