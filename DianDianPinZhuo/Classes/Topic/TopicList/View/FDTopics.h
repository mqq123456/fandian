//
//  FDTopics.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDTopics : NSObject<NSCoding>
/**	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *topic_id;

/**	人物的头像 */
@property (nonatomic, copy) NSString *person_img;
@property (nonatomic, copy) NSString *kid;
/**	人物的昵称 */
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *kdate_desc;
@property (strong,nonatomic) NSString *meal_desc;

/**	对人物昵称的描述（和昵称拼接） */
@property (nonatomic, copy) NSString *nickname_desc;
/**	商户名称 */
@property (nonatomic, copy) NSString *merchant_name;
/**	商户ID */
@property (nonatomic, copy) NSString *merchant_id;
/**	商户地址 */
@property (nonatomic, copy) NSString *address;
/**	话题是否免费 */
@property (nonatomic, assign) int is_free;

/** 话题内容 */
@property (nonatomic, strong) NSString *content;

/** 距离 */
@property (nonatomic, strong) NSString *distance;
/** 开餐时间 */
@property (nonatomic, strong) NSString *meal_time;
/** 开餐时间的描述 */
@property (nonatomic, strong) NSString *meal_date;
/** 桌子编号 */
@property (nonatomic, strong) NSString *table_id;
/** 餐桌名称 */
@property (nonatomic, strong) NSString *table_name;
/** 餐桌人数 */
@property (nonatomic, strong) NSString *table_num;
/** 餐厅是否有剩余拼桌 */
@property (nonatomic, strong) NSString *table_desc;
///** 时间 */
@property (nonatomic, strong) NSString *time;
///**	图片 */
@property (nonatomic, copy) NSString *image;
/**	预定的人数 */
@property (nonatomic, assign) int ordermeal_num;
/**	剩余空位 */
@property (nonatomic, assign) int sheng_yu;
/**	评论数量 */
@property (nonatomic, assign) int comment_num;
/** 对评论的描述 */
@property (nonatomic, strong) NSString *comment_desc;
/** 一个话题的跟随关键词（跟随他） */
@property (nonatomic, strong) NSString *topic_keyword;

@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *is_order;

@property (nonatomic, strong) NSString *people;

@property (nonatomic, copy) NSString *free_price;
@property (nonatomic, copy) NSString *seat_desc;
@property (nonatomic, copy) NSString *free_people;

@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *is_finished;
/**
 *  是否最后一个未结束的，1是0否
 */
@property (nonatomic, copy) NSString *last_unfinished;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *sex;


@property (nonatomic, strong) NSMutableArray *users_img;
///话题分享标题
@property (nonatomic, copy) NSString *weixin_topic_title;
///话题分享副标题
@property (nonatomic, copy) NSString *weixin_topic_content;
///话题分享url
@property (nonatomic, copy) NSString *weixin_topic_url;


@end
