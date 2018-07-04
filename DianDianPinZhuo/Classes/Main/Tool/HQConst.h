//
//  HQConst.h
//  DianDianPinZhuo
//
//  Created by user on 15/8/20.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobClick.h"
#import "FDUtils.h"


#ifdef DEBUG//处于开发阶段
#define MQQLog(...) NSLog(__VA_ARGS__)
#else//处于发布阶段
#define MQQLog(...)
#endif



//设置
#define APP_VERSION @"2.2.1"//应用版本号

#define APP_DATA_VERSION @"2.2.1"//数据版本号

#define APP_PLAT @"0"//平台IOS

#define APP_CHANNEL @"appStore"//渠道名称

#define WXPAY_URL @"pay/appweixin"


/**  iphone4 */
#define IPHONE4 ([UIScreen mainScreen].bounds.size.height == 480 ? YES : NO)
/**  iphone5 */
#define IPHONE5 ([UIScreen mainScreen].bounds.size.height == 568 ? YES : NO)
/**  iphone6 */
#define IPhone6 ([UIScreen mainScreen].bounds.size.height == 667 ? YES : NO)
/** iphone6P */
#define IPhone6Plus ([UIScreen mainScreen].bounds.size.height == 736 ? YES : NO)

// 颜色
#define FDColor(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 随机色
//#define FDRandomColor LGColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255),7)

#define FDButtonColor [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//主色调
#define MainColor [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//背景色
#define Background_Color [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1]
////定义10个颜色
//#define Color1 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color2 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color3 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color4 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color5 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color6 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color7 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color8 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color9 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//#define Color10 [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1]
//
//#define textFont1 [UIFont systemFontOfSize:14]
//#define textFont2 [UIFont systemFontOfSize:14]
//#define textFont3 [UIFont systemFontOfSize:14]
//#define textFont4 [UIFont systemFontOfSize:14]
//#define textFont5 [UIFont systemFontOfSize:14]
//#define textFont6 [UIFont systemFontOfSize:14]
//#define textFont7 [UIFont systemFontOfSize:14]
//#define textFont8 [UIFont systemFontOfSize:14]


// 屏幕宽度
#define ScreenW [UIScreen mainScreen].bounds.size.width

// 屏幕高度
#define ScreenH [UIScreen mainScreen].bounds.size.height

// 登录状态
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"


#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0&&[[UIDevice currentDevice].systemVersion doubleValue]<8.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)


///支付成功
extern NSString * const PayOrderBackNotification;
///支付失败
extern NSString * const PaySuccFlag;
///重新loading
extern NSString * const ReloadLoading;
///修改时间
extern NSString * const ModifyTheTime;
///修改人数
extern NSString * const ModifyThePeople;
///评价完成刷新详情页
extern NSString * const RefreshDetailViewController;
/** 隐藏新消息提醒 */
extern NSString * const HiddenNewMessageRemind;
/** 隐藏主页进入饭票 */
extern NSString * const HiddenHomeBottomTicketView;
/** 重新定位 */
extern NSString * const Reposition;
/** 刷新消息列表 */
extern NSString * const RefreshFDMessageViewController;
/** 刷新订单列表 */
extern NSString * const RefreshOrderListViewController;
/** 修改个人信息 */
extern NSString * const ModifyUserInfo;

extern NSString * const TopicSponsorSelectMerchantBack;
extern NSString * const TopicSponsorSelectMerchantPeopleBack;
extern NSString * const DescriptionMySelf;

extern NSString * const PayFailOrScuessReloadHome;

extern NSString * const HomeAds;

extern NSString * const Html5PoPHome;

extern NSString * const loadingBack;
extern NSString * const firstScrollNumber;
extern NSString * const setupUntreatedApplyCount;
extern NSString * const deleteMyFriend;
extern NSString * const GetLocation;
extern NSString * const locationback;
extern NSString * const ExitGroup;
extern NSString * const HomeTicket;
extern NSString * const refreshCell;
extern NSString * const joinSuccess;
extern NSString * const joinFailed;
extern NSString * const reloadUserEdit;
extern NSString * const userInfoLogin;
extern NSString * const JoinInOrOutGroup;
