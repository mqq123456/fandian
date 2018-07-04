//
//  RespBaseImageUploadModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  上传头像接口返回

#import "RespBaseModel.h"

@interface RespBaseImageUploadModel : RespBaseModel
///相片ID
@property int pic_id;
///上传图片的URL地址
@property (strong,nonatomic) NSString *url;

@end
