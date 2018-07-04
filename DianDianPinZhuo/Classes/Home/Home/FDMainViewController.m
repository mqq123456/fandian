//
//  FDMainViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//  首页

#import <CoreLocation/CoreLocation.h>
#import "FDMainViewController.h"
#import "FDMerchantListViewController.h"
#import "HQAddressViewController.h"
#import "HJCActionSheet.h"
#import "FDPersonalCenterViewController.h"
#import "FDMyTicketViewController.h"
#import "UIView+WZLBadge.h"
#import "FDMyOrderViewController.h"
#import "UIPopoverListView.h"
#import "PayFail.h"
#import "FDAdView.h"
#import "UserProfileManager.h"
#import "ConversationListController.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import "HttpLoading.h"
#import "GpsCorrect.h"
#import "AdView.h"
#import "PeopleModel.h"
#import "HttpBaseAds.h"
#import "AdsHomeModel.h"
#import "FDLoginViewController.h"
#import "HttpUserAdNotify.h"
#import "ApplyViewController.h"
#import "HttpUserKid.h"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";


#pragma mark - Private interface
@interface FDMainViewController ()<HQAddressViewControllerDelegate,CLLocationManagerDelegate,HJCActionSheetDelegate,IChatManagerDelegate, EMCallManagerDelegate,AMapSearchDelegate>
{
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    UIImageView *arrowhead;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;

}

@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (assign, nonatomic)BOOL hasEMMessage;
@property (nonatomic , strong) CLLocationManager *locationmanager;//定位

///中间View
@property (weak, nonatomic) IBOutlet UIView *midBgView;
///拼桌btn
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;

///搜索
@property (weak, nonatomic) IBOutlet UIButton *searchingBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midBgViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midBgViewW;

- (IBAction)searchBtnClick:(id)sender;
- (IBAction)inviteBtnClick:(id)sender;

- (IBAction)eatingTimeClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gap1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midCenterY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lookLabelX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lookBtnW;



@end

@implementation FDMainViewController
#pragma mark


#pragma mark - 懒加载

- (CLLocationManager *)locationmanager {
    if (!_locationmanager) {
        _locationmanager = [[CLLocationManager alloc] init];
        _locationmanager.delegate = self;
        _locationmanager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return _locationmanager;
}

- (FDAdView *)adView{
    if (_adView==nil) {
        _adView = [FDAdView selfAdImageView];
        [_adView.cancleBtn addTarget:self action:@selector(adViewClickCanclebtn) forControlEvents:UIControlEventTouchUpInside];

    }

    return _adView;

}
#pragma mark - 点击广告的取消按钮
-(void)adViewClickCanclebtn{

    [self.adView removeFromSuperview];
}

- (void)initSearch
{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"65b30caa37e370093985cfc3e3a710aa" Delegate:self];
}

#pragma mark - loading
- (void)loading
{
    HttpLoading *loading = [HttpLoading sharedInstance];
    [loading loadingWithLat:self.local_lat lng:self.local_lng viewController:self];
    
  
}

#pragma mark - 开始搜索
- (IBAction)searchBtnClick:(id)sender {
    
    if (self.kdatesArray.count==0) {
        [self loading];
        [SVProgressHUD showImage:nil status:@" 正在加载开餐时间 "];
        return;
    }else if ([_peopleNum intValue]==0){
        [SVProgressHUD showImage:nil status:@" 请选择就餐人数 "];
        return;
    }else if ([_latString isEqualToString:@""]&&[_local_lat isEqualToString:@""]){
        [SVProgressHUD showImage:nil status:@" 还没有获得您的位置，可以自定义位置哦 "];
        return;
    }else if ([_kdate isEqualToString:@""]||[_meal_id isEqualToString:@""]){
        [SVProgressHUD showImage:nil status:@" 请选择就餐时间 "];
        return;
    }
    NSString *addressName;
    
    if (!_locationBtn.titleLabel.text) {
        addressName = @"";
    }else{
        addressName = _locationBtn.titleLabel.text;
    }

    [MobClick event:@"click_homepage_search" attributes:@{@"address" : addressName,@"time" : _meal_time ,@"mode" :[self.peoples_descArray objectAtIndex:_people_selected_index-1] ,@"defaultaddress":[NSString stringWithFormat:@"%d",_local]}];
    FDMerchantListViewController *list = [[FDMerchantListViewController alloc] init];
    list.best_select_index = _best_select_index;
    //将数据传递下一级界面
    list.kdateArray = [[NSArray alloc]initWithArray:self.kdatesArray];
    list.latString = _latString;
    list.lngString = _lngString;
    list.local_lat = _local_lat;
    list.local_lng = _local_lng;
    list.kdate = _kdate;
    list.meal_id = _meal_id;
    list.local = _local;
    list.kdate_desc = _kdate_desc;
    list.meal_time = _meal_time;
    list.adsArray = self.listAdsArray;
    list.timeArray = self.timeArray;
    
    list.ktimes = self.ktimes;
    list.kdescs = self.kdescs;
    list.kmeal_ids = self.kmeal_ids;
    list.kdates = self.kdates;
    list.data2 = self.peoples_descArray;
    list.peoplesArray = self.peoplesArray;
    list.peopleNum = _peopleNum;

    
    list.currentData1Index = _time_select_index-1;
    
    list.currentData2Index = _people_selected_index-1;

    [self.navigationController pushViewController:list animated:YES];
    
}

