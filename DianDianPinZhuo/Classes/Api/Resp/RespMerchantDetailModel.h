//
//  RespMerchantDetailModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//	拼桌详情接口返回

#import "RespBaseModel.h"
#import "MerchantModel.h"
@interface RespMerchantDetailModel : RespBaseModel

@property (nonatomic,strong) NSMutableArray *comments;//CommentModel
@property (nonatomic,strong) NSMutableArray *menus;//MenuModel

@property (nonatomic,strong) NSMutableArray *imgs;//ImagesModel

@property (nonatomic,strong) NSMutableArray *small_imgs;//ImagesModel


@property (nonatomic,strong) NSMutableArray *small_menus;//MenuModel

@property (nonatomic,copy) NSString *clean_plate_hint;//光盘行动提示
@property (nonatomic,copy) NSString *small_menu_hint;//环保菜单提示，如“查看环保菜单”
@property (nonatomic,copy) NSString *small_menu_title;//小菜单标题，如“精选菜单”


///已订满的提示，对应上面状态3
@property (nonatomic , copy)NSString * soldout_hint;
///餐厅未开餐餐点已过的提示，对应上面状态4
@property (nonatomic , copy)NSString * meal_time_end_hint;
///已过期时段的提示，对应上面状态2
@property (nonatomic , copy)NSString * meal_time_expired_hint;
///剩余座位数
@property (nonatomic,copy) NSString *left_seat;
@property (nonatomic,strong) NSMutableArray *kdates;
@property (nonatomic,strong) NSMutableArray *seats;
@property (nonatomic,strong) NSMutableArray *menus_copy;
@property (nonatomic,strong) NSMutableArray *friend_hint;

@property (nonatomic,copy) NSString *people_hint;
@property (nonatomic,copy) NSString *pz_menu_id;
@property (nonatomic,copy) NSString *comment_num;
@property (nonatomic , strong)MerchantModel * merchant;
@property (nonatomic,copy) NSString *is_western_restaurant;

@property (nonatomic,copy) NSString *WeChat_friends_share_title;
@property (nonatomic,copy) NSString *WeChat_friends_share_text;
@property (nonatomic,copy) NSString *WeChat_friends_circle_share_title;
@property (nonatomic,copy) NSString *group_share_title;
@property (nonatomic,copy) NSString *group_share_hint;

@end
