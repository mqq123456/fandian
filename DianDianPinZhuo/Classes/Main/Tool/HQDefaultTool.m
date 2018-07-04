//
//  HQDefaultTool.m
//  normandy
//
//  Created by rongdong on 15/6/10.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import "HQDefaultTool.h"
#import "HQConst.h"
#import "HQMD5Tool.h"

@implementation HQDefaultTool

+(NSString *)getKid
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"kid"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"kid"];
    }
}

+(void)setKid:(NSString *) kid
{
    if (kid!=nil && [kid length]==32) {
        [[NSUserDefaults standardUserDefaults] setObject:kid forKey:@"kid"];
    }
}

+(void)destroyKid
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"kid"];
}

+(BOOL)isKid
{
    if ([[self getKid] isEqualToString:@""]) {
        return FALSE;
    }else{
        return TRUE;
    }
}

+(NSString *)getUuid
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"]) {
        NSString *uuid=[[UIDevice currentDevice] identifierForVendor].UUIDString;
        uuid=[HQMD5Tool md5:[NSString stringWithFormat:@"%@%ld",uuid,time(nil)]];
        [self setUuid:uuid];
        return uuid;
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
    }
}

+(void)setUuid:(NSString *) uuid
{
    if (uuid!=nil && [uuid length]==32) {
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"uuid"];
    }
}

+(void)destroyUuid
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"uuid"];
}

+(BOOL)isUuid
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"]) {
        return FALSE;
    }else{
        return TRUE;
    }
}
////

+(NSString *)getKey
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"key"]) {
        return @"";//
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    }
}

+(void)setKey:(NSString *)key
{
    if (key!=nil && [key length]==16) {
        [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"key"];
    }
}


+(NSString *)getAge
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"age"]) {
        return @"";//
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"age"];
    }
}

+(void)setAge:(NSString *)age
{
    if (age!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:age forKey:@"age"];
    }
}
+(NSString *)getHometown
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"hometown"]) {
        return @"";//
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"hometown"];
    }
}
+(void)setHometown:(NSString *)hometown{
    if (hometown!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:hometown forKey:@"hometown"];
    }

}
+(NSString *)getConstellation
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"constellation"]) {
        return @"";//
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"constellation"];
    }
}
+(void)setConstellation:(NSString *)constellation{
    if (constellation!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:constellation forKey:@"constellation"];
    }
    
}

+(NSString *)getConstellation_index
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"constellation_index"]) {
        return @"";//
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"constellation_index"];
    }
}
+(void)setConstellation_index:(NSString *)constellation_index{
    if (constellation_index!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:constellation_index forKey:@"constellation_index"];
    }
    
}
+(NSString *)getCompany
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"company"]) {
        return @"";//
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"company"];
    }
}
+(void)setCompany:(NSString *)company{
    if (company!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:company forKey:@"company"];
    }
    
}
+(NSString *)getOffice_build
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"office_build"]) {
        return @"";//
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"office_build"];
    }
}
+(void)setOffice_build:(NSString *)office_build{
    if (office_build!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:office_build forKey:@"office_build"];
    }
    
}
+(NSString *)getSelf_desc
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"self_desc"]) {
        return @"";//
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"self_desc"];
    }
}
+(void)setSelf_desc:(NSString *)self_desc{
    if (self_desc!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:self_desc forKey:@"self_desc"];
    }
    
}
+(void)destroyKey
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"key"];
}

+(BOOL)isKey
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"key"]) {
        return FALSE;
    }else{
        return TRUE;
    }
}

////
+(NSString *)getBrith
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"brith"]) {
        return @"未设置";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"brith"];
    }
}

+(void)setBrith:(NSString *)brith
{
    if (brith!=nil && ![brith isEqualToString:@"未设置"]) {
        [[NSUserDefaults standardUserDefaults] setObject:brith forKey:@"brith"];
    }
}

+(NSString *)getHead
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"head"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"head"];
    }
}