#pragma mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    NSUserDefaults *userDefaut = [NSUserDefaults standardUserDefaults];
    if ([userDefaut objectForKey:@"version"]) {
        
    }
    else{
       
        //退出环信
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            if (error && error.errorCode != EMErrorServerNotLogin) {//退出失败
                
            }
            else{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        } onQueue:nil];
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            if (!error && info) {
                MQQLog(@"退出成功");
            }
        } onQueue:nil];
        
        MQQLog(@"退出成功");
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"head"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nick_name"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"industry"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"frist"];
        
        [userDefaut setObject:APP_VERSION forKey:@"version"];
        [userDefaut synchronize];
    }

    [self setupUnreadMessageCount];
    [self setupUntreatedApplyCount];
    [self initSearch];

    self.bottomView.hidden = YES;
    self.kdatesArray = [NSMutableArray array];
    self.adsArray = [NSMutableArray array];
    self.kdatesArray = [NSMutableArray array];
    self.timeArray = [NSMutableArray array];
    self.kmeal_ids = [NSMutableArray array];
    self.kdescs = [NSMutableArray array];
    self.kdates = [NSMutableArray array];
    self.ktimes = [NSMutableArray array];
    self.listAdsArray = [NSMutableArray array];

    _latString = @"";
    _lngString = @"";
    _local_lat = @"";
    _local_lng = @"";
    _peopleNum = @"0";
    _kdate = @"";
    _meal_id = @"";
    _meal_time = @"";
    
    _people_selected_index = 0;
    _time_select_index = 0;
    _last_best_index = -1;
   
   
    
    //self.adsArray = [HQDefaultTool getHomeAds];

    //通知修改时间，人数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyThePeople:) name:ModifyThePeople object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyTheTime:) name:ModifyTheTime object:nil];
    ///隐藏下面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideBottomView) name:HiddenHomeBottomTicketView object:nil];
    
    ///登陆之后重新load，支付成功重新loading，退款成功后重新loading
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loading) name:ReloadLoading object:nil];
    //通知，没有消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenNewImageClick) name:HiddenNewMessageRemind object:nil];
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationAuthorizationJudge) name:Reposition object:nil];
    
    ///导航定位View
    UIView *locationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW - 100, 44)];
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.frame = CGRectMake(0, 0, ScreenW - 120, 44);
    [_locationBtn setImage:[UIImage imageNamed:@"main_content_ico_dingwei_nor"] forState:UIControlStateNormal];
    [_locationBtn setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_locationBtn setTitle:@"定位中..." forState:UIControlStateNormal];
    _locationBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    arrowhead = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenW-100)/2+60, 19, 5, 6)];
    arrowhead.image = [UIImage imageNamed:@"main_content_ico_back_nor"];
    
    [locationView addSubview:_locationBtn];
    [locationView addSubview:arrowhead];
    [locationView bringSubviewToFront:arrowhead];
    self.navigationItem.titleView = locationView;
    
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 28, 32);

    [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [_rightBtn setImage:[UIImage imageNamed:@"main_right_profile"] forState:UIControlStateNormal];
    _rightBtn.imageView.contentMode = UIViewContentModeRight;
    [_rightBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    
    
    
    //适配不同机型
    if (IPhone6Plus) {
        self.midBgViewW.constant = ScreenW-175;
        self.midCenterX.constant = 56;
        self.logoY.constant = 106;
        self.btnH.constant = 46;
        self.gap1H.constant = 10;
        self.searchY.constant = 80;
        self.lookBtnW.constant = 110;
        self.lookLabel.font = [UIFont systemFontOfSize:16];
        self.lookLabelX.constant = 20;
        
    }else if (IPhone6){
        
        self.midBgViewW.constant = ScreenW-130;
        self.midCenterX.constant = 36;
        self.logoY.constant = 76;
        self.btnH.constant = 40;
        self.gap1H.constant = 10;
        self.searchY.constant = 70;
        self.lookBtnW.constant = 100;
        self.lookLabel.font = [UIFont systemFontOfSize:15];
        
    }else if (IPHONE4){
        
        self.midBgViewW.constant = ScreenW-120;
        self.midCenterX.constant = 56;
        self.logoY.constant = 56;
        self.btnH.constant = 36;
        self.gap1H.constant = 8;
        self.searchY.constant = 40;
        self.lookBtnW.constant = 80;
        self.lookLabel.font = [UIFont systemFontOfSize:15];
        
    }else{
        self.midBgViewW.constant = ScreenW-100;
        self.midCenterX.constant = 46;
        self.logoY.constant = 66;
        self.btnH.constant = 36;
        self.gap1H.constant = 8;
        self.searchY.constant = 60;
        self.lookBtnW.constant = 80;
        self.lookLabel.font = [UIFont systemFontOfSize:15];
    }
    
    [self.view layoutIfNeeded];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///首页流量

    [self loading];
    [self registerNotifications];
//    [self setupUntreatedApplyCount];
    [self setupUnreadMessageCount];
    
    [MobClick event:@"pv_homepage"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    HttpBaseAds *ads  =[HttpBaseAds sharedInstance];
    [ads loadBaseAdsWithViewController:self];
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        if (![[EaseMob sharedInstance].chatManager isLoggedIn]) {
            //异步登陆账号
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
   
                 }
                 else
                 {
                     MQQLog(@"环信登录失败！");
                 }
             } onQueue:nil];
            
        }

    }
}
#pragma mark - 通知，修改选择
- (void)modifyTheTime:(NSNotification *)notification{
    _kdate = notification.userInfo[@"kdate"];
    _kdate_desc = notification.userInfo[@"kdate_desc"];
    _meal_id = notification.userInfo[@"meal_id"];
    _time_select_index = [notification.userInfo[@"time_select_index"] integerValue]+1;
    [self.eatingTimaBtn setTitle:[NSString stringWithFormat:@"开餐时间：%@ %@",notification.userInfo[@"kdate_desc"],notification.userInfo[@"meal_time"]] forState:UIControlStateNormal];
}
- (void)modifyThePeople:(NSNotification *)notification{
  
    _peopleNum =[NSString stringWithFormat:@"%@", notification.userInfo[@"people"]];
    
    if ([[self.peoplesArray lastObject] integerValue]== [_peopleNum integerValue]) {
       [self.inviteBtn setTitle:@"就餐方式：包桌" forState:UIControlStateNormal];
    }else{
    
       [self.inviteBtn setTitle:[NSString stringWithFormat:@"就餐方式：%@",notification.userInfo[@"people_desc"]] forState:UIControlStateNormal];
    }
    
        _people_selected_index = [notification.userInfo[@"index"] integerValue]+1;
    
}
- (void)hiddenNewImageClick{
    _is_msg = 0;
}

