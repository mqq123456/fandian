//
//  FDHomeViewController.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "GpsCorrect.h"
#import "FDHomeViewController.h"
#import "HQAddressViewController.h"
#import "FDPersonalCenterViewController.h"
#import "ZJSliderView.h"
#import "FDNearMerchantViewController.h"
#import "FDTopicsViewController.h"
#import "HttpLoading.h"
#import "UserProfileManager.h"
#import "ConversationListController.h"
#import "UIView+WZLBadge.h"
#import "HttpUserAdNotify.h"
#import "ApplyViewController.h"
#import "HttpBaseAds.h"
#import "UIPopoverListView.h"
#import "UINavigationBar+Awesome.h"
#import "FDMyOrderViewController.h"
#import "UIButton+WebCache.h"
#import "HttpBaseStartPageConfigure.h"
#import "HttpBaseVersion.h"
#import "AdsHomeModel.h"
#import "FDCouponsViewController.h"
#import "FDLoginViewController.h"
#import "FDWebViewController.h"
#import "GroupListViewController.h"
#import "FDHuanXinLoginTool.h"

//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface FDHomeViewController ()<CLLocationManagerDelegate,AMapSearchDelegate,HQAddressViewControllerDelegate,EMChatManagerDelegate>
{
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    UIImageView *arrowhead;
}
@property (nonatomic , strong) CLLocationManager *locationmanager;//定位
@property (nonatomic ,strong) UIButton *locationBtn;
@property (assign, nonatomic)BOOL hasEMMessage;
@property (nonatomic ,copy) NSString *latString;
@property (nonatomic ,copy) NSString *lngString;
@property (nonatomic ,copy) NSString *local_lng;
@property (nonatomic ,copy) NSString *local_lat;
@property (nonatomic ,assign) int local;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation FDHomeViewController
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

- (void)initSearch
{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"65b30caa37e370093985cfc3e3a710aa" Delegate:self];
}

