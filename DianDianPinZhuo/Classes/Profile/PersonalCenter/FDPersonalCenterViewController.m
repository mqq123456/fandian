//
//  FDPersonalCenterViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDPersonalCenterViewController.h"
#import "FDPersonalCenterCell.h"
#import "FDOrderStateCell.h"
#import "UINavigationBar+Awesome.h"
#import "FDInformationViewController.h"
#import "FDQrCodeViewController.h"
#import "FDScanViewController.h"
#import "UIButton+WebCache.h"
#import "FDCouponsViewController.h"
#import "FDMessageViewController.h"
#import "FDMyOrderViewController.h"
#import "FDGrowingViewController.h"
#import "FDInvoiceViewController.h"
#import "ConversationListController.h"
#import "FDInvitationViewController.h"
#import "FDWalletViewController.h"
#import "FDConfigViewController.h"
#import "UserProfileManager.h"
#import "ContactListViewController.h"
#import "FDUserDetailViewController.h"
#import "FDIntegralViewController.h"
#import "HttpUserInfo.h"
#import "ApplyViewController.h"
#import "FDLoginViewController.h"
#import "HttpUserKid.h"
#import "UIView+WZLBadge.h"
#import "FDTicket_New_ViewController.h"
#import "FDInvitationCodeViewController.h"
#import "FDHuanXinLoginTool.h"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";


@interface FDPersonalCenterViewController ()< IChatManagerDelegate, EMCallManagerDelegate,UIScrollViewDelegate,FDLoginViewControllerDelegate>
{

    UILabel *integral;
    UILabel *nickName;
    UIButton *headBtn;
    UILabel *professional;
    UIView *professionalBack;
    UIImageView *id_image;
    NSInteger unreadCount;
    UILabel *weidenglu;

    
}
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property(nonatomic,assign) BOOL hasEMMessage;//有消息
@property (nonatomic ,strong) NSArray *titleArray;
@property (nonatomic ,strong) NSArray *imageArray;
@property (nonatomic ,strong)UIButton *rqCode;

@end