#pragma  mark  退出登录之后不显示下面的提示
- (void)hideBottomView{
    self.bottomView.hidden = YES;
}

#pragma mark - 跳转个人中心
- (void)leftClick{
    [_rightBtn clearBadge];
    FDPersonalCenterViewController *infomatin = [[FDPersonalCenterViewController alloc] init];
    infomatin.integral_tip = self.integral_tip;
    [self.navigationController pushViewController:infomatin animated:YES];
}

#pragma mark 切换位置
- (void)locationBtnClick:(id)sender {
    
    HQAddressViewController *address = [[HQAddressViewController alloc] init];
    address.delegate = self;
    address.lat = self.latString;
    address.lng = self.lngString;
    [self.navigationController pushViewController:address animated:YES];
    
}
#pragma mark 订单列表
- (void)orderVC:(UIButton *)sender{
    ///点击有订单，去看看
    if (sender.tag == 200) {
        [MobClick event:@"click_homepage_order"];
        FDMyOrderViewController *myorder = [[FDMyOrderViewController alloc] init];
        
        [self.navigationController pushViewController:myorder animated:YES];
        
    }
}
#pragma mark 跳转饭票
- (void)ticketVC:(UIButton *)sender{
    ///点击有订单，去看看
    [MobClick event:@"click_homepage_order"];
    
    if (sender.tag == 201) {
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            FDLoginViewController *verification = [[FDLoginViewController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }else{
            
            FDMyTicketViewController *ticket = [[FDMyTicketViewController alloc] init];
            ticket.order_no = self.order_id;
            
            [self.navigationController pushViewController:ticket animated:YES];
            
        }
        
    }
    
}

#pragma mark - 拼桌
- (IBAction)inviteBtnClick:(id)sender {
    

 
    // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
//    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self  index:0 OtherTitles:self.peoples_descArray sender:(UIButton *)sender selectedIndex:_people_selected_index best_select_index:_best_select_index];
//    // 2.显示出来
//    [sheet show];
}

#pragma mark 开餐时间按钮
- (IBAction)eatingTimeClick:(id)sender {
    if(!self.kdatesArray||self.kdatesArray.count == 0){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self loading];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(!self.kdatesArray||self.kdatesArray.count == 0){
                    
                }
                
                else{
                    // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
                    
//                    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self  index:3 OtherTitles:self.eatingDatesArray sender:(UIButton *)sender selectedIndex:_time_select_index best_select_index:_best_select_index];
//                    
//                    // 2.显示出来
//                    [sheet show];
                }
            });
            
        });
    }
    
    
    else{
        
        // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
        ///index ：1表示拼桌人数，3表示时间[defaults setObject:@"1" forKey:@"isFirst"];
        
//        HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self  index:3 OtherTitles:self.eatingDatesArray sender:(UIButton *)sender selectedIndex:_time_select_index best_select_index:_best_select_index];
//        
        // 2.显示出来
//        [sheet show];
        
        
    }
    
}

