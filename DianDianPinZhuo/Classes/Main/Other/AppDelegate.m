//
//  AppDelegate.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/21.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "AppDelegate.h"
#import "HQConst.h"
#import "MobClick.h"
#import "AlixPayResult.h"
#import <AlipaySDK/AlipaySDK.h>
#import <objc/runtime.h>
#import "HQLoadTool.h"
#import "HQDefaultTool.h"
#import "SVProgressHUD.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UIPopoverListView.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "IQKeyboardManager.h"
#import "PayFail.h"
#import "HWNewfeatureViewController.h"
#import "FDEvaluationViewController.h"
#import "AppDelegate+EaseMob.h"

#import "APService.h"
#import "ChatViewController.h"
#import "HQIMFriendsTool.h"
#import "FDGroupDetailTool.h"
#import "FDWebViewController.h"
#import "HttpUserPushNotify.h"
#import "FDHomeViewController.h"
#import "BBLaunchAdMonitor.h"
#import "Reachability.h"
#import "FDSubjectDetailViewController.h"
#import "FDMerchantDetailController.h"

@interface AppDelegate ()
{
    int retry;
    UINavigationController *nav;
    UIViewController *pushViewController;
    BOOL isInBackground;
    
}
@property (nonatomic ,strong)NSMutableDictionary *noDict;
@property (nonatomic ,weak) UIPopoverListView *popoverListView;
@property (nonatomic, strong) Reachability *conn;
@end

@implementation AppDelegate
@synthesize nav;

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    MQQLog(@"Failed to get token, error:%@", error_str);
    
}
- (void)showAdDetail:(NSNotification *)noti
{
    
    if (![[HQDefaultTool getStart_url]isEqualToString:@""]) {
        FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
        webView.url = [HQDefaultTool getStart_url];
        webView.titleString = [HQDefaultTool getStart_h5_title];
        [self.nav pushViewController:webView animated:YES];
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:HomeAds object:nil];
    }
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
//    self.conn = [Reachability reachabilityForInternetConnection];
//    [self.conn startNotifier];

    
    /**
     *  延迟一秒加载
     */
    //[NSThread sleepForTimeInterval:0.5];
    
    
    application.applicationIconBadgeNumber = 0;
    
    
    
    /**
     *  初始化极光消息
     */
    [self initJGPush:launchOptions];
    
    /**
     *  初始化环信SDK
     */
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    /**
     *  初始化微信
     */
    [self initWchat];
    /**
     *  初始化根控制器
     */
    [self initRootViewController];
    
    NSInteger now =  (long)[[NSDate date] timeIntervalSince1970];
    NSInteger expt = [[HQDefaultTool getStart_expire_time] integerValue];
    if (now<expt&&expt!=0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAdDetail:) name:BBLaunchAdDetailDisplayNotification object:nil];
        
        NSString *path = [HQDefaultTool getStart_img];
        [BBLaunchAdMonitor showAdAtPath:path
                                 onView:self.window.rootViewController.view
                           timeInterval:2.
                       detailParameters:launchOptions];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:HomeAds object:nil];
    }
    
    
    
    /**
     *  初始化友盟统计
     */
    [self initMobClick];
    /**
     *  初始化友盟分享
     */
    [self initUMSocial];
    /**
     *  获取appkey
     */
    retry=0;
    [self getAppkey];
    //键盘
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    if (launchOptions != nil) {
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        MQQLog(@"%@",userInfo);
        if ([userInfo[@"aps"][@"alert"] isEqualToString:@"您有一条新消息"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if(userInfo[@"g"]){
                    [self push:userInfo class:@"ChatViewController" open:YES chatter:userInfo[@"g"] group:YES];
                    
                }else{
                    
                    
                    [self push:userInfo class:@"ChatViewController" open:YES chatter:userInfo[@"f"] group:NO];
                }
                
                
            });
        }
        if (userInfo != nil&&userInfo[@"page"]) {
            
            if ([userInfo[@"page"] isEqualToString:@"message_comment"]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self push:userInfo class:@"FDEvaluationViewController" open:YES chatter:@"" group:NO];
                    
                });
            }else if ([userInfo[@"page"] isEqualToString:@"coupon"]){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self push:userInfo class:@"FDCouponsViewController" open:YES chatter:@"" group:NO];
                });
                
            }else if ([userInfo[@"page"] isEqualToString:@"message_list"]){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self push:userInfo class:@"FDMessageViewController" open:YES chatter:@"" group:NO];
                });
                
            }
            
            if ([userInfo[@"page"] isEqualToString:@"seckill"]){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    FDSecondKillViewController *secondKill = [[FDSecondKillViewController alloc] init];
//                    secondKill.meal_id = userInfo[@"param"];
//                    [nav pushViewController:secondKill animated:YES];
                    
                });
            }
            if ([userInfo[@"page"] isEqualToString:@"h5"]){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
                    webView.url = userInfo[@"param"];
                    [nav pushViewController:webView animated:YES];
                    
                });
            }
            if ([userInfo[@"page"] isEqualToString:@"invite"]){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self push:userInfo class:@"FDInvitationViewController" open:YES chatter:@"" group:NO];
                });
            }
            if ([userInfo[@"page"] isEqualToString:@"merchant_detail"]){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self push:userInfo class:@"FDMerchantDetailController" open:YES chatter:@"" group:NO];
                });
            }
            if ([userInfo[@"page"] isEqualToString:@"topic_detail"]){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self push:userInfo class:@"FDSubjectDetailViewController" open:YES chatter:@"" group:NO];
                });
            }
            if ([userInfo[@"page"] isEqualToString:@"my_message"]){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self push:userInfo class:@"ConversationListController" open:YES chatter:@"" group:NO];
                });
            }
            if (userInfo[@"push_id"]) {
                HttpUserPushNotify *userPush = [HttpUserPushNotify sharedInstance];
                [userPush loadUserPushNotifyWithPush_id:userInfo[@"push_id"]];
            }
            
            
        }
        MQQLog(@"remote notification:%@",userInfo);
    }
    
    return YES;
}