@implementation FDPersonalCenterViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, -124, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+60);
    self.tableView.separatorColor = [UIColor colorWithWhite:0 alpha:0.15];
    /** 通知 */
    UIButton *notice = [UIButton buttonWithType:UIButtonTypeCustom];
    notice.frame = CGRectMake(0, 0, 17.5, 21);
    [notice setImage:[UIImage imageNamed:@"tab_ico_tongzhi_nor"] forState:UIControlStateNormal];
    [notice addTarget:self action:@selector(noticeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.notice = notice;
    /** 二维码 */
    UIButton *rqCode = [UIButton buttonWithType:UIButtonTypeCustom];
    rqCode.frame = CGRectMake(0, 0, 40, 20);
    [rqCode setImage:[UIImage imageNamed:@"tab_ico_saoyisao_nor"] forState:UIControlStateNormal];
    [rqCode addTarget:self action:@selector(rqCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.rqCode = rqCode;
    UIBarButtonItem *noticeBtn = [[UIBarButtonItem alloc]initWithCustomView:notice];
    UIBarButtonItem *rqCodeBtn = [[UIBarButtonItem alloc]initWithCustomView:rqCode];
    self.navigationItem.rightBarButtonItems = @[noticeBtn,rqCodeBtn];
    
    [self setHeadView];
    
    self.titleArray = @[@[@"我的饭票",@"",@"我的钱包"],
                        @[@"我的消息",@"我的饭友",@"我的二维码",@"激活优惠码"],
                        @[@"有奖邀请",@"设置"]];
    
    self.imageArray = @[@[@"baw_ico_dingdan_nor",
                          @"",
                          @"baw_ico_qianbao_nor"],
                        @[@"baw_ico_xiaoxi_nor",
                          @"baw_ico_haoyou_nor",
                          @"baw_ico_ma_nor",
                          @"baw_ico_youhuima_nor"],
                        @[@"baw_ico_yaoqing_nor",
                          @"baw_ico_shezhi_nor"]];
    
    /** 头部试图 */
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.6232+60)];
    headView.backgroundColor = [UIColor purpleColor];
    self.tableView.tableHeaderView = headView;
    /** 背景图片 */
    UIImageView *headback = [[UIImageView alloc] initWithFrame:headView.frame];
    headback.image = [UIImage imageNamed:@"tab_bg_geren_nor"];
    [headView addSubview:headback];
    
    /** 积分 */
    integral = [[UILabel alloc] init];
    integral.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width/4, CGRectGetHeight(headView.frame)-35, [UIScreen mainScreen].bounds.size.width/2, 30);
    integral.text = [NSString stringWithFormat:@"积分：%@",[HQDefaultTool getIntegral_point]];
    integral.userInteractionEnabled = YES;
    integral.textAlignment = NSTextAlignmentCenter;
    [integral addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(integralTapClick)]];
    integral.textColor = [UIColor whiteColor];
    integral.font = [UIFont systemFontOfSize:15];
    [headView addSubview:integral];
    
    weidenglu = [[UILabel alloc] init];
    weidenglu.frame = CGRectMake( 0, CGRectGetHeight(headView.frame)-40, [UIScreen mainScreen].bounds.size.width, 30);
    if (IPHONE4) {
        weidenglu.y = CGRectGetHeight(headView.frame)-33;
    }
    weidenglu.text = @"未登录";
    weidenglu.textAlignment = NSTextAlignmentCenter;
    weidenglu.textColor = [UIColor whiteColor];
    weidenglu.font = [UIFont systemFontOfSize:14];
    [headView addSubview:weidenglu];
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        weidenglu.hidden = YES;
    }else{
        integral.hidden = YES;
        weidenglu.hidden = NO;
    }
   
    /** 昵称 */
    CGFloat spe = 65;
    if (IPHONE4||IPHONE5) {
        spe = 55;
    }
    nickName = [[UILabel alloc] init];
    nickName.frame = CGRectMake( 0, CGRectGetHeight(headView.frame)-spe-5, [UIScreen mainScreen].bounds.size.width, 40);
    nickName.text = [HQDefaultTool getNickName];
    nickName.textColor = [UIColor whiteColor];
    nickName.textAlignment = NSTextAlignmentCenter;
    nickName.font = [UIFont boldSystemFontOfSize:17];
    [headView addSubview:nickName];
    if (!![[HQDefaultTool getKid] isEqualToString:@""]) {
        nickName.text = @"点击登录";
    }
   
    /** 头像 */
    CALayer *round1 = [[CALayer alloc] init];
    CGFloat radius1 = 54;
    if(IPHONE4||IPHONE5){
        radius1 = 48;
    }
    
    round1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-radius1, CGRectGetMidY(nickName.frame)-(spe*2)-6, radius1 * 2, radius1 * 2);
    round1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
    round1.cornerRadius = radius1;
    [headView.layer addSublayer:round1];
    
    headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-radius1+6, CGRectGetMidY(nickName.frame)-(spe*2), (radius1-6)*2, (radius1-6)*2);
    headBtn.layer.cornerRadius = radius1-6;
    headBtn.clipsToBounds = YES;
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[HQDefaultTool getHead]] forState:UIControlStateNormal];
    }else{
        [headBtn setBackgroundImage:[UIImage imageNamed:@"grzx_ico_yhy"] forState:UIControlStateNormal];
    }
    
    [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:headBtn];
    
    UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    userBtn.frame = CGRectMake(0, 70+64, [UIScreen mainScreen].bounds.size.width, headView.frame.size.height-154);
    userBtn.backgroundColor = [UIColor clearColor];
    [headView addSubview:userBtn];
    [userBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
    NSString *str = @"个人资料";

    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16.0] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2-50, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    
    
    professionalBack = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40-(size.width), headBtn.centerY-15, size.width+30, 30)];
    professionalBack.userInteractionEnabled = NO;
    professionalBack.layer.cornerRadius = 3;
    professionalBack.clipsToBounds = YES;
    professionalBack.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    [headView addSubview:professionalBack];
    
    professional = [[UILabel alloc] init];
    professional.text = str;
    professional.frame = CGRectMake(8,0, size.width, 30);
    professional.textColor = [UIColor whiteColor];
    professional.font = [UIFont systemFontOfSize:16];
    if (IPHONE4||IPHONE5) {
        professional.font = [UIFont systemFontOfSize:15];
    }
    [professionalBack addSubview:professional];
    id_image = [[UIImageView alloc] initWithFrame:CGRectMake(size.width+12,  7.5, 10, 15)];
    id_image.centerY = professional.centerY;
    id_image.image = [UIImage imageNamed:@"person_ico_jiantou_nor"];
    [professionalBack addSubview:id_image];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:setupUntreatedApplyCount object:nil];

    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        id_image.hidden = YES;
        professional.hidden = YES;
        professionalBack.hidden = YES;
    }else{
        ///环信未读
        [self registerNotifications];
        [self setupUnreadMessageCount];
        id_image.hidden = NO;
        professional.hidden = NO;
        professionalBack.hidden = NO;
    }
    
}
- (void)setHeadView{
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        id_image.hidden = NO;
        professional.hidden = NO;
        professionalBack.hidden = NO;
        integral.hidden = NO;
        if (self.model.integral_point) {
            integral.text = [NSString stringWithFormat:@"积分：%@",self.model.integral_point];
        }
        
        nickName.text = [HQDefaultTool getNickName];
        if ([HQDefaultTool getNickName].length>10) {
            nickName.text = [NSString stringWithFormat:@"%@...",[[HQDefaultTool getNickName] substringToIndex:10]];
        }
        weidenglu.hidden = YES;
        [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[HQDefaultTool getHead]] forState:UIControlStateNormal];
    }else{
        weidenglu.hidden = NO;
        integral.hidden = YES;
        id_image.hidden = YES;
        professional.hidden = YES;
        professionalBack.hidden = YES;
        [headBtn setBackgroundImage:[UIImage imageNamed:@"grzx_ico_yhy"] forState:UIControlStateNormal];
        nickName.text = @"点击登录";
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //导航栏设置成透明色后   还有根线  这句代码就是去线的
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if (self.tableView.contentOffset.y>160) {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        self.title = @"个人中心";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
        [self.rqCode setImage:[UIImage imageNamed:@"tab_ico_saoyisaohei_nor"] forState:UIControlStateNormal];
        [self.notice setImage:[UIImage imageNamed:@"tab_ico_tongzhihei_nor"] forState:UIControlStateNormal];
        [self.navigationController.navigationBar lt_reset];
    }else{
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.rqCode setImage:[UIImage imageNamed:@"tab_ico_saoyisao_nor"] forState:UIControlStateNormal];
        [self.notice setImage:[UIImage imageNamed:@"tab_ico_tongzhi_nor"] forState:UIControlStateNormal];

    }

   
}