+(void)setHead:(NSString *)head
{
    if (head!=nil && ![head isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:head forKey:@"head"];
    }
}


+(NSString *)getNickName{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"nick_name"]) {
        return @"点击登录";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"nick_name"];
    }
    
}
+(void)setNickName:(NSString *)nick_name{
    if (nick_name!=nil && ![nick_name isEqualToString:@"点击登录"]) {
        [[NSUserDefaults standardUserDefaults] setObject:nick_name forKey:@"nick_name"];
    }
}

+(NSString *)getSex{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"sex"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
    }
    
}
+(void)setSex:(NSString *)sex{
    if (sex!=nil && ![sex isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:sex forKey:@"sex"];
    }
}


+(NSString *)getIndustry{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"industry"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"industry"];
    }
}
+(void)setIndustry:(NSString *)industry{
    if (industry!=nil && ![industry isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:industry forKey:@"industry"];
    }
}
+(NSString *)getOccupation{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"occupation"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"occupation"];
    }
}
+(void)setOccupation:(NSString *)occupation{
    if (occupation!=nil && ![occupation isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:occupation forKey:@"occupation"];
    }
}
+(NSString *)getPhone{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    }
    
}
+(void)setPhone:(NSString *)phone{
    if (phone!=nil && ![phone isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    }
    
}



+(NSString *)getMeal_time{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"meal_time"]) {
        return @"12:00,12:45";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"meal_time"];
    }
    
}
+(void)setMeal_time:(NSString *)meal_time{
    if (meal_time!=nil && ![meal_time isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:meal_time forKey:@"meal_time"];
    }
}

+(NSString *)getDown_url{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"down_url"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"down_url"];
    }
}
+(void)setDown_url:(NSString *)down_url{
    if (down_url!=nil && ![down_url isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:down_url forKey:@"down_url"];
    }
}

+(NSString *)getService{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"service"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"service"];
    }
}
+(void)setService:(NSString *)service{
    if (service!=nil && ![service isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:service forKey:@"service"];
    }
}

+(NSString *)getInvite_url{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"invite_url"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"invite_url"];
    }
}
+(void)setInvite_url:(NSString *)invite_url{
    if (invite_url!=nil && ![invite_url isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:invite_url forKey:@"invite_url"];
    }
}

+(NSString *)getDevice_token{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"];
    }
    
}
+(void)setDevice_token:(NSString *)device_token{
    if (device_token!=nil && ![device_token isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:device_token forKey:@"device_token"];
    }
}

+(NSString *)agreement_url{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"agreement_url"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"agreement_url"];
    }
    
}
+(void)setAgreement_url:(NSString *)agreement_url{
    if (agreement_url!=nil && ![agreement_url isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:agreement_url forKey:@"agreement_url"];
    }
}


+(NSMutableArray *)getIndustris{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"industris"]) {
        return nil;
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"industris"];
    }
    
}
+(void)setIndusties:(NSMutableArray *)industris{
    
    [[NSUserDefaults standardUserDefaults] setObject:industris forKey:@"industris"];
    
}

+(NSMutableArray *)getAds{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"ads"]) {
        return nil;
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"ads"];
    }
    
}
+(void)setAds:(NSMutableArray *)ads{
    [[NSUserDefaults standardUserDefaults] setObject:ads forKey:@"ads"];
    
}

+(NSString *)getOrder_timeout{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"order_timeout"]) {
        return @"180";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"order_timeout"];
    }
}
+(void)setOrder_timeout:(NSString *)order_timeout{
    if (order_timeout!=nil && ![[NSString stringWithFormat:@"%@",order_timeout] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:order_timeout forKey:@"order_timeout"];
    }
    
}

+(NSString *)getSearchCount{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"searchCount"]) {
        return @"0";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"searchCount"];
    }
}
+(void)setSearchCount:(NSString *)searchCount{
    if (searchCount!=nil && ![[NSString stringWithFormat:@"%@",searchCount] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:searchCount forKey:@"searchCount"];
    }
    
}