- (void)openAppShowLeftOrRight:(ZJSliderView *)sliderView{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"sliderViewLeftOrRight"] isEqualToString:@"1"]) {
        sliderView.left = YES;
    }else if ([[defaults objectForKey:@"sliderViewLeftOrRight"] isEqualToString:@"0"]) {
        sliderView.left = NO;
    }
    else{
        sliderView.left = self.left;
        
    }
}
- (void)initSliderView{
    ZJSliderView *sliderView = [[ZJSliderView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-64)];
    
    [self openAppShowLeftOrRight:sliderView];
    
    sliderView.labelWidth = [UIScreen mainScreen].bounds.size.width/2;
    
    //多个界面的数组
    NSMutableArray *views = [[NSMutableArray alloc] init];
    //先加一个界面
    FDNearMerchantViewController *cash=[[FDNearMerchantViewController alloc]init];
    cash.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-52);
    [self addChildViewController:cash];
    [views addObject:cash.view];
    
    //另一个个界面
    FDTopicsViewController *tableNumber=[[FDTopicsViewController alloc]init];
    tableNumber.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-52);
    [self addChildViewController:tableNumber];
    [views addObject:tableNumber.view];
    
    //放进sliderView
    NSArray *nameArray=[[NSArray alloc]initWithObjects:@"找饭点",@"找饭友",nil];
    [sliderView setViews:views names:nameArray];
    [self.view addSubview:sliderView];

}
- (void)initNav{
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    ///导航定位View
    UIView *locationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW - 80, 44)];
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.frame = CGRectMake(30, 10, ScreenW - 100, 24);
    [_locationBtn setImage:[UIImage imageNamed:@"main_content_ico_dingwei_nor"] forState:UIControlStateNormal];
    [_locationBtn setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_locationBtn setTitle:@"定位中..." forState:UIControlStateNormal];
    _locationBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    arrowhead = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenW-80)/2+60, 19, 5, 6)];
    arrowhead.image = [UIImage imageNamed:@"main_content_ico_back_nor"];
    
    [locationView addSubview:_locationBtn];
    [locationView addSubview:arrowhead];
    [locationView bringSubviewToFront:arrowhead];
    self.navigationItem.titleView = locationView;
    
    _rightBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(4, 4, 32, 32);
    _rightBtn.layer.cornerRadius = 16;
    _rightBtn.layer.masksToBounds = YES;
    
    _rightBtn.imageView.contentMode = UIViewContentModeRight;
    
    [_rightBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtnView addSubview:_rightBtn];
    _redDotView = [[UIView alloc]initWithFrame:CGRectMake(29, 5, 10, 10)];
    _redDotView.backgroundColor = [UIColor whiteColor];
    _redDotView.layer.cornerRadius = 5;
    _redDotView.layer.masksToBounds = YES;
    
    _redDotView.hidden = NO;
    _redView = [[UIView alloc]initWithFrame:CGRectMake(2, 2, 6, 6)];
    _redView.backgroundColor = [UIColor redColor];
    _redView.layer.cornerRadius = 3;
    _redView.layer.masksToBounds = YES;
    
    [_redDotView addSubview:_redView];
    [_rightBtnView addSubview:_redDotView];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_rightBtnView];
}
#pragma mark - 重新定位
- (void)repositionClick{
    self.locationYES = YES;
    //定位
    [self locationAuthorizationJudge];
}
#pragma mark - 加载闪屏页
- (void)loadBaseStartPageConfigure{
    //
    HttpBaseStartPageConfigure *start =  [HttpBaseStartPageConfigure sharedInstance];
    [start loadBaseStartPageConfigure];
}
#pragma mark - 第一次加载
- (void)fristLoading
{
    HttpLoading *loading = [HttpLoading sharedInstance];
    [loading loadingLat:self.local_lat lng:self.local_lng viewController:self];
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        if (![[EaseMob sharedInstance].chatManager isLoggedIn]) {
            //异步登陆账号
            FDHuanXinLoginTool *tool = [FDHuanXinLoginTool sharedInstance];
            [tool huanxinLogin:self];
        }
    }
}
#pragma mark - loading
- (void)loading
{
//    [SVProgressHUD showWithStatus:@"加载中..."];
    [FDLoadingGifHUD showLoadingGifHUD];
    HttpLoading *loading = [HttpLoading sharedInstance];
    [loading loadingLat:self.local_lat lng:self.local_lng viewController:self];
}

#pragma mark - 首页浮层广告
- (void)homeAds{
    HttpBaseAds *ads  =[HttpBaseAds sharedInstance];
    [ads loadBaseAdsWithViewController:self];
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.kdatesArray = [NSMutableArray array];
    self.adsArray = [NSMutableArray array];
    self.kdatesArray = [NSMutableArray array];
    self.kmeal_ids = [NSMutableArray array];
    self.kdescs = [NSMutableArray array];
    self.kdates = [NSMutableArray array];
    self.ktimes = [NSMutableArray array];
    self.eatingDatesArray = [NSMutableArray array];
    
    self.view.backgroundColor = Background_Color;
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repositionClick) name:Reposition object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fristLoading) name:HiddenHomeBottomTicketView object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeAds) name:HomeAds object:nil];
    //搜索
    [self initSearch];
    
    //定位
    [self locationAuthorizationJudge];
    
    //滑动view
    [self initSliderView];
    
    //导航
    [self initNav];
    
    ///注册环信 ，计算环信未读消息
    [self registerNotifications];
    
    [self setupUnreadMessageCount];
    
    [self setupUntreatedApplyCount];
    
    
    ///每5秒钟刷新数据
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(fristLoading) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    //加载闪屏页
    [self loadBaseStartPageConfigure];
    
    //检查版本
    [self loadVersionClick];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    UIColor *color = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
   
    [MobClick event:@"pv_homepage"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    if (![[HQDefaultTool getKid]isEqualToString:@""]) {
        [_rightBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[HQDefaultTool getHead]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"tab_ico_me_nor"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [_rightBtn setBackgroundImage:image forState:UIControlStateNormal];
        }];
    }else{
         [_rightBtn setBackgroundImage:[UIImage imageNamed:@"tab_ico_me_nor"] forState:UIControlStateNormal];
    }
    
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    static int i = 1;
    if (i==1&&![[HQDefaultTool getStart_img]isEqualToString:@""]) {
        i++;
        return;
    }else{
        [self homeAds];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma  mark - Click

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
            
            FDLoginViewController *verification = [[FDLoginViewController alloc] init];
            verification.isFirst = YES;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
            [self presentViewController:nav animated:YES completion:nil];
            
            
            
        }else if([model.url isEqualToString:@"login"]){
            if (![[HQDefaultTool getKid] isEqualToString:@""]) {
                return;
            }
            
            
            FDLoginViewController *verification = [[FDLoginViewController alloc] init];
            
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

-(void)adViewClickCanclebtn{
    [self.adView removeFromSuperview];
}
#pragma mark － 更新版本
- (void)loadVersionClick{
    HttpBaseVersion *version = [HttpBaseVersion sharedInstance];
    [version getVersionWithContoller:self];
}

- (void)doneBtnClick{
    [self.popoverListView dismiss];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[HQDefaultTool getVerUrl]]];
}

