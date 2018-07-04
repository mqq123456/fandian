//
//  ApiProtocol.h
//  normandyHD
//
//  Created by user on 15/7/8.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>

//总
NSString static *const API_HTTP=@"http://";

///测试环境
//NSString static *const API_HOST= @"pin.fundot.com.cn/";

///预发环境
//NSString static *const API_HOST= @"pin-pre.fundot.com.cn/";

///正式环境
NSString static *const API_HOST= @"pin2.fundot.com.cn/";

NSString static *const API_VERSION=@"user/v4";

///加密串请求接口
NSString static *const API_BASE_APPKEY=@"/base_appkey";

///图片上传接口
NSString static *const API_BASE_IMAGE_UPLOAD=@"/base_image_upload";

///Loading接口
NSString static *const API_BASE_LOADING=@"/base_loading";

///版本检查接口
NSString static *const API_BASE_VERSION=@"/base_version";

///获取手机验证码接口
NSString static *const API_BASE_GET_CODE=@"/base_get_code";

///2.2	用户模块

///用户登陆接口
NSString static *const API_USER_LOGIN=@"/user_login";

///订单详情接口
NSString static *const API_USER_ORDER_DETAIL = @"/user_order_detail";

///拼桌记录列表接口
NSString static *const API_USER_ORDER_LIST=@"/user_order_list";

///修改个人资料接口
NSString static *const API_USER_EDIT=@"/user_edit";

//优惠券列表接口
NSString static *const API_USER_VOUCHER_LIST=@"/user_voucher_list";

///预订接口
NSString static *const API_USER_MESSAGE_LIST=@"/user_message_list";

///订单详情
NSString static *const API_USER_MESSAGE_READ=@"/user_message_read";

///生长值接口
NSString static *const API_USER_GROWUP_POINT=@"/user_growup_point";

///user_banner_notify
NSString static *const API_USER_PUSH_NOTIFY=@"/user_push_notify";
NSString static *const API_USER_BANNER_NOTIFY=@"/user_banner_notify";
NSString static *const API_USER_AD_NOTIFY=@"/user_ad_notify";

///用户退出登录接口
NSString static *const API_USER_LOGOUT=@"/user_logout";

NSString static *const API_USER_FRIEND_DELETE=@"/user_friend_delete";

///消息删除接口
NSString static *const API_USER_MESSAGE_DEL=@"/user_message_del";

///兑换邀请码
NSString static *const API_USER_EXCHANGE_VOUCHER=@"/user_exchange_voucher";

//2.3	商户模块

///拼桌搜索接口
NSString static *const API_MERCHANT_SEARCH=@"/merchant_search";


///话题商家列表
NSString static *const API_TOPIC_MERCHANT_SEARCH=@"/topic_merchant_search";

///拼桌详情接口
NSString static *const API_MERCHANT_DETAIL=@"/merchant_detail";

///评论商户接口
NSString static *const API_MERCHANT_COMMENT=@"/merchant_comment";

///评论列表接口
NSString static *const API_MERCHANT_COMMENT_LIST=@"/merchant_comment_list";

///常用评论列表接口
NSString static *const API_MERCHANT_COMMON_COMMENT=@"/merchant_common_comment";

///秒杀商家列表接口
NSString static *const API_MERCHANT_SECKILL_LIST=@"/merchant_seckill_list";

///秒杀商家详情接口
NSString static *const API_MERCHANT_SECKILL_DETAIL=@"/merchant_seckill_detail";


//2.4	订单、支付模块
///预订接口
NSString static *const API_ORDER_BOOK=@"/order_book";

///确认使用优惠券接口
NSString static *const API_ORDER_VOUCHER_USE=@"/order_voucher_use";

///获取支付签名接口
NSString static *const API_ORDER_PAY_SIGN=@"/order_pay_sign";

///取消订单接口
NSString static *const API_ORDER_CANCEL=@"/order_cancel";