- (void)initJGPush:(NSDictionary *)launchOptions{
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //categories
        [APService
         registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert)
         categories:nil];
    } else {
        //categories nil
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
         
         categories:nil];
#else
        //categories nil
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
         
         categories:nil];
#endif
        // Required
    }
    [APService setupWithOption:launchOptions];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registrationID) name:kJPFNetworkDidLoginNotification object:nil];
    [APService resetBadge];
}
- (void)registrationID{
    
    MQQLog(@"registrationID = %@",[APService registrationID]);
    [HQDefaultTool setRegistrationID:[APService registrationID]];
    
}
#pragma mark -- 微信
- (void)initWchat
{
    BOOL WXRegisOK = [WXApi registerApp:@"wx248654a2abf7326d" withDescription:@"DianDianPinZhuo"];
    MQQLog(@"isOK = %d",WXRegisOK);
    MQQLog(@"isinstall = %d", [WXApi isWXAppInstalled]);
    MQQLog(@"sport = %d", [WXApi isWXAppSupportApi]);
}
#pragma mark - 友盟统计
- (void)initMobClick{
    
    //#ifdef DEBUG
    //
    //#else
    [MobClick startWithAppkey:@"55da8fe4e0f55a05240030cc" reportPolicy:BATCH   channelId:APP_CHANNEL];
    //version标识
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    /** 设置是否对日志信息进行加密, 默认NO(不加密). */
    [MobClick setEncryptEnabled:YES];
    
    //#endif
    
}
#pragma mark - 友盟分享
- (void)initUMSocial{
    
    [UMSocialData setAppKey:@"55da8fe4e0f55a05240030cc"];
    
    [UMSocialWechatHandler setWXAppId:@"wx248654a2abf7326d" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
}

#pragma mark - 初始化根控制器

- (void)initRootViewController{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ///Follow  第一次安装出现引导页，，，1 不出现
    if ([[defaults objectForKey:@"Follow"] isEqualToString:@"1"]) {
        FDHomeViewController *home = [[FDHomeViewController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:home];
        nav.navigationBar.tintColor = [UIColor grayColor];
        nav.navigationBar.barTintColor = [UIColor whiteColor];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                             forBarMetrics:UIBarMetricsDefault];
        self.window.rootViewController = nav;
        
        
    }else{
        
        ///引导页
        HWNewfeatureViewController *featureVC=[[HWNewfeatureViewController alloc]init];
        
        self.window.rootViewController = featureVC;
        
        
    }
    
    
}
// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *deviceTokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""];
    [HQDefaultTool setDevice_token:deviceTokenStr];
    
    MQQLog(@"deviceToken --- %@",deviceTokenStr);
    
    [APService registerDeviceToken:deviceToken];
    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

#pragma mark - 应用间跳转的回调函数
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 支付宝
    if ([sourceApplication isEqualToString:@"com.alipay.iphoneclient"] || [sourceApplication isEqualToString:@"com.alipay.safepayclient"]  ) {
        [self dealAliPayCallbackWithUrl:url];
        return YES;
    }else  if ([sourceApplication isEqualToString:@"com.tencent.xin"]) {
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            return [WXApi handleOpenURL:url delegate:self];
        }
        return YES;
    }
    else{
        return [UMSocialSnsService handleOpenURL:url];
    }
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - 支付宝的同步回调
- (void)parse:(NSURL *)url application:(UIApplication *)application
{
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    if (result){
        if (result.statusCode == 9000){ // 支付成功
            [SVProgressHUD showImage:nil status:@"支付成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:PayOrderBackNotification object:nil userInfo:@{PaySuccFlag : @(1)}];
        }else{//交易失败
            [SVProgressHUD showImage:nil status:@"支付失败"];
            [[NSNotificationCenter defaultCenter] postNotificationName:PayOrderBackNotification object:nil userInfo:@{PaySuccFlag : @(-1)}];
        }
    }else{//失败
        [SVProgressHUD showImage:nil status:@"支付失败"];
        [[NSNotificationCenter defaultCenter] postNotificationName:PayOrderBackNotification object:nil userInfo:@{PaySuccFlag : @(-1)}];
    }
}
- (AlixPayResult *)resultFromURL:(NSURL *)url {
    NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
    return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
    AlixPayResult * result = nil;
    
    if (url != nil && [[url host] compare:@"safepay"] == 0) {
        result = [self resultFromURL:url];
    }
    
    return result;
}

- (void)dealAliPayCallbackWithUrl:(NSURL*)url
{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        MQQLog(@"result = %@",resultDic);
        if (resultDic){
            if ([resultDic[@"resultStatus"]integerValue] == 9000){ // 支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:PayOrderBackNotification object:nil userInfo:@{PaySuccFlag : @(1)}];
            }else{//交易失败
                [[NSNotificationCenter defaultCenter] postNotificationName:PayOrderBackNotification object:nil userInfo:@{PaySuccFlag : @(-1)}];
            }
        }else{//失败
            [[NSNotificationCenter defaultCenter] postNotificationName:PayOrderBackNotification object:nil userInfo:@{PaySuccFlag : @(-1)}];
        }
        
    }];
}
#pragma mark - 微信的同步回调
-(void) onResp:(SendAuthResp*)resp
{
    MQQLog(@"----------微信支付的回调消息---------");
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        MQQLog(@"错误代码为:%d %@ %d",response.errCode,response.returnKey,response.type);
        switch (response.errCode) {
            case WXSuccess: {
                [[NSNotificationCenter defaultCenter] postNotificationName:PayOrderBackNotification object:nil userInfo:@{PaySuccFlag : @(1)}];
            }
                break;
            default: {
                [[NSNotificationCenter defaultCenter] postNotificationName:PayOrderBackNotification object:nil userInfo:@{PaySuccFlag : @(-1)}];
                break;
            }
        }
        
        return;
    }
    
    else if ([resp isKindOfClass:[SendAuthResp class]]){///微信授权
       SendAuthResp *response = (SendAuthResp *)resp;
        NSDictionary *dic= [[NSDictionary alloc]initWithObjectsAndKeys:response.code,@"code",nil];
        if (response.errCode ==0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bindingPhone" object:nil userInfo:dic];
        }
        
        
    }
}
#pragma mark -
-(void)getAppkey
{
    while (![HQDefaultTool isKey] && retry<3) {
        [HQLoadTool appkey];
        sleep(2);
        retry++;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    isInBackground = YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HiddenHomeBottomTicketView object:nil userInfo:nil];
    
    [application setApplicationIconBadgeNumber:0];
    
    [APService resetBadge];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        isInBackground = NO;
    });
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}
#pragma mark 接收到推送通知之后
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    MQQLog(@"userInfo = %@",userInfo);
    [APService resetBadge];
    
    if (userInfo[@"page"]!=nil) {//如果有msg_id
        
        if ([userInfo[@"page"] isEqualToString:@"message_comment"]) {
            [self push:userInfo class:@"FDEvaluationViewController" open:NO chatter:@"" group:NO];
            
        }else if ([userInfo[@"page"] isEqualToString:@"coupon"]){
            
            [self push:userInfo class:@"FDCouponsViewController" open:NO chatter:@"" group:NO];
            
        }else if ([userInfo[@"page"] isEqualToString:@"message_list"]){
            [self push:userInfo class:@"FDMessageViewController" open:NO chatter:@"" group:NO];
        }else if ([userInfo[@"page"] isEqualToString:@"h5"]){
            [self push:userInfo class:@"FDWebViewController" open:NO chatter:@"" group:NO];
        }else if ([userInfo[@"page"] isEqualToString:@"invite"]){
            [self push:userInfo class:@"FDInvitationViewController" open:NO chatter:@"" group:NO];
        }else if ([userInfo[@"page"] isEqualToString:@"merchant_detail"]){
            [self push:userInfo class:@"FDMerchantDetailController" open:NO chatter:@"" group:NO];
        }else if ([userInfo[@"page"] isEqualToString:@"topic_detail"]){
            [self push:userInfo class:@"FDSubjectDetailViewController" open:NO chatter:@"" group:NO];
        }else if ([userInfo[@"page"] isEqualToString:@"my_message"]){
            [self push:userInfo class:@"ConversationListController" open:NO chatter:@"" group:NO];
        }else if ([userInfo[@"page"] isEqualToString:@"seckill"]){
            
            [self.popoverListView dismiss];
            CGRect  tipsRect = [[NSString stringWithFormat:@"%@",userInfo[@"aps"][@"alert"]] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            
            
            CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 40.0f;
            CGFloat yHeight = 180+tipsRect.size.height;
            CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
            
            UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
            poplistview.listView.scrollEnabled = FALSE;
            poplistview.isTouchOverlayView = NO;
            [poplistview show];
            self.popoverListView = poplistview;
            self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
            PayFail *payResult = [[[NSBundle mainBundle] loadNibNamed:@"PayFail" owner:nil options:nil]lastObject];
            [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
            payResult.frame = self.popoverListView.bounds;
            payResult.title.text = @"你有新的通知";
            payResult.detail.text = userInfo[@"aps"][@"alert"];
            payResult.detail.textAlignment = NSTextAlignmentLeft;
            payResult.doneBtn.tag = [userInfo[@"param"] integerValue];
            [payResult.doneBtn addTarget:self action:@selector(secondKilldoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [payResult.cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [poplistview addSubview:payResult];
            
            
        }
        
    }
    
    [APService handleRemoteNotification:userInfo];
    
    
}
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:
//(void (^)(UIBackgroundFetchResult))completionHandler {
//
//    MQQLog(@"收到通知:%@", userInfo);
//
//    if (userInfo[@"page"]!=nil) {//如果有msg_id
//
//        if ([userInfo[@"page"] isEqualToString:@"message_comment"]) {
//            [self push:userInfo class:@"FDEvaluationViewController" open:NO];
//
//        }else if ([userInfo[@"page"] isEqualToString:@"coupon"]){
//
//            [self push:userInfo class:@"FDCouponsViewController" open:NO];
//
//        }else if ([userInfo[@"page"] isEqualToString:@"message_list"]){
//            [self push:userInfo class:@"FDMessageViewController" open:NO];
//        }else if ([userInfo[@"page"] isEqualToString:@"seckill"]){
//
//            [self.popoverListView dismiss];
//
//            CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 40.0f;
//            CGFloat yHeight = 250.0f;
//            CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
//            UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
//            poplistview.listView.scrollEnabled = FALSE;
//            poplistview.isTouchOverlayView = NO;
//            [poplistview show];
//            self.popoverListView = poplistview;
//            self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
//            PayFail *payResult = [[[NSBundle mainBundle] loadNibNamed:@"PayFail" owner:nil options:nil]lastObject];
//            [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
//            payResult.frame = self.popoverListView.bounds;
//            payResult.title.text = @"你有新的通知";
//            payResult.detail.text = userInfo[@"aps"][@"alert"];
//            payResult.doneBtn.tag = [userInfo[@"param"] integerValue];
//            [payResult.doneBtn addTarget:self action:@selector(secondKilldoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [payResult.cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
//            [poplistview addSubview:payResult];
//
//
//        }
//
//    }
//
//    [APService handleRemoteNotification:userInfo];
//
//    completionHandler(UIBackgroundFetchResultNewData);
//}
#pragma mark - 跳转到秒杀
- (void)secondKilldoneBtnClick:(UIButton *)doneBtn{
    [self.popoverListView dismiss];
//    FDSecondKillViewController *secondKill = [[FDSecondKillViewController alloc] init];
//    secondKill.meal_id = [NSString stringWithFormat:@"%zd",doneBtn.tag];
//    [nav pushViewController:secondKill animated:YES];
}
- (void)push:(NSDictionary *)params class:(NSString *)class open:(BOOL)isOpen chatter:(NSString *)chatter group:(BOOL)isGroup
{
    [self.noDict removeAllObjects];
    self.noDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    // 类名
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    NSDictionary *propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        return;
    }else{
        if (isOpen) {//如果是刚打开app
            if (self.noDict[@"push_id"]) {
                HttpUserPushNotify *userPush = [HttpUserPushNotify sharedInstance];
                [userPush loadUserPushNotifyWithPush_id:self.noDict[@"push_id"]];
            }
            if ([instance isKindOfClass:[FDMerchantDetailController class]]) {
                FDMerchantDetailController *detail = [[FDMerchantDetailController alloc] init];
                MerchantModel *model = [[MerchantModel alloc] init];
                model.merchant_id = [self.noDict[@"param"] intValue];
                detail.model = model;
                detail.latString = [HQDefaultTool getLat];
                detail.lngString = [HQDefaultTool getLng];
                detail.local_lng = [HQDefaultTool getLng];
                detail.local_lat = [HQDefaultTool getLat];
                detail.local = @"1";
                [nav pushViewController:detail animated:YES];
                return;
            }else if ([instance isKindOfClass:[FDSubjectDetailViewController class]]) {
                FDSubjectDetailViewController *detail = [[FDSubjectDetailViewController alloc] init];
                FDTopics *model = [[FDTopics alloc] init];
                model.topic_id = self.noDict[@"param"];
                detail.model = model;
                detail.latString = [HQDefaultTool getLat];
                detail.lngString = [HQDefaultTool getLng];
                detail.local_lng = [HQDefaultTool getLng];
                detail.local_lat = [HQDefaultTool getLat];
                detail.local = 1;
                detail.is_from_push = YES;
                [nav pushViewController:detail animated:YES];
                return;
            }else if ([instance isKindOfClass:[FDEvaluationViewController class]]) {
                FDEvaluationViewController *evaluation = [[FDEvaluationViewController alloc] init];
                evaluation.isFromMessage = YES;
                evaluation.order_no = self.noDict[@"param"];
                [nav pushViewController:evaluation animated:YES];
                return;
            }
            else if([instance isKindOfClass:[FDWebViewController class]]){
                FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
                webView.url = self.noDict[@"param"];
                [nav pushViewController:webView animated:YES];
                return;
            }
            else {
                if([instance isKindOfClass:[ChatViewController class]]){
                    if (isGroup) {//群聊
                        ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:chatter conversationType:eConversationTypeGroupChat];
                        
                        NSDictionary *dic= [[FDGroupDetailTool sharedInstance] recordGroupDetail:chatter];
                        //                        chatController.title =[dic objectForKey:@"title"];
                        [chatController addTitleViewWithTitle:[dic objectForKey:@"title"]];
                        [nav pushViewController:chatController animated:YES];
                        return;
                    }else{//单聊
                        ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:chatter conversationType:eConversationTypeChat];
                        
                        NSDictionary *dic= [[HQIMFriendsTool sharedInstance] recordFriendDetail:chatter];
                        //                        chatController.title =[dic objectForKey:@"nickname"];
                        [chatController addTitleViewWithTitle:[dic objectForKey:@"nickname"]];
                        [nav pushViewController:chatController animated:YES];
                        return;
                        
                    }
                    
                }else{
                    
                    [nav pushViewController:instance animated:YES];
                }
                
                
            }
            
        }else{//弹出浮窗
            if (isInBackground) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    isInBackground = NO;
                    if ([instance isKindOfClass:[FDEvaluationViewController class]]) {
                        FDEvaluationViewController *evaluation = [[FDEvaluationViewController alloc] init];
                        evaluation.isFromMessage = YES;
                        evaluation.order_no = self.noDict[@"param"];
                        [nav pushViewController:evaluation animated:YES];
                        return;
                    }else if ([instance isKindOfClass:[FDMerchantDetailController class]]) {
                        FDMerchantDetailController *detail = [[FDMerchantDetailController alloc] init];
                        MerchantModel *model = [[MerchantModel alloc] init];
                        model.merchant_id = [self.noDict[@"param"] intValue];
                        detail.model = model;
                        detail.latString = [HQDefaultTool getLat];
                        detail.lngString = [HQDefaultTool getLng];
                        detail.local_lng = [HQDefaultTool getLng];
                        detail.local_lat = [HQDefaultTool getLat];
                        detail.local = @"1";
                        [nav pushViewController:detail animated:YES];
                        return;
                    }
                    else if ([instance isKindOfClass:[FDSubjectDetailViewController class]]) {
                        FDSubjectDetailViewController *detail = [[FDSubjectDetailViewController alloc] init];
                        FDTopics *model = [[FDTopics alloc] init];
                        model.topic_id = self.noDict[@"param"];
                        detail.model = model;
                        detail.latString = [HQDefaultTool getLat];
                        detail.lngString = [HQDefaultTool getLng];
                        detail.local_lng = [HQDefaultTool getLng];
                        detail.local_lat = [HQDefaultTool getLat];
                        detail.local = 1;
                        detail.is_from_push = YES;
                        [nav pushViewController:detail animated:YES];
                        return;
                    }
                    else if([instance isKindOfClass:[FDWebViewController class]]){
                        FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
                        webView.url = self.noDict[@"param"];
                        [nav pushViewController:webView animated:YES];
                        return;
                    }
                    else{
                        [nav pushViewController:instance animated:YES];
                    }
                    
                    
                    
                });
            }else{
                pushViewController = instance;
                [self popListView:params class:instance];
            }
            
        }
        
    }
}