- (void)cancleBtnClick{
    [self.popoverListView dismiss];
}

#pragma mark - 跳转个人中心
- (void)leftClick{
    _redDotView.hidden = YES;
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
    /**
     *  如果是第一次需要去发通知加载两个页面的数据
     */
    if ([_latString intValue]!=0) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:GetLocation object:nil userInfo:@{@"lat":_latString,@"lng":_lngString,@"local_lat":_local_lat,@"local_lng":_local_lng,@"local":[NSString stringWithFormat:@"%d",_local]}];
        [self fristLoading];
        });
    }
    /**
     *  如果是切换位置同样需要重新加载两个页面
     */
    if (self.locationYES) {
        self.locationYES = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:GetLocation object:nil userInfo:@{@"lat":_latString,@"lng":_lngString,@"local_lat":_local_lat,@"local_lng":_local_lng,@"local":[NSString stringWithFormat:@"%d",_local]}];
        [self fristLoading];
    }
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
        
        [HQDefaultTool setAddress:poi.name];
        [self setLocationBtnFrame:poi.name];
        //通知
        [[NSNotificationCenter defaultCenter] postNotificationName:locationback object:nil];
        
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
    
    [self setLocationBtnFrame:locationStr];
   
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:locationback object:nil];
    
}
- (void)setLocationBtnFrame:(NSString *)locationStr{
    [_locationBtn setTitle:locationStr forState:UIControlStateNormal];
    [HQDefaultTool setAddress:locationStr];
    CGRect contentRect = [_locationBtn.titleLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-140, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    double width=contentRect.size.width;
    arrowhead.x = (ScreenW - 80)/2+width/2+50;
    
}
#pragma mark  - HQAddressViewControllerDelegate
-(void)backWithAddress:(NSString *)address lng:(NSString *)lng lat:(NSString *)lat{
    
    
    _local_lat = lat;
    _local_lng = lng;
    _latString = lat;
    _lngString = lng;
    [HQDefaultTool setAddress:address];
    [HQDefaultTool setLat:lat];
    [HQDefaultTool setLng:lng];
    _local = 0;
    
    [self setLocationBtnFrame:[NSString stringWithFormat:@"%@",address]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GetLocation object:nil userInfo:@{@"lat":_latString,@"lng":_lngString,@"local_lat":_local_lat,@"local_lng":_local_lng,@"local":[NSString stringWithFormat:@"%d",_local]}];
    
    [self fristLoading];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _redDotView.hidden = NO;
        
    }else{
        _redDotView.hidden = YES;
        self.hasEMMessage = NO;;
    }
    MQQLog(@"消息%zd",unreadCount);
    
}
#pragma mark --消息数
- (void)setupUntreatedApplyCount{
    
    [[ApplyViewController shareController] loadDataSourceFromLocalDB];
    if ([[[ApplyViewController shareController] dataSource] count]!=0&&![[HQDefaultTool getKid] isEqualToString:@""]) {
        self.hasEMMessage = YES;
//        [_rightBtnView showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
_redDotView.hidden = NO;
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - IChatManagerDelegate 登陆回调（主要用于监听自动登录是否成功）

- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (error) {

        
    }
}



@end