#pragma mark  - HQAddressViewControllerDelegate
-(void)backWithAddress:(NSString *)address lng:(NSString *)lng lat:(NSString *)lat{
    [_locationBtn setTitle:[NSString stringWithFormat:@"%@",address] forState:UIControlStateNormal];
    [HQDefaultTool setAddress:address];
    _local_lat = lat;
    _local_lng = lng;
    _latString = lat;
    _lngString = lng;
    _local = 0;
    CGRect contentRect = [_locationBtn.titleLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-140, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    double width=contentRect.size.width;
    arrowhead.x = (ScreenW - 100)/2+width/2+20;
    
}
#pragma  mark - 广告view

- (void)adViewClick{
    
    [self.adView removeFromSuperview];
    if (self.adsArray.count>0) {
        AdsHomeModel *model = self.adsArray[0];
        if ([model.url isEqualToString:@""]) {
            return;
        }
        if ([model.url isEqualToString:@"coupon"]) {
            if (![[HQDefaultTool getKid] isEqualToString:@""]) {
                FDCouponsViewController *coupons = [[FDCouponsViewController alloc] init];
                [self.navigationController pushViewController:coupons animated:YES];
                return;
            }

            FDLoginViewController *verification = [[FDLoginViewController alloc] initWithNibName:@"FDLoginViewController" bundle:nil];
            verification.isFirst = YES;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
            [self presentViewController:nav animated:YES completion:nil];
            
            
            
        }else if([model.url isEqualToString:@"login"]){
            if (![[HQDefaultTool getKid] isEqualToString:@""]) {
                return;
            }
            
            
            FDLoginViewController *verification = [[FDLoginViewController alloc] initWithNibName:@"FDLoginViewController" bundle:nil];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
            [self presentViewController:nav animated:YES completion:nil];
            
            
        }else{
            
            FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
            
            webView.url = model.url;
            webView.titleString = model.title;
            [self.navigationController pushViewController:webView animated:YES];
        }
        if (![[HQDefaultTool getKid] isEqualToString:@""]) {
            HttpUserAdNotify *adNotify = [HttpUserAdNotify sharedInstance];
            if (model.ads_id) {
                [adNotify loadUserAdNotifyWithAd_id:model.ads_id];
            }
            
        }
        
    }
    
    
    
}


#pragma mark  更新版本
- (void)doneBtnClick{
    [self.popoverListView dismiss];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[HQDefaultTool getVerUrl]]];
}

