//
//  RespMerchantCommentDetail.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/16.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"
#import "CommentModel.h"

@interface RespMerchantCommentDetail : RespBaseModel
@property (nonatomic , copy) CommentModel *comment;//CommentModel

@property (nonatomic , copy) NSString *merchant_name;     //商家名称
@property (nonatomic , copy) NSString *merchant_id;       //商家ID
@property (nonatomic , copy) NSString *icon;              //商家图片
@property (nonatomic , copy) NSString *price;             //单价，每人多少元
@property (nonatomic , copy) NSString *price_desc;        //单价描述: 元/人
@property (nonatomic , copy) NSString *region_area;       //区域 如朝阳
@property (nonatomic , copy) NSString *district;          //地区 如望京东
@property (nonatomic , copy) NSString *distance;          //距离多少米

@property (nonatomic , copy) NSString *WeChat_share_title;            //微信分享标题
@property (nonatomic , copy) NSString *WeChat_share_text;         //微信分享内容
@property (nonatomic , copy) NSString *WeChat_share_icon;         //微信分享ICON

@property (nonatomic , copy) NSString *group_share_title;         //群组分享标题
@property (nonatomic , copy) NSString *group_share_hint;          //群组分享动作，如立刻查看
@end
