//
//  FDUserDetailViewController.m
//  Diandian1.4Test
//
//  Created by lutao on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDUserDetailViewController.h"
#import "UINavigationBar+Awesome.h"
#import "FDUserDetailHeaderView.h"
#import "FDInformationViewController.h"
#import "HttpUserInfo.h"
#import "FDInputViewController.h"
#import "EaseMob.h"
#import "ChatViewController.h"
#import "InvitationManager.h"
#import "ApplyViewController.h"
#import "InvitationManager.h"
#import "EaseMob.h"
#import "HQIMFriendsTool.h"
#import "FDLoginViewController.h"
#import "FDUserDetailTableViewCell.h"
#import "SJAvatarBrowser.h"

@interface FDUserDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

{
    UIButton *deleteFriend;
    
}

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,weak)UIButton *addFriend_Btn;
@property (nonatomic ,strong) FDUserDetailHeaderView *editInfoHeaderView;

@end

@implementation FDUserDetailViewController

- (FDUserDetailHeaderView *)editInfoHeaderView{
    if (!_editInfoHeaderView) {
        _editInfoHeaderView = [FDUserDetailHeaderView editInfoHeaderView];
        _editInfoHeaderView.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    }
    
    return _editInfoHeaderView;
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //导航栏设置成透明色后   还有根线  这句代码就是去线的
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    UIColor *color = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setHeadView];
    /* 获取个人资料 **/
    HttpUserInfo *userInfo = [HttpUserInfo sharedInstance];
    [userInfo loadUserDetailViewController:self kid:self.kid];
    
}

- (void)loadUserInfo{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HttpUserInfo *userInfo = [HttpUserInfo sharedInstance];
        [userInfo loadUserDetailViewController:self kid:self.kid];
        
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.kid isEqualToString:[HQDefaultTool getKid]]) {//我自己
            self.isUser = YES;
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baw_ico_bj"] style:UIBarButtonItemStylePlain target:self action:@selector(editBtnClick)];
            self.navigationItem.rightBarButtonItem= backButton;
        }else{//他人
            ///我的好友
            if ([self didBuddyExist:self.kid]){
                
                UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baw_ico_more"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteBtnClick)];
                self.navigationItem.rightBarButtonItem= backButton;
                
                
            }else{
                self.navigationItem.rightBarButtonItem = nil;
                deleteFriend.hidden = YES;
                
            }
            
            
            
        }
        
    });
}