- (void)loadDatasource{
    
    NSArray *buddyList = [[EaseMob sharedInstance].chatManager buddyList];
    NSArray *blockList = [[EaseMob sharedInstance].chatManager blockedList];
    
    NSMutableArray *kidsArr = [NSMutableArray array];
    for (EMBuddy *buddy  in buddyList) {
        if (![blockList containsObject:buddy.username]) {
            [kidsArr addObject:buddy.username];
        }
    }
    if (kidsArr.count != 0) {
        NSString *kids = [kidsArr componentsJoinedByString:@","];
        HttpUserKid *tools = [HttpUserKid sharedInstance];
        [tools userkidWithKids:kids];
        
    }

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    if (self.tableView.contentOffset.y>160) {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        self.title = @"个人中心";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
        [self.rqCode setImage:[UIImage imageNamed:@"tab_ico_saoyisaohei_nor"] forState:UIControlStateNormal];
        [self.notice setImage:[UIImage imageNamed:@"tab_ico_tongzhihei_nor"] forState:UIControlStateNormal];
        [self.navigationController.navigationBar lt_reset];
    }else{
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.rqCode setImage:[UIImage imageNamed:@"tab_ico_saoyisao_nor"] forState:UIControlStateNormal];
        [self.notice setImage:[UIImage imageNamed:@"tab_ico_tongzhi_nor"] forState:UIControlStateNormal];
    }
    
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        HttpUserInfo *userInfo = [HttpUserInfo sharedInstance];
        [userInfo loadUserInfoWithViewController:self];
        [self setupUntreatedApplyCount];
    }else{
        [self setHeadView];
        [self.tableView reloadData];
    }
    
    [self loadDatasource];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //加这个方法防崩
    [self.navigationController.navigationBar lt_reset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    

}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 3;
        
    }else if (section == 1){
        
        return 4;
    }
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0&&indexPath.row==1) {
        return 68;
    }else if (indexPath.section==0&&indexPath.row==0){
        return 52;
    }
    return 49;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    if (indexPath.row==1&&indexPath.section==0) {
        FDOrderStateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FDOrderStateCell" owner:nil options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.daishiyongBtn.tag = 50;
        cell.daipingjiaBtn.tag = 51;
        cell.yiwanchengBtn.tag = 52;
        cell.tuikuanBtn.tag = 53;
        if (IPHONE4 || IPHONE5) {
            cell.left.constant = 5;
            cell.right.constant = 5;
        }else{
            cell.left.constant = 15;
            cell.right.constant = 15;
        }
        if ([self.model.orderSum intValue]>0&&![[HQDefaultTool getKid]isEqualToString:@""]) {
            cell.orderSum.hidden = NO;
            cell.orderNum.text = [NSString stringWithFormat:@"%@",self.model.orderSum];
            if ([self.model.orderSum intValue]>=10&&[self.model.orderSum intValue]<100) {
                cell.orderSumWith.constant = 16;
            }else if ([self.model.orderSum intValue]>99){
                cell.orderSumWith.constant = 20;
                cell.orderNum.text = @"99+";
            }
        }else{
            cell.orderSum.hidden = YES;
        }

        [cell.daishiyongBtn addTarget:self action:@selector(orderClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.daipingjiaBtn addTarget:self action:@selector(orderClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.yiwanchengBtn addTarget:self action:@selector(orderClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tuikuanBtn addTarget:self action:@selector(orderClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        FDPersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FDPersonalCenterCell" owner:nil options:nil]lastObject];
        }
        if (indexPath.section==2&&indexPath.row==0) {
            cell.detail.text = @"";
            cell.detail.hidden = NO;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [cell.now_btn setImage:[UIImage imageNamed:@"info_ico_new"] forState:UIControlStateNormal];
            cell.now_btn_whith.constant = 30;
            if ([[defaults objectForKey:@"invated"] isEqualToString:@"1"]) {
                cell.now_btn.hidden = YES;
            }else{
                cell.now_btn.hidden = NO;
            }

        }
        if (indexPath.row==0&&indexPath.section==0) {
            [cell.now_btn setTitle:@"查看所有饭票" forState:UIControlStateNormal];
            cell.now_btn.hidden = NO;
            [cell.now_btn setTitleColor:FDColor(153, 153, 153, 1)forState:UIControlStateNormal];
            cell.now_btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        if (indexPath.row==2&&indexPath.section==0) {
            if (self.integral_tip) {
               [cell.now_btn setTitle:self.integral_tip forState:UIControlStateNormal];
                 CGSize size = [self.integral_tip sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, 20) lineBreakMode:NSLineBreakByTruncatingTail];
                cell.now_btn_whith.constant = size.width+10;
            }else{
                [cell.now_btn setTitle:@"抵扣券  发票" forState:UIControlStateNormal];
            }
            
            cell.now_btn.hidden = NO;
            [cell.now_btn setTitleColor:FDColor(153, 153, 153, 1)forState:UIControlStateNormal];
            cell.now_btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        if (indexPath.row==0&&indexPath.section==1) {
            if (self.hasEMMessage&&![[HQDefaultTool getKid]isEqualToString:@""]) {
                cell.now_btn_whith.constant = 20;
                cell.now_btn_height.constant = 20;
                if ([[[ApplyViewController shareController] dataSource] count]+unreadCount == 0) {
                   cell.now_btn.hidden = YES;
                }else{
                
                   cell.now_btn.hidden = NO;
                    if([[[ApplyViewController shareController] dataSource] count]+unreadCount>99){
                     [cell.now_btn setTitle:@"99+" forState:UIControlStateNormal];
                     cell.now_btn_whith.constant = 30;
                     cell.now_btn_height.constant = 20;
                    }else{
                        cell.now_btn_whith.constant = 20;
                        cell.now_btn_height.constant = 20;
                     [cell.now_btn setTitle:[NSString stringWithFormat:@"%zd",[[[ApplyViewController shareController] dataSource] count]+unreadCount] forState:UIControlStateNormal];

                    }
                   
                }
              
                [cell.now_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                cell.now_btn.backgroundColor = [FDUtils colorWithHexString:@"#fd3031"];
                cell.now_btn.layer.cornerRadius = 10;
                cell.now_btn.clipsToBounds = YES;
                cell.now_btn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
           
        }
        

        cell.title.text = self.titleArray[indexPath.section][indexPath.row];
        cell.icon.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
        
        return cell;
    }
    
}
- (void)orderClick:(UIButton *)button{
    
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        [self gotoLoginWithIndex:button.tag-50+4];
    }else{
        /** 我的饭票 */
        FDMyOrderViewController *order = [[FDMyOrderViewController alloc] init];
        if (button.tag==50) {//待支付
            order.state = @"0";
        }
        if (button.tag==51) {//待使用
            order.state = @"1";
        }
        if (button.tag==52) {//待评价
            order.state = @"2";
        }
        if (button.tag==53) {//退款
            order.state = @"-2";
        }
        
        [self.navigationController pushViewController:order animated:YES];

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0 && indexPath.row==0){
        /** 我的饭票 */
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self gotoLoginWithIndex:3];
        }else{
            FDMyOrderViewController *order = [[FDMyOrderViewController alloc] init];

//            FDTicket_New_ViewController *order = [[FDTicket_New_ViewController alloc]init];
            [self.navigationController pushViewController:order animated:YES];
            
        }
        
    }else if (indexPath.section == 0 && indexPath.row == 2){
        /** 我的钱包 */
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self gotoLoginWithIndex:8];
        }else{
            FDWalletViewController *wallet = [[FDWalletViewController alloc] init];
            [self.navigationController pushViewController:wallet animated:YES];

//            FDTopicTicketViewController *order = [[FDTopicTicketViewController alloc]init];
//            [self.navigationController pushViewController:order animated:YES];
        
        }
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        /** 我的消息 */
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self gotoLoginWithIndex:9];
        }else{
            if (![[EaseMob sharedInstance].chatManager isLoggedIn]) {
                FDHuanXinLoginTool *tool = [FDHuanXinLoginTool sharedInstance];
                [tool huanxinLogin:self];
            }else{
                ConversationListController *list = [[ConversationListController alloc] init];
                [self.navigationController pushViewController:list animated:YES];
            }
            
        }
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        /** 我的饭友 */
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self gotoLoginWithIndex:10];
        }else{
            if (![[EaseMob sharedInstance].chatManager isLoggedIn]) {
                //异步登陆账号
                FDHuanXinLoginTool *tool = [FDHuanXinLoginTool sharedInstance];
                [tool huanxinLogin:self];
            }else{
                ContactListViewController *list = [[ContactListViewController alloc] init];
                [self.navigationController pushViewController:list animated:YES];
            }

        }
        
    }else if (indexPath.section==1&&indexPath.row==2) {
        /** 我的二维码 */
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self gotoLoginWithIndex:11];
        }else{
        FDQrCodeViewController *qr = [[FDQrCodeViewController alloc] initWithNibName:@"FDQrCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qr animated:YES];
        }
    }else if (indexPath.section==1&&indexPath.row==3) {
        /** 激活优惠码 */
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self gotoLoginWithIndex:14];
        }else{
            FDInvitationCodeViewController *qr = [[FDInvitationCodeViewController alloc] initWithNibName:@"FDInvitationCodeViewController" bundle:nil];
            [self.navigationController pushViewController:qr animated:YES];
        }
    }
    else if (indexPath.section==2&&indexPath.row==0) {
        /** 有奖邀请 */
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self gotoLoginWithIndex:12];
        }else{
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"1" forKey:@"invated"];
            FDPersonalCenterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.now_btn.hidden = YES;
            FDInvitationViewController *invitation = [[FDInvitationViewController alloc] init];
            [self.navigationController pushViewController:invitation animated:YES];
            
        
        }
    }else if (indexPath.section==2&&indexPath.row==1) {
        /** 设置 */
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self gotoLoginWithIndex:13];
        }else{
            FDConfigViewController *config = [[FDConfigViewController alloc] init];
            [self.navigationController pushViewController:config animated:YES];
        }
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,13,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,13,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,13,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,13,0,0)];
    }
}

