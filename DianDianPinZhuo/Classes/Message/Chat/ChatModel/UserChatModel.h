//
//  UserModel.h
//  meilizhiyue
//
//  Created by zhou on 15/5/25.
//  Copyright (c) 2015年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserChatModel : NSObject
/** 生日 */
@property (nonatomic, copy) NSString *birthday;
/** 城市 */
@property (nonatomic, assign) int city;
/** 国家 */
@property (nonatomic, assign) int country;
/** 省份 */
@property (nonatomic, assign) int province;
/** 性别 */
@property (nonatomic, assign) int gender;
/** 城市汉字 */
@property (nonatomic, copy) NSString *cityname;
/** 身高 */
@property (nonatomic, copy) NSString *height;
/** 手机号/登录号 */
@property (nonatomic, copy) NSString *username;
/** id */
@property (nonatomic, assign) int idCode;
/** 纬度 */
@property (nonatomic, copy) NSString *lat;
/** 经度 */
@property (nonatomic, copy) NSString *lon;
/** 昵称 */
@property (nonatomic, copy) NSString *nickname;
/** 头像 */
@property (nonatomic, copy) NSString *photo;
/** 单身状态 */
@property (nonatomic, assign) int single_state;
/** 用户编号 */
@property (nonatomic, assign) int userid;
/** 详细信息值 */
@property (nonatomic, copy) NSString *vcard;
/** 体重*/
@property (nonatomic, copy) NSString *weight;
/** 年龄 */
@property (nonatomic, assign) NSNumber *age;
/** 星座 */
@property (nonatomic, copy) NSString *constellation;
/** 是否关注*/
@property (nonatomic, assign) int rosterstatus;


@end
