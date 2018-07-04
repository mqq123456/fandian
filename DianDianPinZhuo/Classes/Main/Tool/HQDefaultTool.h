//
//  HQDefaultTool.h
//  normandy
//
//  Created by rongdong on 15/6/10.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface HQDefaultTool : NSObject

//Kid是登录后的用户唯一标识号
+(NSString *)getKid;
+(void)setKid:(NSString *)kid;
+(void)destroyKid;
+(BOOL)isKid;

//app第一次启动时产生的客户端唯一标识号
+(NSString *)getUuid;
+(void)setUuid:(NSString *)uuid;
+(void)destroyUuid;
+(BOOL)isUuid;

//app启动时通过UUID去服务器拿到人加密key,用于接口数据加解密
+(NSString *)getKey;
+(void)setKey:(NSString *)key;
+(void)destroyKey;
+(BOOL)isKey;


+(NSString *)getNickName;
+(void)setNickName:(NSString *)nick_name;

+(NSString *)getSex;
+(void)setSex:(NSString *)sex;

+(NSString *)getAge;
+(void)setAge:(NSString *)age;

+(NSString *)getHometown;
+(void)setHometown:(NSString *)hometown;

+(NSString *)getBrith;
+(void)setBrith:(NSString *)brith;

+(NSString *)getIndustry;
+(void)setIndustry:(NSString *)industry;

+(NSString *)getHead;
+(void)setHead:(NSString *)head;

+(NSString *)getPhone;
+(void)setPhone:(NSString *)phone;

+(NSString *)getMeal_time;
+(void)setMeal_time:(NSString *)meal_time;

+(NSString *)getDown_url;
+(void)setDown_url:(NSString *)down_url;

+(NSString *)getService;
+(void)setService:(NSString *)service;

+(NSString *)getInvite_url;
+(void)setInvite_url:(NSString *)invite_url;

+(NSString *)getDevice_token;
+(void)setDevice_token:(NSString *)device_token;

+(NSMutableArray *)getIndustris;
+(void)setIndusties:(NSMutableArray *)industris;

+(NSString *)agreement_url;
+(void)setAgreement_url:(NSString *)agreement_url;

+(NSMutableArray *)getAds;
+(void)setAds:(NSMutableArray *)ads;
+(NSString *)getOffice_build;
+(void)setOffice_build:(NSString *)office_build;
+(NSString *)getCompany;
+(void)setCompany:(NSString *)company;
+(NSString *)getConstellation;
+(void)setConstellation:(NSString *)constellation;

+(NSString *)getConstellation_index;
+(void)setConstellation_index:(NSString *)constellation_index;

+(NSString *)getOrder_timeout;
+(void)setOrder_timeout:(NSString *)order_timeout;

+(NSString *)getSearchCount;
+(void)setSearchCount:(NSString *)searchCount;

+(NSString *)getFrist;
+(void)setFirst:(NSString *)first;

+(NSString *)getVerUrl;
+(void)setVerUrl:(NSString *)ver;


+(NSMutableArray *)getOrder_tips;
+(void)setOrder_tips:(NSMutableArray *)order_tips;

///红包
+(NSString *)getBage_url;
+(void)setBage_url:(NSString *)url;


+(NSString *)getAddress;
+(void)setAddress:(NSString *)address;

+(NSString *)getLat;
+(void)setLat:(NSString *)lat;

+(NSString *)getLng;
+(void)setLng:(NSString *)lng;

+(void)setIm_passWord:(NSString *)im_password;
+(NSString *)getIm_passWord;

+(void)setSeckill_order_tips:(NSMutableArray *)seckill_order_tips;
+(NSMutableArray *)getSeckill_order_tips;

+(void)setVoucher_qa_url:(NSString *)voucher_qa_url;
+(NSString *)getVoucher_qa_url;

//+(NSMutableArray *)getHomeAds;
//+(void)setHomeAds:(NSMutableArray *)ads;

+(NSString *)getApp_invite_url;
+(void)setApp_invite_url:(NSString *)app_invite_url;

+(NSString *)getWeixin_invite_url;
+(void)setWeixin_invite_url:(NSString *)weixin_invite_url;

+(NSString *)getWeixin_invite_title;
+(void)setWeixin_invite_title:(NSString *)weixin_invite_title;

+(NSString *)getWeixin_invite_content;
+(void)setWeixin_invite_content:(NSString *)weixin_invite_content;

+(NSString *)getRegistrationID;
+(void)setRegistrationID:(NSString *)registrationID;

+(NSString *)getGrowup_point;
+(void)setGrowup_point:(NSString *)growup_point;
+(NSString *)getIntegral_point;
+(void)setIntegral_point:(NSString *)integral_point;
+(NSString *)getVoucher_count;
+(void)setVoucher_count:(NSString *)voucher_count;
+(NSString *)getOrderSum;
+(void)setOrderSum:(NSString *)orderSum;

+(NSString *)getOccupation;
+(void)setOccupation:(NSString *)occupation;

+(NSString *)getHometown_hint;
+(void)setHometown_hint:(NSString *)hometown_hint;
+(NSString *)getOccupation_hint;
+(void)setOccupation_hint:(NSString *)occupation_hint;

+(NSString *)getAges_hint;
+(void)setAges_hint:(NSString *)ages_hint;

+(NSString *)getCompany_hint;
+(void)setCompany_hint:(NSString *)company_hint;

+(NSString *)getConstellation_hint;
+(void)setConstellation_hint:(NSString *)constellation_hint;





+(NSString *)getHometown_default;
+(void)setHometown_default:(NSString *)hometown_default;
+(NSString *)getOccupation_default;
+(void)setOccupation_default:(NSString *)occupation_default;


+(NSString *)getAges_default;
+(void)setAges_default:(NSString *)ages_default;


+(NSString *)getCompany_default;
+(void)setCompany_default:(NSString *)company_default;

+(NSString *)getConstellation_default;
+(void)setConstellation_default:(NSString *)constellation_default;

+(NSString *)getComplete_info;
+(void)setComplete_info:(NSString *)complete_info;


+(NSString *)getStart_img;
+(void)setStart_img:(NSString *)start_img;

+(NSString *)getStart_url;
+(void)setStart_url:(NSString *)start_url;

+(NSString *)getStart_h5_title;
+(void)setStart_h5_title:(NSString *)start_h5_title;

+(NSString *)getStart_expire_time;
+(void)setStart_expire_time:(NSString *)start_expire_time;

+(NSMutableArray *)getTopic_tips;
+(void)setTopic_tips:(NSMutableArray *)topic_tips;

///提前预定提示标题
+(NSString *)getAdvanced_order_tips_title;
+(void)setAdvanced_order_tips_title:(NSString *)advanced_order_tips_title;
///提前预定提示，点击问号显示

+(NSString *)getAdvanced_order_tips_content;
+(void)setAdvanced_order_tips_content:(NSString *)advanced_order_tips_content;

//群组公告

+(NSString *)getGroups_notice;
+(void)setGroups_notice:(NSString *)groups_notice;


+(NSString *)getSelf_desc;
+(void)setSelf_desc:(NSString *)self_desc;

@end