- (void)setHeadView{
    
    self.editInfoHeaderView.userName.text = self.user.nick_name;
    if (self.user.nick_name.length>10) {
        self.editInfoHeaderView.userName.text =[NSString stringWithFormat:@"%@...",[self.user.nick_name substringToIndex:10]];
    }
    if (IPHONE4||IPHONE5) {
        self.editInfoHeaderView.homeTown_pointH.constant = 40;
        self.editInfoHeaderView.homeTown_pointV.constant = 100;
    }
    
    if (IPhone6) {
        self.editInfoHeaderView.homeTown_pointH.constant = 50;
        self.editInfoHeaderView.homeTown_pointV.constant = 115;
    }
    if (IPHONE5||IPHONE4) {
        self.editInfoHeaderView.nickNameH.constant = 40;
    }
    if (IPhone6||IPhone6Plus) {
        self.editInfoHeaderView.nickNameH.constant = 50;
    }
    
    if (self.user) {
        [_editInfoHeaderView.rotatingView sd_setImageWithURL:[NSURL URLWithString:self.user.head] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _editInfoHeaderView.rotatingView.image = image;
        }];
        _editInfoHeaderView.rotatingView.userInteractionEnabled = YES;
        [_editInfoHeaderView.rotatingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
    }
    if (self.user.self_desc) {
        self.editInfoHeaderView.self_desc.text = self.user.self_desc;
    }
    CGRect  descRect = [self.user.self_desc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    if (descRect.size.height>20) {
        self.editInfoHeaderView.self_desc.textAlignment = NSTextAlignmentLeft;
    }else{

        self.editInfoHeaderView.self_desc.textAlignment = NSTextAlignmentCenter;
    }
    
    if ([self.user.sex isEqualToString:@"1"]) {//性别
        self.editInfoHeaderView.sexImage.image = [UIImage imageNamed:@"baw_ico_xb_sele"];
        self.editInfoHeaderView.sexImage.hidden = NO;
    } else if ([self.user.sex isEqualToString:@"2"]) {
        self.editInfoHeaderView.sexImage.image = [UIImage imageNamed:@"baw_ico_xb_nor"];
        self.editInfoHeaderView.sexImage.hidden = NO;
    }else{
        self.editInfoHeaderView.sexImage.hidden = YES;
    }
    if ([self.user.ages isEqualToString:@""]) {//年龄
        self.editInfoHeaderView.ageText.text = self.user.ages_default;
    }else{
        self.editInfoHeaderView.ageText.text = self.user.ages;
    }
    if (self.user.hometown) {//家乡
        NSArray *array = [self.user.hometown componentsSeparatedByString:@"-"];
        if (array.count == 2) {
            self.editInfoHeaderView.provinceText.text = array[0];
            self.editInfoHeaderView.cityText.text = array[1];
            self.editInfoHeaderView.cityText.hidden = NO;
        }else{
            self.editInfoHeaderView.provinceText.text = self.user.hometown_default;
            self.editInfoHeaderView.cityText.hidden = YES;
            
        }
        
        
    }else{
        self.editInfoHeaderView.provinceText.text = self.user.hometown_default;
        self.editInfoHeaderView.cityText.hidden = YES;
    }
    
    if (self.user.constellation&&![self.user.constellation isEqualToString:@""]) {//星座
        
        NSArray *starArray=@[@{@"title":@"白羊座",@"image":@"constellation_0",@"date":@"03/21-04/19"},@{@"title":@"金牛座",@"image":@"constellation_1",@"date":@"04/20-05/20"},@{@"title":@"双子座",@"image":@"constellation_2",@"date":@"05/21-06/21"},@{@"title":@"巨蟹座",@"image":@"constellation_3",@"date":@"06/22-07/22"},@{@"title":@"狮子座",@"image":@"constellation_4",@"date":@"07/23-08/22"},@{@"title":@"处女座",@"image":@"constellation_5",@"date":@"08/23-09/22"},@{@"title":@"天秤座",@"image":@"constellation_6",@"date":@"09/23-10/23"},@{@"title":@"天蝎座",@"image":@"constellation_7",@"date":@"10/24-11/22"},@{@"title":@"射手座",@"image":@"constellation_8",@"date":@"11/23-12/21"},@{@"title":@"摩羯座",@"image":@"constellation_9",@"date":@"12/22-01/19"},@{@"title":@"水瓶座",@"image":@"constellation_10",@"date":@"01/20-02/18"},@{@"title":@"双鱼座",@"image":@"constellation_11",@"date":@"02/10-03/20"}];
        
        
        
        for (NSDictionary *dict in starArray) {
            if ([dict[@"title"] isEqualToString:[HQDefaultTool getConstellation]]) {
                [self.editInfoHeaderView.xingzuoBtn setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
                self.editInfoHeaderView.xingzuoText.text = self.user.constellation;
                break;
            }else{
                self.editInfoHeaderView.xingzuoText.text = self.user.constellation_default;
                [self.editInfoHeaderView.xingzuoBtn setImage:[UIImage imageNamed:@"grzx_ico_sexz"] forState:UIControlStateNormal];
            }
        }
        
    }else{
        self.editInfoHeaderView.xingzuoText.text = self.user.constellation_default;
        [self.editInfoHeaderView.xingzuoBtn setImage:[UIImage imageNamed:@"grzx_ico_sexz"] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //加这个方法防崩
    [self.navigationController.navigationBar lt_reset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    deleteFriend.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserInfo) name:userInfoLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserInfo) name:deleteMyFriend object:nil];
    
    deleteFriend = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW-75, 50, 67, 26)];
    [deleteFriend setBackgroundImage :[UIImage imageNamed:@"baw_bg_schy_pre"] forState:UIControlStateNormal];
    [deleteFriend setTitle:@"删除好友" forState:UIControlStateNormal];
    deleteFriend.titleEdgeInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    deleteFriend.titleLabel.font = [UIFont systemFontOfSize:15];
    deleteFriend.hidden = YES;
    [deleteFriend addTarget:self action:@selector(deleteMyFriend) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:deleteFriend];
    
    if ([self.kid isEqualToString:[HQDefaultTool getKid]]) {//我自己
        self.isUser = YES;
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baw_ico_bj"] style:UIBarButtonItemStylePlain target:self action:@selector(editBtnClick)];
        self.navigationItem.rightBarButtonItem= backButton;
    }else{//他人
        ///我的好友
        if ([self didBuddyExist:self.kid]){
            
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baw_ico_more"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteBtnClick)];
            self.navigationItem.rightBarButtonItem= backButton;
            
            
        }
        
        
        
    }
    
    
    self.view.backgroundColor = Background_Color;
    
    [self setupTableView];
    
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.footerTableView.showsHorizontalScrollIndicator=NO;
    self.footerTableView.showsVerticalScrollIndicator=NO;

    
}
#pragma mark --点击
- (void)deleteBtnClick{
    deleteFriend.hidden = !deleteFriend.hidden;
    
}