- (void)cancleBtnClick{
    [self.popoverListView dismiss];
}


#pragma mark - HJCActionSheetDelegate
- (void)actionSheet:(HJCActionSheet *)actionSheet index:(NSInteger)index clickedButtonAtIndex:(NSInteger)buttonIndex sender:(UIButton *)sender title:(NSArray *)array{
    
    if (index == 0) {
        _peopleNum = self.peoplesArray[buttonIndex-1];
        _people_selected_index = buttonIndex-1;
        _people_selected_index = buttonIndex;
        _currentData2Index = 0;
        if ([[self.peoplesArray lastObject] integerValue]== [_peopleNum integerValue]) {
            [sender setTitle:@"就餐方式：包桌" forState:UIControlStateNormal];
        }else{
            
             [sender setTitle:[NSString stringWithFormat:@"就餐方式：%@",[array objectAtIndex:buttonIndex-1]] forState:UIControlStateNormal];
        }
       
    }
    else{
        
        if (buttonIndex <_best_select_index) {
            
            [SVProgressHUD showImage:nil status:@"订餐时间已过"];
            return;
        }
        
        NSArray *arr = [[array objectAtIndex:buttonIndex-1] componentsSeparatedByString:@" "];

        if (arr.count==4) {
            _kdate = [arr objectAtIndex:3];
            _meal_id = [arr objectAtIndex:2];
            _meal_time = [arr objectAtIndex:1];
            _kdate_desc = [arr objectAtIndex:0];
        }
        
        [sender setTitle:[NSString stringWithFormat:@"开餐时间：%@ %@",arr[0],arr[1]] forState:UIControlStateNormal];
        _time_select_index = buttonIndex;
    }

}

