//
//  FDNearMerchantViewController.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDNearMerchantViewController.h"
#import "FDNearMerchantCell.h"
#import "FDNearMerchantFrame.h"
#import "HttpMerchantSearchNear.h"
#import "StatusFrame.h"
#import "FDMerchantDetailController.h"
#import "ZCWScrollNumView.h"
#import "FDHomeTicketView.h"
#import "FDMyOrderViewController.h"
#import "FDTicket_New_ViewController.h"
#import "JDFPeekabooCoordinator.h"

#define kAllFullSuperviewMask      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
@interface FDNearMerchantViewController ()<UIScrollViewDelegate>
{
    NSInteger ticketCount;
}
@property (nonatomic ,copy) NSString *latString;
@property (nonatomic ,copy) NSString *lngString;
@property (nonatomic ,copy) NSString *local_lng;
@property (nonatomic ,copy) NSString *local_lat;
@property (nonatomic ,assign) int local;

@property(nonatomic,strong) ZCWScrollNumView *scrollNumber;
@property(nonatomic,strong) NSDictionary *orderDict;
@property(nonatomic,strong) FDHomeTicketView *ticket;
@property (nonatomic, strong) JDFPeekabooCoordinator *scrollCoordinator;
@end

@implementation FDNearMerchantViewController
#pragma mark -
- (ZCWScrollNumView *)scrollNumber{

    if (!_scrollNumber) {
        _scrollNumber = [[ZCWScrollNumView alloc]initWithFrame:CGRectMake(4, 8, 66, 16)];
    }
    return _scrollNumber;
}
- (UIView *)makeShadowView:(CGRect)frame{
    
    UIView *bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    bgView.layer.shadowOffset = CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    bgView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    bgView.layer.shadowRadius = 4;//阴影半径，默认3
    
    return bgView;
}
- (void)initHeadView{
    /**  */
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    self.headView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:0.95];
    
    [self.view addSubview:self.headView];
    
    /** 滑动控件 */
    self.scrollCoordinator = [[JDFPeekabooCoordinator alloc] init];
    self.scrollCoordinator.scrollView = self.tableView;
    self.scrollCoordinator.topView = _headView;
    self.scrollCoordinator.topViewMinimisedHeight = 0.0f;

    _headView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _headView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _headView.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    _headView.layer.shadowRadius = 2;//阴影半径，默认3
    
    UIImageView *buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 80, 40)];
    buttonImage.image = [UIImage imageNamed:@"baw_bg_qp_nor"];
    [self.headView addSubview:buttonImage];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 9, 72, 32)];
    bgView.backgroundColor = [UIColor clearColor];
    
    [self.headView addSubview:bgView];
    
    [bgView addSubview:self.scrollNumber];
    [self makeScrollNumber];
    int font = 14;
    if (IPHONE4||IPHONE5) {
        font = 12;
    }
    
    UILabel *descLabel = [FDUtils createLabel:@"人在你附近的0家餐厅就餐。" withTextColor:[FDUtils colorWithHexString:@"#222222"] frame:CGRectMake(CGRectGetMaxX(bgView.frame)+9, 15, ScreenW-100, 20) with:font withBackColor:[UIColor clearColor] numberOfLines:0 with:NSTextAlignmentLeft];
    [self.headView addSubview:descLabel];
    self.descriptionLabel = descLabel;

}
- (void)initTicket{
    /** 初始化饭票view */
    
    self.ticket = [[[NSBundle mainBundle] loadNibNamed:@"FDHomeTicketView" owner:nil options:nil]lastObject];
    self.ticket.frame = CGRectMake(0,ScreenH-64-36, ScreenW, 45);
    self.ticket.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:0.95];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.5)];
    line1.backgroundColor = FDColor(233, 233, 233, 1);
    [self.ticket addSubview:line1];
    [self.ticket.ticketBtn addTarget:self action:@selector(ticketBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.ticket.hidden = YES;
    [self.view addSubview:self.ticket];

}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = Background_Color;
    self.tableView.backgroundColor = Background_Color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-36-50);
    self.haveMJRefresh = YES;
    
    [self initHeadView];
    
    [self initTicket];

    _local = 1;
    
    /** 定位成功，刷新数据 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationClick:) name:GetLocation object:nil];
    /** loading成功，刷新head */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadingClick:) name:loadingBack object:nil];
    /** 显示饭票 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(homeTicket:) name:HomeTicket object:nil];
    ///支付失败刷新数据
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MJRefreshTop) name:PayFailOrScuessReloadHome object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    ///餐厅列表流量
    [MobClick event:@"pv_list"];
}
#pragma mark - 跳转饭票
- (void)homeTicket:(NSNotification *)no{
    
    self.orderDict = [NSDictionary dictionaryWithDictionary:no.userInfo];
    self.ticket.ticket_desc = self.orderDict[@"title_desc"];
    self.ticket.ticket_title = self.orderDict[@"ticket_title"];
    [self.ticket.ticketBtn setTitle:self.orderDict[@"title"] forState:UIControlStateNormal];
    
    NSArray *array = self.orderDict[@"order_nos"];
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        self.ticket.hidden = NO;
        self.ticket.frame = CGRectMake(0,ScreenH-64-36, ScreenW, 45);
        [self.ticket layoutIfNeeded];
        
        self.tableView.height= CGRectGetMinY(self.ticket.frame)-CGRectGetMaxY(self.headView.frame);
        
    });
    
    if (array.count>0&&ticketCount!=array.count) {
        self.ticket.hidden = NO;
        self.ticket.frame = CGRectMake(0,ScreenH-64-45-36, ScreenW, 45);
        [self.ticket layoutIfNeeded];
        self.tableView.height= CGRectGetMinY(self.ticket.frame)-CGRectGetMaxY(self.headView.frame);
        
    }else{
        if (ticketCount!=array.count) {
            self.ticket.hidden = YES;
            self.ticket.frame = CGRectMake(0,ScreenH-64-36, ScreenW, 45);
            [self.ticket layoutIfNeeded];
            
            self.tableView.height= CGRectGetMinY(self.ticket.frame)-CGRectGetMaxY(self.headView.frame);
        }
    }
    
    ticketCount = array.count;
    
}
- (void)ticketBtnClick{
    
    NSArray *array = self.orderDict[@"order_nos"];
    if (array.count>1) {
        FDMyOrderViewController *order = [[FDMyOrderViewController alloc] init];
        order.state = @"1";
        [self.navigationController pushViewController:order animated:YES];
    }else if(array.count==1){
        FDTicket_New_ViewController *ticket = [[FDTicket_New_ViewController alloc] init];
        ticket.order_no =array[0];
        
        [self.navigationController pushViewController:ticket animated:YES];
        
        
    }
}



#pragma mark - 加载转动数字
- (void)makeScrollNumber{

    CGRect tmp = {{0, 0}, {50, 50}};
    self.scrollNumber.numberSize = 4;
    self.scrollNumber.backgroundColor = [UIColor clearColor];
    UIImage *image = [[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:10 topCapHeight:14];
    //    self.scrollNumber.backgroundView = [[[UIImageView alloc] initWithImage:image] autorelease];
    UIView *digitBackView = [[UIView alloc] initWithFrame:tmp];
    digitBackView.backgroundColor = [UIColor clearColor];
    digitBackView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    digitBackView.autoresizesSubviews = YES;
    image = [[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:image];
    bgImageView.frame = tmp;
    bgImageView.autoresizingMask = kAllFullSuperviewMask;
    [digitBackView addSubview:bgImageView];
    image = [[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    UIImageView *bgMaskImageView = [[UIImageView alloc] initWithImage:image];
    bgMaskImageView.autoresizingMask = kAllFullSuperviewMask;
    bgMaskImageView.frame = tmp;
    [digitBackView addSubview:bgMaskImageView];
    
    self.scrollNumber.digitBackgroundView = digitBackView;
    self.scrollNumber.digitColor = [UIColor whiteColor];
    self.scrollNumber.digitFont = [UIFont boldSystemFontOfSize:20];
    [self.scrollNumber didConfigFinish];

}


- (void)loadingClick:(NSNotification *)no{

    NSInteger nearby_people = [no.userInfo[@"nearby_people"] integerValue];
    NSString *nearby_people_desc = no.userInfo[@"nearby_people_desc"];
    self.descriptionLabel.text = nearby_people_desc;
    [self.scrollNumber setNumber:nearby_people withAnimationType:ZCWScrollNumAnimationTypeNormal animationTime:0.3];

}


- (void)locationClick:(NSNotification *)no{
    _latString = no.userInfo[@"lat"];
    _lngString = no.userInfo[@"lng"];
    _local_lat = no.userInfo[@"local_lat"];
    _local_lng = no.userInfo[@"local_lng"];
    _local = [no.userInfo[@"local"]intValue];
    [self loadFirstMerchantSearch];
    
}

#pragma mark - 第一次加载
- (void)loadFirstMerchantSearch{
    self.tableView.footer.hidden = YES;
    [self.datyArray removeAllObjects];
    [self.tableView reloadData];
    HttpMerchantSearchNear *search = [HttpMerchantSearchNear sharedInstance];
    [search merchantSearchWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng local:[NSString stringWithFormat:@"%d",self.local] viewController:self];
    
}
- (void)setupDownRefresh{
    HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    footer.frame = CGRectMake(0, 0, ScreenW, 60);
    [footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MJRefreshMore)]];
    self.footer = footer;
}
- (void)MJRefreshTop{

    HttpMerchantSearchNear *search = [HttpMerchantSearchNear sharedInstance];
    [search MJRefreshTopmerchantSearchWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng local:[NSString stringWithFormat:@"%d",self.local] viewController:self];
}

- (void)MJRefreshMore{
    [self.footer beginRefreshing];
    HttpMerchantSearchNear *search = [HttpMerchantSearchNear sharedInstance];
    [search MJRefreshMoremerchantSearchWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng local:[NSString stringWithFormat:@"%d",self.local] viewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDNearMerchantFrame *frame = self.datyArray[indexPath.row];
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDNearMerchantCell *cell = [FDNearMerchantCell cellWithTableView:tableView];
    cell.topic_merchantList = YES;
    cell.statusFrame = self.datyArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FDMerchantDetailController *detail = [[FDMerchantDetailController alloc] init];
    StatusFrame *frame = self.datyArray[indexPath.row];
    if ([frame.status.sold_out intValue]==1) {//是否售完
        [SVProgressHUD showImage:nil status:self.soldout_hint];
    }else{
    detail.model = frame.status;
    detail.latString = self.latString;
    detail.lngString = self.lngString;
    detail.local_lng = self.local_lng;
    detail.local_lat = self.local_lat;
    detail.local = [NSString stringWithFormat:@"%d",self.local];
    detail.is_bz = @"1";
    [self.navigationController pushViewController:detail animated:YES];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    self.footer.hidden = self.datyArray.count == 0;
    return self.datyArray.count;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.footer.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        //self.scrollCoordinator.topViewMinimisedHeight = self.headView.height;
        return;
    }
    if (scrollView.contentSize.height>self.tableView.frame.size.height+50) {
        self.tableView.y = CGRectGetMaxY(self.headView.frame);
        self.tableView.height= CGRectGetMinY(self.ticket.frame)-CGRectGetMaxY(self.headView.frame);
        self.scrollCoordinator.topViewMinimisedHeight = 0.f;
    }else{
        self.scrollCoordinator.topViewMinimisedHeight = self.headView.height;
    }
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
