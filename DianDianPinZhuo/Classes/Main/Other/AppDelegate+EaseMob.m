//
//  AppDelegate+EaseMob.m
//  EasMobSample
//
//  Created by dujiepeng on 12/5/14.
//  Copyright (c) 2014 dujiepeng. All rights reserved.
//

#import "AppDelegate+EaseMob.h"
#import "EMNetworkMonitorDefs.h"
#import "HQDefaultTool.h"
#import "HQConst.h"
#import "ApplyViewController.h"
#import "RobotManager.h"
#import "EaseConversationListViewController.h"
#import "ChatViewController.h"
#import "UIViewController+HUD.h"
/**
 *  本类中做了EaseMob初始化和推送等操作
 */

@implementation AppDelegate (EaseMob)

- (void)easemobApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (launchOptions) {
        NSDictionary *userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        if(userInfo)
        {
            
            [self didReceiveRemoteNotification:userInfo];
        }
        
    }
    
    //加载申请通知的数据
    [[ApplyViewController shareController] loadDataSourceFromLocalDB];
    
    _connectionState = eEMConnectionConnected;
    
    [self registerRemoteNotification];
    
    self.mainController = [[ContactListViewController alloc] initWithNibName:nil bundle:nil];
    
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"fandianDev";
#else
    apnsCertName = @"fandianPro";
#endif
    // chatdemoui_dev chatdemoui easemob-demo#chatdemoui
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"1511101924#diandianpinzhuo"
                                       apnsCertName:apnsCertName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    // 登录成功后，自动去取好友列表
    // SDK获取结束后，会回调
    // - (void)didFetchedBuddyList:(NSArray *)buddyList error:(EMError *)error方法。
    [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
    
    // 注册环信监听
    [self registerEaseMobNotification];
    [[EaseMob sharedInstance] application:application
            didFinishLaunchingWithOptions:launchOptions];
    
    [self setupNotifiers];
}

#pragma mark - 监听系统生命周期回调，以便将需要的事件传给SDK

- (void)setupNotifiers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackgroundNotif:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActiveNotif:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActiveNotif:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidReceiveMemoryWarning:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillTerminateNotif:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataWillBecomeUnavailableNotif:)
                                                 name:UIApplicationProtectedDataWillBecomeUnavailable
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataDidBecomeAvailableNotif:)
                                                 name:UIApplicationProtectedDataDidBecomeAvailable
                                               object:nil];
}

#pragma mark - notifiers
- (void)appDidEnterBackgroundNotif:(NSNotification*)notif{
    [[EaseMob sharedInstance] applicationDidEnterBackground:notif.object];
}

- (void)appWillEnterForeground:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:notif.object];
}

- (void)appDidFinishLaunching:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidFinishLaunching:notif.object];
}

- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidBecomeActive:notif.object];
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillResignActive:notif.object];
}

- (void)appDidReceiveMemoryWarning:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidReceiveMemoryWarning:notif.object];
}

- (void)appWillTerminateNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillTerminate:notif.object];
}

- (void)appProtectedDataWillBecomeUnavailableNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationProtectedDataWillBecomeUnavailable:notif.object];
}

- (void)appProtectedDataDidBecomeAvailableNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationProtectedDataDidBecomeAvailable:notif.object];
}
//
//// 将得到的deviceToken传给SDK
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    NSString *deviceTokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
//                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
//                                stringByReplacingOccurrencesOfString: @" " withString: @""];
//    [HQDefaultTool setDevice_token:deviceTokenStr];
//    MQQLog(@"deviceToken --- %@",deviceTokenStr);
//    [APService registerDeviceToken:deviceToken];
//
//    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
//}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

// 注册推送
- (void)registerRemoteNotification{
    return;
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
}

#pragma mark - registerEaseMobNotification
- (void)registerEaseMobNotification {
    [self unRegisterEaseMobNotification];
    // 将self 添加到SDK回调中，以便本类可以收到SDK回调
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

- (void)unRegisterEaseMobNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}