#pragma mark -- 删除好友
- (void)deleteMyFriend{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定删除好友？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    deleteFriend.hidden = YES;
    
}
#pragma mark-- 编辑个人资料
- (void)editBtnClick{
    FDInformationViewController *vc= [[FDInformationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 0;
    tableView.backgroundColor = Background_Color;
    self.tableView = tableView;
    
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView ==self.tableView) {
        return 0;
    }
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDUserDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *title = @[@"职业",@"公司",@"写字楼"];
    
    
    
    NSArray *imageArr = @[@"baw_ico_zhiye_nor",@"baw_ico_gongsi_nor",@"baw_ico_lou_nor"];
    if (!cell) {
        
        cell = [[FDUserDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = title[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor =[UIColor colorWithRed:51.0/255.0 green:51.0/255.0  blue:51.0/255.0  alpha:1];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.textColor =[UIColor colorWithRed:102.0/255.0 green:102.0/255.0  blue:102.0/255.0  alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 43.5, [UIScreen mainScreen].bounds.size.width-60-30, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1];
        [cell.contentView addSubview:line];
    }
    NSMutableArray *detailtitle = [NSMutableArray array];
    
    if (self.user) {
        if ([self.user.occupation isEqualToString:@""]||!self.user.occupation) {
            [detailtitle addObject:self.user.occupation_default];
        }else{
            [detailtitle addObject:[NSString stringWithFormat:@"%@-%@",self.user.industry,self.user.occupation]];
        }
        if ([self.user.company isEqualToString:@""]||!self.user.company) {
            [detailtitle addObject:self.user.company_default];
        }else{
            [detailtitle addObject:self.user.company];
        }
        [detailtitle addObject:self.user.office_build];
        cell.detailTextLabel.text = detailtitle[indexPath.row];
    }
    
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2)];
    
    if (tableView == self.tableView) {
        
        footerView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1];
        UIView *tableBgView ;
        UITableView *footerTableView;
        if ([self.kid isEqualToString:[HQDefaultTool getKid]]) {
            tableBgView = [self makeShadowView:CGRectMake(25, -38, [UIScreen mainScreen].bounds.size.width-50,276) andShdowColor:[UIColor lightGrayColor]];
            footerTableView = [self makeTableView:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-50,234)];
        }else{
            
            tableBgView= [self makeShadowView:CGRectMake(25, -38, [UIScreen mainScreen].bounds.size.width-50,286) andShdowColor:[UIColor lightGrayColor]];
            footerTableView = [self makeTableView:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-50,278)];
        }
        [footerView addSubview:tableBgView];
        
        
        self.footerTableView = footerTableView;
        
        [tableBgView addSubview:self.footerTableView];
    }else{
        footerView.backgroundColor = [UIColor whiteColor];
        
        if([self.kid isEqualToString:[HQDefaultTool getKid]]){
            
            
        }else{
            
            UIView *bgView = [self makeShadowView:CGRectMake(([UIScreen mainScreen].bounds.size.width -180-60)/2, 20, 180, 44) andShdowColor:[FDUtils colorWithHexString:@"#ef2840"]];
            
            [footerView addSubview:bgView];
            
            UIButton *addFriend_Btn;
            if ([self didBuddyExist:self.kid]) {
                
                addFriend_Btn = [self makeAddBtn:@"发消息给Ta"];
                
            }
            else if ([self loadDataSourceFromLocalDB]){
                
                addFriend_Btn = [self makeAddBtn:@"通过验证"];
                
            }
            
            else {
                addFriend_Btn = [self makeAddBtn:@"加Ta为饭友"];
                
            }
            [bgView addSubview:addFriend_Btn];
            self.addFriend_Btn = addFriend_Btn;
            
        }
        
        
        
    }
    
    return footerView;
}
#pragma mark--判断是否正在加我为好友
- (BOOL)loadDataSourceFromLocalDB
{
    
    
    NSArray * applyArray = [[InvitationManager sharedInstance] applyEmtitiesWithloginUser:[HQDefaultTool getKid]];
    
    for (ApplyEntity *entity in applyArray) {
        if ([entity.applicantUsername isEqualToString:self.user.kid]) {
            return YES;
        }
    }
    
    
    return NO;
}