+(NSString *)getFrist{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"first"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"first"];
    }
}
+(void)setFirst:(NSString *)first{
    if (first!=nil && ![[NSString stringWithFormat:@"%@",first] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:first forKey:@"first"];
    }
}

+(NSString *)getVerUrl{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"verUrl"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"verUrl"];
    }
}
+(void)setVerUrl:(NSString *)ver{
    if (ver!=nil && ![[NSString stringWithFormat:@"%@",ver] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:ver forKey:@"verUrl"];
    }
}

+(NSMutableArray *)getOrder_tips{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"order_tips"]) {
        return nil;
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"order_tips"];
    }
}
+(void)setOrder_tips:(NSMutableArray *)order_tips{
    [[NSUserDefaults standardUserDefaults] setObject:order_tips forKey:@"order_tips"];
}
+(NSMutableArray *)getTopic_tips{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"topic_tips"]) {
        return nil;
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"topic_tips"];
    }
}
+(void)setTopic_tips:(NSMutableArray *)topic_tips{
    [[NSUserDefaults standardUserDefaults] setObject:topic_tips forKey:@"topic_tips"];
}
///红包
+(NSString *)getBage_url{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"bag_url"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"bag_url"];
    }
    
}
+(void)setBage_url:(NSString *)url{
    if (url!=nil && ![[NSString stringWithFormat:@"%@",url] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"bag_url"];
    }
    
}

//+(NSString *)getPeople{
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"people"]) {
//        return @"";
//    }else{
//        return [[NSUserDefaults standardUserDefaults] objectForKey:@"people"];
//    }
//}
//+(void)setPeople:(NSString *)people{
//    if (people!=nil && ![[NSString stringWithFormat:@"%@",people] isEqualToString:@""]) {
//        [[NSUserDefaults standardUserDefaults] setObject:people forKey:@"people"];
//    }
//}
//
+(NSString *)getAddress{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"address"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
    }
}
+(void)setAddress:(NSString *)address{
    if (address!=nil && ![[NSString stringWithFormat:@"%@",address] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"address"];
    }
}

+(NSString *)getLat{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"lat"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"];
    }
}
+(void)setLat:(NSString *)lat{
    if (lat!=nil && ![[NSString stringWithFormat:@"%@",lat] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:lat forKey:@"lat"];
    }
}

+(NSString *)getLng{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"lng"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"lng"];
    }
}
+(void)setLng:(NSString *)lng{
    if (lng!=nil && ![[NSString stringWithFormat:@"%@",lng] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:lng forKey:@"lng"];
    }
}
+(void)setIm_passWord:(NSString *)im_password{
    if (im_password!=nil && ![im_password isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:im_password forKey:@"im_password"];
    }
}

+(NSString *)getIm_passWord{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"im_password"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"im_password"];
    }
}

+(NSMutableArray *)getSeckill_order_tips{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"seckill_order_tips"]) {
        return nil;
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"seckill_order_tips"];
    }
}
+(void)setSeckill_order_tips:(NSMutableArray *)seckill_order_tips{
    [[NSUserDefaults standardUserDefaults] setObject:seckill_order_tips forKey:@"seckill_order_tips"];
}




+(void)setVoucher_qa_url:(NSString *)voucher_qa_url{
    if (voucher_qa_url!=nil && ![voucher_qa_url isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:voucher_qa_url forKey:@"voucher_qa_url"];
    }
}

+(NSString *)getVoucher_qa_url{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"voucher_qa_url"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"voucher_qa_url"];
    }
}

+(NSString *)getApp_invite_url{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"app_invite_url"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"app_invite_url"];
    }
}
+(void)setApp_invite_url:(NSString *)app_invite_url{
    if (app_invite_url!=nil && ![[NSString stringWithFormat:@"%@",app_invite_url] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:app_invite_url forKey:@"app_invite_url"];
    }
}