#pragma mark - 定位
- (void)locationAuthorizationJudge {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusNotDetermined) { // 如果授权状态还没有被决定就弹出提示框
        if ([self.locationmanager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationmanager requestWhenInUseAuthorization];
        }
    } else if (status == kCLAuthorizationStatusDenied) { // 如果授权状态是拒绝就给用户提示
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = @"请前往设置-隐私-定位中打开定位服务";
        [alertView addButtonWithTitle:@"确定"];
        [alertView show];
        return;
        
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) { // 如果授权状态可以使用就开始获取用户位置
        [self.locationmanager startUpdatingLocation];
    }
    [self.locationmanager startUpdatingLocation];
    
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    _latString = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    _lngString = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    _local_lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    _local_lng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    //[self reverseGeocodeWithLat:_latString lng:_lngString ];
    _local = 1;
    [HQDefaultTool setLat:_local_lat];
    [HQDefaultTool setLng:_local_lng];
    _currentLocation = [location copy];
    //纠偏，获取写字楼
    [self chinaShiftEnabled];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loading];
    });
    // 根据不同需要停止更新位置
    [self.locationmanager stopUpdatingLocation];
    
}
-(void)chinaShiftEnabled//地图纠偏
{
    GpsCorrect *gpsCorrect=[[GpsCorrect alloc]init];
    LngLat *lnglat=[gpsCorrect transform:[self.local_lat doubleValue] longitude:[self.local_lng doubleValue]];
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:lnglat.latitude longitude:lnglat.longitude];
    request.searchType = AMapSearchType_PlaceAround;
    request.types = @[@"商务写字楼"];
    request.city = @[@"北京"];
    [_search AMapPlaceSearch:request];
}
#pragma mark - AMapSearchDelegate
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:
(AMapPlaceSearchResponse *)response
{
    if (response.pois.count >0)
    {
        AMapPOI *poi = response.pois[0];
        [self.locationBtn setTitle:poi.name forState:UIControlStateNormal];
        [HQDefaultTool setAddress:poi.name];
        CGRect contentRect = [_locationBtn.titleLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-140, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        double width=contentRect.size.width;
        arrowhead.x = (ScreenW - 100)/2+width/2+20;
        //通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"locationback" object:nil];

    }else{
        
        [self reGeoAction];
    }
}

- (void)searchRequest:(id)request didFailWithError:(NSError *)error{
    MQQLog(@"获取位置失败 errr＝ %@",error );
}

- (void)reGeoAction
{
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude
                                                    longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    } }

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:
(AMapReGeocodeSearchResponse *)response
{
    //MQQLog(@"response :%@", response);
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0)
    {
        title = response.regeocode.addressComponent.province;
    }
    NSString *locationStr = [NSString stringWithFormat:@"%@%@%@",title, response.regeocode.addressComponent.district,response.regeocode.addressComponent.township];
    if (!IPhone6&&!IPhone6Plus) {
        if (locationStr.length>9) {
            locationStr = [NSString stringWithFormat:@"%@%@",response.regeocode.addressComponent.district,response.regeocode.addressComponent.township];
        }
    }
    
    [_locationBtn setTitle:locationStr forState:UIControlStateNormal];
    [HQDefaultTool setAddress:locationStr];
    CGRect contentRect = [_locationBtn.titleLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-140, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    double width=contentRect.size.width;
    arrowhead.x = (ScreenW - 100)/2+width/2+20;
    
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"locationback" object:nil];
    
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)dealloc
{
    [self unregisterNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 环信未读消息变化
#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}


// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    
    if (unreadCount+[[[ApplyViewController shareController] dataSource] count]>0&&![[HQDefaultTool getKid] isEqualToString:@""]) {
        
        self.hasEMMessage = YES;
        [_rightBtn showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
        
    }else{
        [_rightBtn clearBadge];
        self.hasEMMessage = NO;;
    }
    MQQLog(@"消息%zd",unreadCount);
   
}
#pragma mark --消息数
- (void)setupUntreatedApplyCount{
    
    [[ApplyViewController shareController] loadDataSourceFromLocalDB];
    if ([[[ApplyViewController shareController] dataSource] count]!=0&&![[HQDefaultTool getKid] isEqualToString:@""]) {
        self.hasEMMessage = YES;
        [_rightBtn showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
        
    }
}
// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages
{
    [self setupUnreadMessageCount];
}
- (void)didFinishedReceiveOfflineCmdMessages
{
    
}
- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}


// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = (message.messageType != eMessageTypeChat) ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        
        //        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        //        if (!isAppActivity) {
        //            [self showNotificationWithMessage:message];
        //        }else {
        //            [self playSoundAndVibration];
        //        }
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        switch (state) {
            case UIApplicationStateActive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateInactive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateBackground:
                [self showNotificationWithMessage:message];
                break;
            default:
                break;
        }
#endif
    }
}

-(void)didReceiveCmdMessage:(EMMessage *)message
{
    MQQLog(@"%@",NSLocalizedString(@"receiveCmd", @"receive cmd message"));
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        MQQLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    //    // 收到消息时，播放音频
    //    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    //    // 收到消息时，震动
    //    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        NSString *title = [[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
        if (message.messageType == eMessageTypeGroupChat) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        else if (message.messageType == eMessageTypeChatRoom)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:@"username" ]];
            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
            NSString *chatroomName = [chatrooms objectForKey:message.conversationChatter];
            if (chatroomName)
            {
                title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, chatroomName];
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
        
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
        [UIApplication sharedApplication].applicationIconBadgeNumber+=1;
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
//    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        MQQLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

}


#pragma mark - IChatManagerDelegate 登陆回调（主要用于监听自动登录是否成功）

- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (error) {
//        NSString *hintText = NSLocalizedString(@"reconnection.retry", @"Fail to log in your account, is try again... \nclick 'logout' button to jump to the login page \nclick 'continue to wait for' button for reconnection successful");
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt")
//                                                            message:hintText
//                                                           delegate:self
//                                                  cancelButtonTitle:NSLocalizedString(@"reconnection.wait", @"continue to wait")
//                                                  otherButtonTitles:NSLocalizedString(@"logout", @"Logout"),
//                                  nil];
//        alertView.tag = 99;
//        [alertView show];

    }
}


@end