#pragma mark 成长值
- (void)growthTapClick{
    FDGrowingViewController *growthVC = [[FDGrowingViewController alloc] init];
    [self.navigationController pushViewController:growthVC animated:YES];
}
#pragma mark 积分
- (void)integralTapClick{
    FDIntegralViewController *integralVC = [[FDIntegralViewController alloc] init];
    [self.navigationController pushViewController:integralVC animated:YES];
}

#pragma mark 个人信息
- (void)headBtnClick{
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        [self gotoLoginWithIndex:0];
    }else{
        FDUserDetailViewController *userDetail = [[FDUserDetailViewController alloc] init];
        userDetail.isUser = YES;
        userDetail.user = self.model;
        userDetail.kid = [HQDefaultTool getKid];
        [self.navigationController pushViewController:userDetail animated:YES];
    }
}
#pragma mark 登录
- (void)gotoLoginWithIndex:(NSInteger)index{
    FDLoginViewController *verification = [[FDLoginViewController alloc] init];
    verification.isFromList = YES;
    verification.delegate = self;
    verification.info_index = index;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark 扫一扫
- (void)rqCodeBtnClick{
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        [self gotoLoginWithIndex:1];
    }else{
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = @"请前往设置-饭点-打开相机";
            [alertView addButtonWithTitle:@"确定"];
            [alertView show];
            return;
        }
        FDScanViewController *scan = [[FDScanViewController alloc] init];
        [self.navigationController pushViewController:scan animated:YES];
    }
}
#pragma mark 通知
- (void)noticeBtnClick:(UIButton *)button{
    [button clearBadge];
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        [self gotoLoginWithIndex:2];
    }else{
        FDMessageViewController *message = [[FDMessageViewController alloc] init];
        [self.navigationController pushViewController:message animated:YES];
    }
    
}