+(NSString *)getWeixin_invite_url{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"weixin_invite_url"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"weixin_invite_url"];
    }
}
+(void)setWeixin_invite_url:(NSString *)weixin_invite_url{
    if (weixin_invite_url!=nil && ![[NSString stringWithFormat:@"%@",weixin_invite_url] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:weixin_invite_url forKey:@"weixin_invite_url"];
    }
}

+(NSString *)getWeixin_invite_title{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"weixin_invite_title"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"weixin_invite_title"];
    }
}
+(void)setWeixin_invite_title:(NSString *)weixin_invite_title{
    if (weixin_invite_title!=nil && ![[NSString stringWithFormat:@"%@",weixin_invite_title] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:weixin_invite_title forKey:@"weixin_invite_title"];
    }
}

+(NSString *)getWeixin_invite_content{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"weixin_invite_content"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"weixin_invite_content"];
    }
}
+(void)setWeixin_invite_content:(NSString *)weixin_invite_content{
    if (weixin_invite_content!=nil && ![[NSString stringWithFormat:@"%@",weixin_invite_content] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:weixin_invite_content forKey:@"weixin_invite_content"];
    }
}

+(NSString *)getRegistrationID{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"registrationID"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"registrationID"];
    }
}
+(void)setRegistrationID:(NSString *)registrationID{
    if (registrationID!=nil && ![[NSString stringWithFormat:@"%@",registrationID] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
    }
}

+(NSString *)getGrowup_point{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"growup_point"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"growup_point"];
    }
}
+(void)setGrowup_point:(NSString *)growup_point{
    if (growup_point!=nil && ![[NSString stringWithFormat:@"%@",growup_point] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:growup_point forKey:@"growup_point"];
    }
}

+(NSString *)getIntegral_point{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"integral_point"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"integral_point"];
    }
}
+(void)setIntegral_point:(NSString *)integral_point{
    if (integral_point!=nil && ![[NSString stringWithFormat:@"%@",integral_point] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:integral_point forKey:@"integral_point"];
    }
}
+(NSString *)getVoucher_count{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"voucher_count"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"voucher_count"];
    }
}
+(void)setVoucher_count:(NSString *)voucher_count{
    if (voucher_count!=nil && ![[NSString stringWithFormat:@"%@",voucher_count] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:voucher_count forKey:@"voucher_count"];
    }
}


+(NSString *)getOrderSum{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"orderSum"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"orderSum"];
    }
}
+(void)setOrderSum:(NSString *)orderSum{
    if (orderSum!=nil && ![[NSString stringWithFormat:@"%@",orderSum] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:orderSum forKey:@"orderSum"];
    }
}





+(NSString *)getHometown_hint{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"hometown_hint"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"hometown_hint"];
    }
}
+(void)setHometown_hint:(NSString *)hometown_hint{
    if (hometown_hint!=nil && ![[NSString stringWithFormat:@"%@",hometown_hint] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:hometown_hint forKey:@"hometown_hint"];
    }
}
+(NSString *)getOccupation_hint{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"occupation_hint"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"occupation_hint"];
    }
}
+(void)setOccupation_hint:(NSString *)occupation_hint{
    if (occupation_hint!=nil && ![[NSString stringWithFormat:@"%@",occupation_hint] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:occupation_hint forKey:@"occupation_hint"];
    }
}


+(NSString *)getAges_hint{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"ages_hint"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"ages_hint"];
    }
}
+(void)setAges_hint:(NSString *)ages_hint{
    if (ages_hint!=nil && ![[NSString stringWithFormat:@"%@",ages_hint] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:ages_hint forKey:@"ages_hint"];
    }
}


+(NSString *)getCompany_hint{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"company_hint"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"company_hint"];
    }
}
+(void)setCompany_hint:(NSString *)company_hint{
    if (company_hint!=nil && ![[NSString stringWithFormat:@"%@",company_hint] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:company_hint forKey:@"company_hint"];
    }
}

+(NSString *)getConstellation_hint{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"constellation_hint"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"constellation_hint"];
    }
}
+(void)setConstellation_hint:(NSString *)constellation_hint{
    if (constellation_hint!=nil && ![[NSString stringWithFormat:@"%@",constellation_hint] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:constellation_hint forKey:@"constellation_hint"];
    }
}