#pragma mark - IChatManagerDelegate
// 开始自动登录回调
-(void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    UIAlertView *alertView = nil;
    if (error) {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.errorAutoLogin", @"Automatic logon failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        
        //发送自动登陆状态通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
    else{
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.beginAutoLogin", @"Start automatic login...") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        
        //将旧版的coredata数据导入新的数据库
        EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
        if (!error) {
            error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
        }
    }
    
    //[alertView show];
}

// 结束自动登录回调
-(void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    UIAlertView *alertView = nil;
    if (error) {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.errorAutoLogin", @"Automatic logon failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        
        //发送自动登陆状态通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
    else{
        //获取群组列表
        [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
        
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.endAutoLogin", @"End automatic login...") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    }
    
    //[alertView show];
}


// 绑定deviceToken回调
- (void)didBindDeviceWithError:(EMError *)error
{
    if (error) {
        MQQLog(NSLocalizedString(@"apns.failToBindDeviceToken", @"Fail to bind device token"));
    }
}

// 网络状态变化回调
- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
    //[self. networkChanged:connectionState];
}

// 打印收到的apns信息
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                        options:NSJSONWritingPrettyPrinted error:&parseError];
    //    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推送内容"
    //                                                    message:str
    //                                                   delegate:nil
    //                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
    //                                          otherButtonTitles:nil];
    
    MQQLog(@"====%@",userInfo);
    
    
    //    [alert show];
    
}

#pragma mark - IChatManagerDelegate

#pragma mark - EMChatManagerBuddyDelegate

// 好友申请回调
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    //加载申请通知的数据
    [[ApplyViewController shareController] loadDataSourceFromLocalDB];
    if (!username) {
        return;
    }
    
    
    if (!message) {
        //        message = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), username];
        message = [NSString stringWithFormat:@"请求添加你为饭友:;饭点用户:;我想加你为好友哦"];
    }
    NSArray *messageArray = [message componentsSeparatedByString:@":;"];
    
    //    NSLog(@"好友申请%zd",messageArray.count);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":username, @"username":username, @"applyMessage":message,@"nickname":messageArray[1], @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
    [[ApplyViewController shareController] addNewApply:dic];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:setupUntreatedApplyCount object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:deleteMyFriend object:nil];
}


- (void)_removeBuddies:(NSArray *)userNames
{
    [[EaseMob sharedInstance].chatManager removeConversationsByChatters:userNames deleteMessages:YES append2Chat:YES];
    //    [_chatListVC refreshDataSource];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.nav.viewControllers];
    ChatViewController *chatViewContrller = nil;
    for (id viewController in viewControllers)
    {
        if ([viewController isKindOfClass:[ChatViewController class]] && [userNames containsObject:[(ChatViewController *)viewController conversation].chatter])
        {
            chatViewContrller = viewController;
            break;
        }
    }
    if (chatViewContrller)
    {
        [viewControllers removeObject:chatViewContrller];
        if ([viewControllers count] > 0) {
            [self.nav popViewControllerAnimated:YES];
        } else {
            [self.nav setViewControllers:viewControllers animated:YES];
        }
    }
    
    //    [self showHint:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"delete", @"delete"), userNames[0]]];
}

- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd
{
    if (!isAdd)
    {
        NSMutableArray *deletedBuddies = [NSMutableArray array];
        for (EMBuddy *buddy in changedBuddies)
        {
            if ([buddy.username length])
            {
                [deletedBuddies addObject:buddy.username];
            }
        }
        if (![deletedBuddies count])
        {
            return;
        }
        
        [self _removeBuddies:deletedBuddies];
    } else {
        // clear conversation
        NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
        NSMutableArray *deleteConversations = [NSMutableArray arrayWithArray:conversations];
        NSMutableDictionary *buddyDic = [NSMutableDictionary dictionary];
        for (EMBuddy *buddy in buddyList) {
            if ([buddy.username length]) {
                [buddyDic setObject:buddy forKey:buddy.username];
            }
        }
        for (EMConversation *conversation in conversations) {
            if (conversation.conversationType == eConversationTypeChat) {
                if ([buddyDic objectForKey:conversation.chatter]) {
                    [deleteConversations removeObject:conversation];
                }
            } else {
                [deleteConversations removeObject:conversation];
            }
        }
        if ([deleteConversations count] > 0) {
            NSMutableArray *deletedBuddies = [NSMutableArray array];
            for (EMConversation *conversation in deleteConversations) {
                if (![[RobotManager sharedInstance] isRobotWithUsername:conversation.chatter]) {
                    [deletedBuddies addObject:conversation.chatter];
                }
            }
            if ([deletedBuddies count] > 0) {
                [self _removeBuddies:deletedBuddies];
            }
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:deleteMyFriend object:nil];
    //    [_contactsVC reloadDataSource];
}

- (void)didRemovedByBuddy:(NSString *)username
{
    [self _removeBuddies:@[username]];
    //    [_contactsVC reloadDataSource];
    [[NSNotificationCenter defaultCenter]postNotificationName:deleteMyFriend object:nil];
}

- (void)didAcceptedByBuddy:(NSString *)username
{
    //    [_contactsVC reloadDataSource];
    [[NSNotificationCenter defaultCenter]postNotificationName:deleteMyFriend object:nil];
}

- (void)didRejectedByBuddy:(NSString *)username
{
    //    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.beRefusedToAdd", @"you are shameless refused by '%@'"), username];
    //    TTAlertNoTitle(message);
}

- (void)didAcceptBuddySucceed:(NSString *)username
{
    //    [_contactsVC reloadDataSource];
    [[NSNotificationCenter defaultCenter]postNotificationName:deleteMyFriend object:nil];
}




#pragma mark - IChatManagerDelegate 登录状态变化

- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        //        alertView.tag = 100;
        //        [alertView show];
        
    } onQueue:nil];
}



@end