- (BOOL)didBuddyExist:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState != eEMBuddyFollowState_NotFollowed) {
            return YES;
        }
    }
    return NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        
        CGRect  descRect;
        if (self.user.self_desc) {
             descRect = [self.user.self_desc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        }
        
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, [UIScreen mainScreen].bounds.size.width+descRect.size.height+20)];
        UIImageView *image = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"baw_bg_xingtu_bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:210]];
        image.frame = CGRectMake(0, 0, ScreenW, [UIScreen mainScreen].bounds.size.width+descRect.size.height+20);
        [head addSubview:image];
        [head addSubview:self.editInfoHeaderView];
        return head;
    }
    return nil;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView ==self.tableView) {
        if (IPHONE4) {
            return [UIScreen mainScreen].bounds.size.width;
        }
        return [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width;
    }
    if ([self.kid isEqualToString:[HQDefaultTool getKid]]) {
        return 60;
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView ==self.tableView) {
        if (self.user.self_desc) {
            
            CGRect  descRect = [self.user.self_desc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            return [UIScreen mainScreen].bounds.size.width+descRect.size.height+20;
            
        }
        return [UIScreen mainScreen].bounds.size.width;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 48;
    
}
- (UITableView *)makeTableView:(CGRect)frame{
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.layer.cornerRadius = 5;
    tableView.layer.masksToBounds = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
    
}
- (UIView *)makeShadowView:(CGRect)frame andShdowColor:(UIColor *)color{
    
    UIView *bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    bgView.layer.shadowOffset = CGSizeMake(0,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    bgView.layer.shadowRadius = 4;//阴影半径，默认3
    
    return bgView;
}

- (UIButton *)makeAddBtn:(NSString *)title{
    
    UIButton *addFriend_Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 44)];
    //    [addFriend_Btn setBackgroundImage:[UIImage imageNamed:@"list_btn_fsxx_nor"] forState:UIControlStateNormal];
    addFriend_Btn.backgroundColor = [FDUtils colorWithHexString:@"#ef2840"];
    addFriend_Btn.layer.cornerRadius = 3;
    addFriend_Btn.layer.masksToBounds = YES;
    [addFriend_Btn setTitle:title forState:UIControlStateNormal];
    
    [addFriend_Btn addTarget:self action:@selector(addFriend_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return addFriend_Btn;
    
}
- (void)chatWithFriend:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"发消息给Ta"]){
        
        ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:self.user.kid conversationType:eConversationTypeChat];
        //        chatController.title = self.user.nick_name;
        [chatController addTitleViewWithTitle:self.user.nick_name];
        [self.navigationController pushViewController:chatController animated:YES];
    }
    
    
}
- (void)addFriend_BtnClick:(UIButton *)sender{
    
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        FDLoginViewController *verification = [[FDLoginViewController alloc] init];
        verification.isFromUserInfo = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }else{
        
        if ([sender.titleLabel.text isEqualToString:@"加Ta为饭友"]) {
            FDInputViewController *input = [[FDInputViewController alloc] init];
            input.navtitle = @"饭友验证";
            input.attribute = @"你需要发验证申请，需对方通过";
            input.placehorder = @"验证申请";
            input.NumberCounts = 20;
            input.index = 4;
            input.kid = self.user.kid;
            input.submitStr = @"提交";
            input.url = self.user.head;
            input.nickname = self.user.nick_name;
            [self presentViewController:input animated:YES completion:nil];
            
        }
        
        if ([sender.titleLabel.text isEqualToString:@"发消息给Ta"]){
            
            
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:self.user.kid conversationType:eConversationTypeChat];
            //            chatController.title = self.user.nick_name;
            [chatController addTitleViewWithTitle:self.user.nick_name];
            [self.navigationController pushViewController:chatController animated:YES];
        }
        
        if ([sender.titleLabel.text isEqualToString:@"通过验证"]){
            EMError *error;
            NSArray * applyArray = [[InvitationManager sharedInstance] applyEmtitiesWithloginUser:[HQDefaultTool getKid]];
            
            for (ApplyEntity *entity in applyArray) {
                if ([entity.applicantUsername isEqualToString:self.user.kid]) {
                    [[EaseMob sharedInstance].chatManager acceptBuddyRequest:entity.applicantUsername error:&error];
                    if (!error) {
                        
                        [[InvitationManager sharedInstance] removeInvitation:entity loginUser:[HQDefaultTool getKid]];
                        [sender setTitle:@"发消息给Ta" forState:UIControlStateNormal];
                        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baw_ico_more"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteBtnClick)];
                        self.navigationItem.rightBarButtonItem= backButton;
                        UsersModel *model = [[UsersModel alloc]init];
                        model.kid = self.user.kid;
                        model.nickname = self.user.nick_name;
                        model.url = self.user.head;
                        [[HQIMFriendsTool sharedInstance] addFriendsName:model idString:self.user.kid];
                        
                        
                    }
                    else{
                        [self showHint:NSLocalizedString(@"acceptFail", @"accept failure")];
                    }
                }
            }
            
        }
        
        
    }
    
    
    
}

