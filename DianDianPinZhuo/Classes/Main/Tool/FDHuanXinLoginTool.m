
//
//  FDHuanXinLoginTool.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/18.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDHuanXinLoginTool.h"
#import "EaseMob.h"
#import "HQDefaultTool.h"
#import "HQConst.h"
@implementation FDHuanXinLoginTool
#pragma mark -  获取单例对象
static id _instace;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}
- (void)huanxinLogin:(UIViewController *)controller{
    //异步登陆账号
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.color = [UIColor grayColor];
    activity.center =CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-32) ;
    [controller.view addSubview:activity];
    [activity startAnimating];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[HQDefaultTool getKid]
                                                        password:[HQDefaultTool getIm_passWord]                                                          completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         if (loginInfo && !error) {
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             
             // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
             [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             //获取数据库中数据
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             
             //获取群组列表
             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             
             //发送自动登陆状态通知
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             
             //保存最近一次登录用户名
             NSString *username = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
             if (username && username.length > 0) {
                 NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                 [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
                 [ud synchronize];
             }
             MQQLog(@"环信登录成功!");
             [activity stopAnimating];
             
         }
         else
         {
             [activity stopAnimating];
             MQQLog(@"环信登录失败！");
         }
     } onQueue:nil];
    
}


@end