///支付结果接口
NSString static *const API_ORDER_PAY_RESULT=@"/order_pay_result";

///根据订单获取菜单接口
NSString static *const API_ORDER_MENU=@"/order_menu";
///添加饭票个人描述接口
NSString static *const API_ORDER_SELF_DESC=@"/order_self_desc";


///2.5 IM模块

///群组ID接口
NSString static *const API_IM_GROUP_ID=@"/im_group_id";

///群组详情接口
NSString static *const API_IM_GROUP_DETAIL=@"/im_group_detail";

///查询同桌群组成员
NSString static *const API_IM_GROUP_MEMBERS=@"/im_group_members";

///	IM用户详情接口
NSString static *const API_IM_USER_DETAIL=@"/im_user_detail";

///群组icon接口
NSString static *const API_IM_GROUP_ICON=@"/im_group_icon";

///需要登录，用于向好友发送Push，不存储好友关系
NSString static *const API_IM_FRIEND_ADD=@"/im_friend_add";


///2.6发票

///查询默认发票接口
NSString static *const API_INVOICE_DEFAULT=@"/invoice_default";

///新增发票
NSString static *const API_INVOICE_ADD=@"/invoice_add";

///发票历史接口接口
NSString static *const API_INVOICE_HISTORY=@"/invoice_history";
///退出群组
NSString static *const API_IM_GROUP_EXIT=@"/im_group_exit";

///秒杀预订接口
NSString static *const API_ORDER_SECKILL_BOOK=@"/order_seckill_book";

///广告查看接口
NSString static *const API_BASE_ADS=@"/base_ads";

NSString static *const API_USER_INFO = @"/user_info";

///积分明细
NSString static *const API_INTEGRAL_POINT =@"/user_integral_point";
NSString static *const API_USER_INTEGRAL_DEDUCTION = @"/user_integral_deduction";
NSString static *const API_USER_INDUSTRY_CATGEGORY=@"/user_industry_category";

//查询环信好友
NSString static *const API_USER_KID=@"/user_kid";

///积分明细
NSString static *const API_TOPIC_SEARCH =@"/topic_search";

NSString static *const API_TOPIC_DETAIL=@"/topic_detail";

//查询环信好友
NSString static *const API_TOPIC_SPONSOR=@"/topic_sponsor";

NSString static *const API_TOPIC_JOIN=@"/topic_join";

NSString static *const API_TOPIC_ORDER_DETAIL=@"/topic_order_detail";

NSString static *const API_TOPIC_PERSONAL_DESCRIBE=@"/topic_personal_describe";

NSString static *const API_ORDER_DISCOUNT_INFO =@"/order_discount_info";
NSString static *const API_TOPIC_COMMENT=@"/topic_comment";

NSString static *const API_BASE_START_PAGE_CONFIGURE=@"/base_start_page_configure";


NSString static *const API_TOPIC_DELETE_COMMENT = @"/topic_delete_comment";


NSString static *const API_USER_WEIXIN_CHECK = @"/user_weixin_check";


NSString static *const API_USER_GET_VOUCHER = @"/user_get_voucher";

NSString static *const API_TOPIC_INIT = @"/topic_init";

NSString static *const API_IM_USER_GROUP_LIST =@"/im_user_group_list";
NSString static *const API_IM_TOPIC_GROUP_LIST =@"/im_topic_group_list";
NSString static *const API_IM_RECOMMEND_GROUP_LIST =@"/im_recommend_group_list";

NSString static *const API_IM_GROUP_MEMBER_INFOS =@"/im_group_member_infos";

NSString static *const API_IM_JOIN_GROUP =@"/im_join_group";

NSString static *const API_USER_UPDATE_DEVICE =@"/user_update_device";

NSString static *const API_MERCHANT_COMMENT_DETAIL = @"/merchant_comment_detail";


@protocol ApiProtocol <NSObject>


@end