#pragma mark -- 通过验证

- (void)agreeAddFriend:(UIButton *)sender{
    EMError *error;
    NSArray * applyArray = [[InvitationManager sharedInstance] applyEmtitiesWithloginUser:[HQDefaultTool getKid]];
    
    for (ApplyEntity *entity in applyArray) {
        if ([entity.applicantUsername isEqualToString:self.user.kid]) {
            [[EaseMob sharedInstance].chatManager acceptBuddyRequest:entity.applicantUsername error:&error];
            if (!error) {
                
                [[InvitationManager sharedInstance] removeInvitation:entity loginUser:[HQDefaultTool getKid]];
                [sender setTitle:@"发消息给Ta" forState:UIControlStateNormal];
                UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baw_ico_more"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteBtnClick)];
                self.navigationItem.rightBarButtonItem= backButton;
                
            }
            else{
                [self showHint:NSLocalizedString(@"acceptFail", @"accept failure")];
            }
        }
    }
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager removeBuddy:self.user.kid removeFromRemote:YES error:&error];
        if (!error) {
            [[EaseMob sharedInstance].chatManager removeConversationByChatter:self.user.kid deleteMessages:YES append2Chat:YES];
            [self.addFriend_Btn setTitle:@"加Ta为饭友" forState:UIControlStateNormal];
            [self.addFriend_Btn addTarget:self action:@selector(addFriend_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = nil;
            NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            
            for (int i = 0; i <navigationarray.count; i++) {
                
                UIViewController *controller = [navigationarray objectAtIndex:i];
                if ([controller isKindOfClass:[ChatViewController class]]){
                    [navigationarray removeObjectAtIndex:i];
                    self.navigationController.viewControllers = navigationarray;
                }
                
            }
            
        }
        
        
    }
    
}
#pragma mark -- 点击图片查看大图
- (void)imageClick:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageView = (UIImageView *)tap.view;
    [SJAvatarBrowser showImage:imageView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    deleteFriend.hidden = YES;
    if (scrollView.contentOffset.y<-64) {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        self.title = @"用户详情";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
        [self.navigationController.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"message_btn_edi_nor"]];
        [self.navigationController.navigationBar lt_reset];
    }else {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"message_btn_edi_nor"]];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    
    
}

@end