#pragma mark - FDLoginViewControllerDelegate
- (void)dismissWithIndex:(NSInteger)index{
    ///环信未读
    [self registerNotifications];
    [self setupUnreadMessageCount];
    [self loadDatasource];
    
    UIViewController *viewController;
    if (index==1) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = @"请前往设置-饭点-打开相机";
            [alertView addButtonWithTitle:@"确定"];
            [alertView show];
            return;
        }
        FDScanViewController *scan = [[FDScanViewController alloc] init];
        viewController = scan;
    }
    if (index==2) {
        FDMessageViewController *scan = [[FDMessageViewController alloc] init];
        viewController = scan;
    }
    
    if (index==3) {
        FDMyOrderViewController *scan = [[FDMyOrderViewController alloc] init];
        
        viewController = scan;
    }
    
    if (index==4) {
        FDMyOrderViewController *scan = [[FDMyOrderViewController alloc] init];
        scan.state = @"0";
        viewController = scan;
    }
    if (index==5) {
        FDMyOrderViewController *scan = [[FDMyOrderViewController alloc] init];
        scan.state = @"1";
        viewController = scan;
    }
    if (index==6) {
        FDMyOrderViewController *scan = [[FDMyOrderViewController alloc] init];
        scan.state = @"2";
        viewController = scan;
    }
    if (index==7) {
        FDMyOrderViewController *scan = [[FDMyOrderViewController alloc] init];
        scan.state = @"-2";
        viewController = scan;
    }
    if (index==8) {
        FDWalletViewController *scan = [[FDWalletViewController alloc] init];
        viewController = scan;
    }
    if (index==9) {//我的消息
        ConversationListController *scan = [[ConversationListController alloc] init];
        viewController = scan;
    }
    if (index==10) {//我的饭友
        ContactListViewController *scan = [[ContactListViewController alloc] init];
        viewController = scan;
    }
    if (index==11) {
        FDQrCodeViewController *scan = [[FDQrCodeViewController alloc] initWithNibName:@"FDQrCodeViewController" bundle:nil];
        viewController = scan;
    }
    if (index==12) {
        FDInvitationViewController *scan = [[FDInvitationViewController alloc] init];
        viewController = scan;
    }
    if (index==13) {
        FDConfigViewController *scan = [[FDConfigViewController alloc] init];
        viewController = scan;
    }
    if (index==14) {
        FDInvitationCodeViewController *scan = [[FDInvitationCodeViewController alloc] initWithNibName:@"FDInvitationCodeViewController" bundle:nil];
        viewController = scan;
    }
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --消息数
- (void)setupUntreatedApplyCount{
    
    [[ApplyViewController shareController] loadDataSourceFromLocalDB];
    
    if ([[[ApplyViewController shareController] dataSource] count]!=0) {
        self.hasEMMessage = YES;
    }
    [self.tableView reloadData];
    
}
#pragma mark - 环信未读消息变化
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
    unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    FDPersonalCenterCell *cell =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (unreadCount+[[[ApplyViewController shareController] dataSource] count]>0) {
        cell.now_btn_whith.constant = 20;
        cell.now_btn_height.constant = 20;
        [cell.now_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.now_btn.backgroundColor = [FDUtils colorWithHexString:@"#fd3031"];
        cell.now_btn.layer.cornerRadius = 10;
        cell.now_btn.clipsToBounds = YES;
        cell.now_btn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.hasEMMessage = YES;
        cell.now_btn.hidden=NO;
        [cell.now_btn setTitle:[NSString stringWithFormat:@"%zd",unreadCount+[[[ApplyViewController shareController] dataSource] count]] forState:UIControlStateNormal];
    }else{
        cell.now_btn.hidden=YES;
        self.hasEMMessage = NO;
    }
    
    //NSLog(@"消息数%d",unreadCount);
    
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
    //NSLog(@"%@",NSLocalizedString(@"receiveCmd", @"receive cmd message"));
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        //NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
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
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//    UIApplication *application = [UIApplication sharedApplication];
//        application.applicationIconBadgeNumber += 1;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y>120||scrollView.contentOffset.y<-100) {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        self.title = @"个人中心";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
        [self.rqCode setImage:[UIImage imageNamed:@"tab_ico_saoyisaohei_nor"] forState:UIControlStateNormal];
        [self.notice setImage:[UIImage imageNamed:@"tab_ico_tongzhihei_nor"] forState:UIControlStateNormal];
        [self.navigationController.navigationBar lt_reset];
    }else {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.rqCode setImage:[UIImage imageNamed:@"tab_ico_saoyisao_nor"] forState:UIControlStateNormal];
        [self.notice setImage:[UIImage imageNamed:@"tab_ico_tongzhi_nor"] forState:UIControlStateNormal];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    
    
}
@end
