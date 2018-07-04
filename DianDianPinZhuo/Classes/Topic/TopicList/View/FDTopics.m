//
//  FDTopics.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopics.h"

@implementation FDTopics
/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.topic_id forKey:@"topic_id"];
    [encoder encodeObject:self.person_img forKey:@"person_img"];
    [encoder encodeObject:self.kid forKey:@"kid"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.kdate_desc forKey:@"kdate_desc"];
    [encoder encodeObject:self.meal_desc forKey:@"meal_desc"];
    [encoder encodeObject:self.nickname_desc forKey:@"nickname_desc"];
    [encoder encodeObject:self.merchant_name forKey:@"merchant_name"];
    [encoder encodeObject:self.merchant_id forKey:@"merchant_id"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",self.is_free] forKey:@"is_free"];
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.distance forKey:@"distance"];
    [encoder encodeObject:self.meal_time forKey:@"meal_time"];
    [encoder encodeObject:self.table_id forKey:@"table_id"];
    [encoder encodeObject:self.table_name forKey:@"table_name"];
    [encoder encodeObject:self.meal_date forKey:@"meal_date"];
    [encoder encodeObject:self.table_num forKey:@"table_num"];
    [encoder encodeObject:self.table_desc forKey:@"table_desc"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.image forKey:@"image"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",self.ordermeal_num] forKey:@"ordermeal_num"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",self.sheng_yu] forKey:@"sheng_yu"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",self.comment_num] forKey:@"comment_num"];
    [encoder encodeObject:self.comment_desc forKey:@"comment_desc"];
    
    [encoder encodeObject:self.topic_keyword forKey:@"topic_keyword"];
    [encoder encodeObject:self.star forKey:@"star"];
    [encoder encodeObject:self.is_order forKey:@"is_order"];
    [encoder encodeObject:self.people forKey:@"people"];
    [encoder encodeObject:self.free_price forKey:@"free_price"];
    [encoder encodeObject:self.seat_desc forKey:@"seat_desc"];
    [encoder encodeObject:self.free_people forKey:@"free_people"];
    [encoder encodeObject:self.state forKey:@"state"];
    [encoder encodeObject:self.is_finished forKey:@"is_finished"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.topic_id = [decoder decodeObjectForKey:@"topic_id"];
        self.person_img = [decoder decodeObjectForKey:@"person_img"];
        self.kid = [decoder decodeObjectForKey:@"kid"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.kdate_desc = [decoder decodeObjectForKey:@"kdate_desc"];
        self.meal_desc = [decoder decodeObjectForKey:@"meal_desc"];
        self.nickname_desc = [decoder decodeObjectForKey:@"nickname_desc"];
        self.merchant_name = [decoder decodeObjectForKey:@"merchant_name"];
        self.merchant_id = [decoder decodeObjectForKey:@"merchant_id"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.is_free = [[decoder decodeObjectForKey:@"is_free"] intValue];
        self.content = [decoder decodeObjectForKey:@"content"];
        self.distance = [decoder decodeObjectForKey:@"distance"];
        self.meal_time = [decoder decodeObjectForKey:@"meal_time"];
        self.meal_date = [decoder decodeObjectForKey:@"meal_date"];
        self.table_id = [decoder decodeObjectForKey:@"table_id"];
        self.table_name = [decoder decodeObjectForKey:@"table_name"];
        self.table_num = [decoder decodeObjectForKey:@"table_num"];
        self.table_desc = [decoder decodeObjectForKey:@"table_desc"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.image = [decoder decodeObjectForKey:@"image"];
        self.ordermeal_num = [[decoder decodeObjectForKey:@"ordermeal_num"] intValue];
        self.sheng_yu = [[decoder decodeObjectForKey:@"sheng_yu"] intValue];
        self.comment_num = [[decoder decodeObjectForKey:@"comment_num"] intValue];
        self.comment_desc = [decoder decodeObjectForKey:@"comment_desc"];
        self.topic_keyword = [decoder decodeObjectForKey:@"topic_keyword"];
        self.star = [decoder decodeObjectForKey:@"star"];
        self.is_order = [decoder decodeObjectForKey:@"is_order"];
        self.people = [decoder decodeObjectForKey:@"people"];
        self.free_price = [decoder decodeObjectForKey:@"free_price"];
        self.seat_desc = [decoder decodeObjectForKey:@"seat_desc"];
        self.free_people = [decoder decodeObjectForKey:@"free_people"];
        self.state = [decoder decodeObjectForKey:@"state"];
        self.is_finished = [decoder decodeObjectForKey:@"is_finished"];
       
    }
    return self;
}
@end