+(NSString *)getHometown_default{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"hometown_default"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"hometown_default"];
    }
}
+(void)setHometown_default:(NSString *)hometown_default{
    if (hometown_default!=nil && ![[NSString stringWithFormat:@"%@",hometown_default] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:hometown_default forKey:@"hometown_default"];
    }
}
+(NSString *)getOccupation_default{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"occupation_default"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"occupation_default"];
    }
}
+(void)setOccupation_default:(NSString *)occupation_default{
    if (occupation_default!=nil && ![[NSString stringWithFormat:@"%@",occupation_default] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:occupation_default forKey:@"occupation_default"];
    }
}


+(NSString *)getAges_default{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"ages_default"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"ages_default"];
    }
}
+(void)setAges_default:(NSString *)ages_default{
    if (ages_default!=nil && ![[NSString stringWithFormat:@"%@",ages_default] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:ages_default forKey:@"ages_default"];
    }
}


+(NSString *)getCompany_default{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"company_default"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"company_default"];
    }
}
+(void)setCompany_default:(NSString *)company_default{
    if (company_default!=nil && ![[NSString stringWithFormat:@"%@",company_default] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:company_default forKey:@"company_default"];
    }
}

+(NSString *)getConstellation_default{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"constellation_default"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"constellation_default"];
    }
}
+(void)setConstellation_default:(NSString *)constellation_default{
    if (constellation_default!=nil && ![[NSString stringWithFormat:@"%@",constellation_default] isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:constellation_default forKey:@"constellation_default"];
    }
}

+(NSString *)getStart_img{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"start_img"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"start_img"];
    }
}
+(void)setStart_img:(NSString *)start_img{
    if (start_img!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:start_img forKey:@"start_img"];
    }
}

+(NSString *)getStart_url{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"start_url"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"start_url"];
    }
}
+(void)setStart_url:(NSString *)start_url{
    if (start_url!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:start_url forKey:@"start_url"];
    }
}

+(NSString *)getStart_h5_title{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"start_h5_title"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"start_h5_title"];
    }
}
+(void)setStart_h5_title:(NSString *)start_h5_title{
    if (start_h5_title!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:start_h5_title forKey:@"start_h5_title"];
    }
}

+(NSString *)getStart_expire_time{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"start_expire_time"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"start_expire_time"];
    }
}
+(void)setStart_expire_time:(NSString *)start_expire_time{
    if (start_expire_time!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:start_expire_time forKey:@"start_expire_time"];
    }
}


///提前预定提示标题

+(NSString *)getAdvanced_order_tips_title{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"advanced_order_tips_title"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"advanced_order_tips_title"];
    }
}
+(void)setAdvanced_order_tips_title:(NSString *)advanced_order_tips_title{
    
    if (advanced_order_tips_title!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:advanced_order_tips_title forKey:@"advanced_order_tips_title"];
    }
}

///提前预定提示，点击问号显示

+(NSString *)getAdvanced_order_tips_content{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"advanced_order_tips_content"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"advanced_order_tips_content"];
    }
}
+(void)setAdvanced_order_tips_content:(NSString *)advanced_order_tips_content{

    if (advanced_order_tips_content!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:advanced_order_tips_content forKey:@"advanced_order_tips_content"];
    }
}

//群组公告

+(NSString *)getGroups_notice{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"groups_notice"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"groups_notice"];
    }

}
+(void)setGroups_notice:(NSString *)groups_notice{
    if (groups_notice!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:groups_notice forKey:@"groups_notice"];
    }
}



///资料是否齐全，1是0否
+(NSString *)getComplete_info{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"complete_info"]) {
        return @"";
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"complete_info"];
    }
}
+(void)setComplete_info:(NSString *)complete_info{
    if (complete_info!=nil) {
        [[NSUserDefaults standardUserDefaults] setObject:complete_info forKey:@"complete_info"];
    }
}

@end