- (void)popListView:(NSDictionary *)params class:(id)class{
    [self.popoverListView dismiss];
    
    CGRect  tipsRect = [[NSString stringWithFormat:@"%@",params[@"aps"][@"alert"]] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    
    CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 40.0f;
    CGFloat yHeight = 180+tipsRect.size.height;
    CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
    
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
    poplistview.listView.scrollEnabled = FALSE;
    [poplistview show];
    poplistview.isTouchOverlayView = NO;
    self.popoverListView = poplistview;
    self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
    PayFail *payResult = [[[NSBundle mainBundle] loadNibNamed:@"PayFail" owner:nil options:nil]lastObject];
    [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
    payResult.frame = self.popoverListView.bounds;
    payResult.title.text = @"你有新的通知";
    payResult.detail.textAlignment = NSTextAlignmentLeft;
    payResult.detail.text = params[@"aps"][@"alert"];
    [payResult.doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [payResult.cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [poplistview addSubview:payResult];
    
}
- (void)doneBtnClick{
    [self.popoverListView dismiss];
    if (self.noDict[@"push_id"]) {
        HttpUserPushNotify *userPush = [HttpUserPushNotify sharedInstance];
        [userPush loadUserPushNotifyWithPush_id:self.noDict[@"push_id"]];
    }
    if ([pushViewController isKindOfClass:[FDEvaluationViewController class]]) {
        FDEvaluationViewController *evaluation = [[FDEvaluationViewController alloc] init];
        evaluation.isFromMessage = YES;
        evaluation.order_no = self.noDict[@"param"];
        [nav pushViewController:evaluation animated:YES];
        return;
    }else if ([pushViewController isKindOfClass:[FDMerchantDetailController class]]) {
        FDMerchantDetailController *detail = [[FDMerchantDetailController alloc] init];
        MerchantModel *model = [[MerchantModel alloc] init];
        model.merchant_id = [self.noDict[@"param"] intValue];
        detail.model = model;
        detail.latString = [HQDefaultTool getLat];
        detail.lngString = [HQDefaultTool getLng];
        detail.local_lng = [HQDefaultTool getLng];
        detail.local_lat = [HQDefaultTool getLat];
        detail.local = @"1";
        [nav pushViewController:detail animated:YES];
        return;
    }
    else if ([pushViewController isKindOfClass:[FDSubjectDetailViewController class]]) {
        FDSubjectDetailViewController *detail = [[FDSubjectDetailViewController alloc] init];
        FDTopics *model = [[FDTopics alloc] init];
        model.topic_id = self.noDict[@"param"];
        detail.model = model;
        detail.latString = [HQDefaultTool getLat];
        detail.lngString = [HQDefaultTool getLng];
        detail.local_lng = [HQDefaultTool getLng];
        detail.local_lat = [HQDefaultTool getLat];
        detail.local = 1;
        detail.is_from_push = YES;
        [nav pushViewController:detail animated:YES];
        return;
    }
    else if ([pushViewController isKindOfClass:[FDWebViewController class]]){
        FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
        webView.url = self.noDict[@"param"];
        [nav pushViewController:webView animated:YES];
        return;
    }
    
    else{
        [nav pushViewController:pushViewController animated:YES];
    }
    
}
- (void)cancleBtnClick{
    [self.popoverListView dismiss];
}
/**
 *  检测对象是否存在该属性
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}
/**
 *  本地推送
 */
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    //前台不显示提示框
    //    [APService showLocalNotificationAtFront:notification identifierKey:nil];
    NSDictionary *userInfo = notification.userInfo;
    MQQLog(@"哈哈哈哈哈哈%@",notification.userInfo);
    [APService resetBadge];
    
    if(notification.userInfo[@"ConversationChatter"]!=nil){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([notification.userInfo[@"MessageType"] intValue]==0) {///单聊
                [self push:userInfo class:@"ChatViewController" open:YES chatter:notification.userInfo[@"ConversationChatter"] group:NO];
            }else{
                
                [self push:userInfo class:@"ChatViewController" open:YES chatter:notification.userInfo[@"ConversationChatter"] group:YES];
            }
            
        });
    }
}
- (void)networkStateChange
{
    [self checkNetworkState];
}
- (void)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        //        NSLog(@"有wifi");
        
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        //       NSLog(@"使用手机自带网络进行上网");
        
    } else { // 没有网络
        
        //      [SVProgressHUD showImage:nil status:@"当前无网络连接,请检查你的网络设置"];
    }
}

@end
