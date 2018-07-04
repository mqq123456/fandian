//
//  FDTicket_New_ViewController.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTicket_New_ViewController.h"
#import "FDTicket_TopDetail_Cell.h"
#import "FDTicket_FanYou_Cell.h"
#import "FDTicket_Bottom_Cell.h"
#import "FDTicketHeadView.h"
#import "TablesModel.h"
#import "HttpUserOrderDetail.h"
#import "FDMerchantIntroductionViewController.h"
#import "HttpOrderCancel.h"
#import "FDQRCodeView.h"
#import "QRCodeGenerator.h"
#import "FDTicketFooterView.h"
#import "membersModel.h"
#import "UIButton+WebCache.h"
#import "FDTicketPromptCell.h"
#import "UIPopoverListView.h"
#import "FDInputViewController.h"
#import "ChatViewController.h"
#import "HttpOrderSelfDesc.h"
#import "HttpImGroupId.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialData.h"
#import "FDUserDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "FDPersonalCenterCell.h"
#import "FDMerchantInfoCell.h"
#import "FDShareView.h"
#import "FDHuanXinLoginTool.h"
#import "FDTopicWaitingView.h"

@interface FDTicket_New_ViewController ()<UIAlertViewDelegate,UMSocialUIDelegate,UIActionSheetDelegate>
{
    NSString *table_id;
    NSString * share_type;///2.普通下单分享抵扣券 3.分享一元餐券， 4.点击话题饭票右上角 5.分享话题详情
    
}
///弹出的二维码视图
@property (nonatomic ,weak)   FDQRCodeView *qrCodeView;
@property (nonatomic ,strong) FDShareView *shareTicketView;///底部弹起


@end

@implementation FDTicket_New_ViewController
- (FDTopicWaitingView *)topicwaitingView{
    if (!_topicwaitingView) {
        _topicwaitingView = [FDTopicWaitingView selfWaitingView];
        _topicwaitingView.frame = CGRectMake(0, 0, ScreenW, 93);
    }
    return _topicwaitingView;
}
#pragma mark 底部弹起，右上角分享或者发话题
- (FDShareView *)shareTicketView{
    NSString *share_title;
    
    NSString *share_url;
    
    NSString *share_content;
    if (_shareTicketView==nil) {
        _shareTicketView = [FDShareView shareView];
        _shareTicketView.delegate = self;
        
    }
    if ([share_type isEqualToString:@"5"]) {///5话题饭票，分享出去的事话题详情
        share_title = self.orderModel.weixin_topic_title;
        share_content = self.orderModel.weixin_topic_content;
        share_url = self.orderModel.weixin_topic_url;
        _shareTicketView.type = @"5";
    }else if ([share_type isEqualToString:@"4"]) {///4.右上角，饭票，分享出去的是饭票
        share_title = self.orderModel.weixin_share_title;
        share_content = self.orderModel.weixin_share_content;
        share_url = self.orderModel.weixin_share_url;
        _shareTicketView.type = @"4";
    
    }else if ([share_type isEqualToString:@"3"]) {///3.分享一元餐券
        share_title = self.orderModel.weixin_empty_seat_title;
        share_content = self.orderModel.weixin_empty_seat_content;
        share_url = self.orderModel.weixin_empty_seat_url;
        _shareTicketView.type = @"3";
        
    }
    else if ([share_type isEqualToString:@"2"]) {///2.普通下单分享抵扣券
        share_title = self.orderModel.bag_title;
        share_content = self.orderModel.bag_content;
        
        share_url = self.orderModel.bag_url;
        _shareTicketView.type = @"2";
        
    }
    
    _shareTicketView.umURL = share_url;
    _shareTicketView.title = share_title;
    _shareTicketView.contText = share_content;
    _shareTicketView.topic_id = self.orderModel.topic_id;
    _shareTicketView.group_share_title = self.orderModel.group_share_title;
    
    _shareTicketView.group_share_hint = self.orderModel.group_share_hint;
    
    _shareTicketView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    return _shareTicketView;
}
#pragma mark 红包视图
- (FDBonusView *)bonusView{
    if (_bonusView == nil) {
        _bonusView = [FDBonusView selfBounsView];
        _bonusView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    }
    return _bonusView;
    
}

#pragma mark 一元饭票视图
- (FDTicketShareView *)shareView{
    if (_shareView==nil) {
        _shareView = [FDTicketShareView ticketShareView:self.orderModel.weixin_empty_seat_url andTitle:self.orderModel.weixin_empty_seat_title andContent:self.orderModel.weixin_empty_seat_content];
        [_shareView.shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];

    }
    _shareView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    return _shareView;
}


#pragma mark -未分桌之前，等待页面
- (FDOderWaitingView *)waitingView{
    if (!_waitingView) {
        _waitingView = [FDOderWaitingView selfWaitingView];
        _waitingView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64);
        
    }
    if (IPHONE4) {
        _waitingView.TopContains.constant = 5;
    }
    return _waitingView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///就餐凭证流量
    [MobClick event:@"pv_certificate"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    [self.menu removeFromSuperview];
    [self.qrCodeView removeFromSuperview];
    [self.bonusView removeFromSuperview];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(descriptionMySelfBack:) name:DescriptionMySelf object:nil];
    //每个分区中cell的个数
    _rowInSectionArray = [NSMutableArray array];
    //这个用于判断展开还是缩回当前section的cell
    _selectedArray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    if (self.isFromPay) {
        ///下单成功之后，跳转过来
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back3"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
        backButton.imageInsets = UIEdgeInsetsMake(0, -15, 0, 15);
        self.navigationItem.leftBarButtonItem= backButton;
        
    }
    [self loadUserOrderDetail];
    
    self.tableView.backgroundColor = Background_Color;
    ///导航设为白色
    [self.view addSubview:[FDUtils addNavBarView]];
    
    [self addTitleViewWithTitle:@"饭票"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //self.tableView.tableHeaderView = self.topicwaitingView;
    
    
}

#pragma mark - 加载订单详情
- (void)loadUserOrderDetail{
    HttpUserOrderDetail *tool = [HttpUserOrderDetail sharedInstance];
    [tool loadUserOrderDetail:self];
}

#pragma mark  一分钟刷新一次
- (void)loadUserOrderDetailRepeats{
    HttpUserOrderDetail *tool = [HttpUserOrderDetail sharedInstance];
    [tool loadUserOrderDetailRepeats:self];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 91;
        }
        if (indexPath.row == 2) {
            return 73;
        }
        return 51;
    }
    else if (indexPath.section ==self.orderModel.tables.count+1){
        ///提示
        NSString *str = self.orderModel.order_tips[indexPath.row];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-60, 1000) lineBreakMode:NSLineBreakByTruncatingTail];
        return size.height+10;
        
    }
    else{
        if (indexPath.row == [_rowInSectionArray[indexPath.section-1]count]) {
            if ([self.orderModel.is_bz integerValue]==1) {
               return 0;
            }
            return 50;
        }
        membersModel *model = _rowInSectionArray[indexPath.section-1][indexPath.row];
        NSString *self_desc;
        ///服务端未给数据的话容错信息
        if ([model.self_desc isEqualToString:@""]||!model.self_desc) {
            if ([model.kid isEqualToString:[HQDefaultTool getKid]]) {
                self_desc = @"一句话描述下你自己，方便同桌的人认出你";
            }else{
                
                self_desc = @"他还没有描述自己，你们猜猜他是谁？";
            }
            
        }else{
            self_desc = [NSString stringWithFormat:@"“%@”",model.self_desc];
            
        }
        CGSize size = [self_desc sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-91, 1000) lineBreakMode:NSLineBreakByTruncatingTail];
        return 94+size.height;
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        if (indexPath.row == 0) {
            FDTicket_TopDetail_Cell *cell = [FDTicket_TopDetail_Cell cellWithTableView:tableView];
            
            cell.merchant_name.text = self.orderModel.merchant_name;
            
            cell.merchant_phone.text =[NSString stringWithFormat:@"餐厅电话：%@",self.orderModel.phone];
            cell.merchant_phone.userInteractionEnabled = NO;
            return cell;
        }else{
            NSArray *array = @[@"餐厅菜单及地址",@"票号及二维码"];
            NSArray *imageArray = @[@"bow_ico_ctcdjdz",@"bow_ico_phjewm"];
            FDPersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDPersonalCenterCell"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FDPersonalCenterCell" owner:nil options:nil]lastObject];
            }
            cell.icon.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row-1]];
            cell.title.text = [array objectAtIndex:indexPath.row-1];
            cell.title.textColor = [FDUtils colorWithHexString:@"#666666"];
            cell.title.font = [UIFont systemFontOfSize:15];

            cell.labelLeftContain.constant = 13;
            
            if (indexPath.row == 2) {
                cell.iconCenter.constant = -14;
                cell.hintLabel.hidden = NO;
                cell.hintLabel.text = self.orderModel.scan_code_hint;
            }else{
            
                cell.iconCenter.constant = 0;
                cell.hintLabel.hidden = YES;
                cell.hintLabel.text = @"";
            }
            [cell layoutIfNeeded];
            if(indexPath.row == 1 ){
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, ScreenW-50, 1)];
                lineView.backgroundColor = [FDUtils colorWithHexString:@"EDEDED"];
                [cell.contentView addSubview:lineView];
            }
            return cell;
        
        }

        
    }else if(indexPath.section == self.orderModel.tables.count +1){
        ///底部提示cell
        FDTicketPromptCell *cell = [FDTicketPromptCell cellWithTableView:tableView];
        cell.title.text = self.orderModel.order_tips[indexPath.row];
        if ([self.orderModel.order_tips[indexPath.row] hasSuffix:[HQDefaultTool getService]]) {
            NSMutableDictionary *heightLightDict=[NSMutableDictionary dictionary];
            heightLightDict[NSFontAttributeName]=[UIFont systemFontOfSize:14];
            heightLightDict[NSForegroundColorAttributeName]=[FDUtils colorWithHexString:@"#666666" alpha:0.5];
            NSMutableAttributedString *attributeTitle=[[NSMutableAttributedString alloc] initWithString:self.orderModel.order_tips[indexPath.row] attributes:heightLightDict];
            
            NSRange firshRange=[self.orderModel.order_tips[indexPath.row] rangeOfString:[HQDefaultTool getService]];
            [attributeTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:firshRange];
            [attributeTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:firshRange];
            [cell.title setAttributedText:attributeTitle];
            cell.title.userInteractionEnabled = YES;
            cell.userInteractionEnabled = YES;
            [cell.title addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneClick)]];
        }else{
            cell.title.userInteractionEnabled = NO;
        }
        return cell;
    }else{
        
        ///还有几个路人甲
        if (indexPath.row == [_rowInSectionArray[indexPath.section-1] count]) {
            if ([self.orderModel.is_bz integerValue]==1) {
                return [[UITableViewCell alloc]init];
            }else{
                TablesModel *model = self.orderModel.tables[indexPath.section-1];
                FDTicket_Bottom_Cell *cell = [FDTicket_Bottom_Cell cellWithTableView:tableView];
                if ([model.total_people intValue]-[model.total_order_people intValue]==0) {
                    cell.haiyou.hidden = YES;
                    cell.lurenjia.hidden = YES;
                    cell.peoples.hidden = YES;
                }else{
                    cell.haiyou.hidden = NO;
                    cell.lurenjia.hidden = NO;
                    cell.peoples.hidden = NO;
                    cell.peoples.text = [NSString stringWithFormat:@"%d",[model.total_people intValue]-[model.total_order_people intValue]];
                }
                
                if ([model.group_id integerValue] == 0) {
                    ///没有讨论组
                    cell.gotoGroupBtn.hidden = YES;
                }else{
                    cell.gotoGroupBtn.hidden = NO;
                    cell.gotoGroupBtn.tag = indexPath.section-1;
                    [cell.gotoGroupBtn addTarget:self action:@selector(gotoGroupBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                return cell;
            }
        }
        
        else
        {
            
            FDTicket_FanYou_Cell *cell = [FDTicket_FanYou_Cell cellWithTableView:tableView];
            membersModel *model = _rowInSectionArray[indexPath.section -1][indexPath.row];
            cell.editBtn.tag = indexPath.section-1;
            ///显示编辑按钮
            if ([model.kid isEqualToString:[HQDefaultTool getKid]]) {
                cell.editBtn.hidden = NO;
                [cell.editBtn addTarget:self action:@selector(editMySelfBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell.editBtn.hidden = YES;
            }
            cell.username.text = model.nick_name;
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                cell.icon.image = image;
            }];
            cell.icon.kid = model.kid;
            
            if ([model.self_desc isEqualToString:@""]) {
                if ([model.kid isEqualToString:[HQDefaultTool getKid]]) {
                    cell.desc_label.text = @"一句话描述下你自己，方便同桌的人认出你";
                }else{
                    
                    cell.desc_label.text = @"他还没有描述自己，猜猜他是谁？";
                }
                
            }else{
                cell.desc_label.text = [NSString stringWithFormat:@"“%@”",model.self_desc];
                
            }
            if ([model.sex intValue]==2){//女
                
                cell.age_sex.backgroundColor = [FDUtils colorWithHexString:@"#f86581"];
                
                [cell.age_sex setImage:[UIImage imageNamed:@"bow_ico_nvxingtubiao_nor"] forState:UIControlStateNormal];
                
                [cell.age_sex setTitle:[NSString stringWithFormat:@" %@ ",model.age] forState:UIControlStateNormal];
                if (!model.age||[model.age isEqualToString:@""]) {
                    
                    cell.age_sexWidth.constant = 10;
                
                }else{
                    
                    cell.age_sexWidth.constant = 44;
                    
                }
                
            }
            else if ([model.sex intValue]==1){//男
                
                cell.age_sex.backgroundColor = [FDUtils colorWithHexString:@"#4bcde4"];
                
                [cell.age_sex setImage:[UIImage imageNamed:@"bow_ico_nanxingtubiao_nor"] forState:UIControlStateNormal];
                
                [cell.age_sex setTitle:[NSString stringWithFormat:@" %@ ",model.age] forState:UIControlStateNormal];
                if (!model.age||[model.age isEqualToString:@""]) {
                    
                    cell.age_sexWidth.constant = 10;
                    
                }else{
                    
                    cell.age_sexWidth.constant = 44;
                    
                }
  
            }else{///无性别
                cell.age_sex.backgroundColor = [FDUtils colorWithHexString:@"#4bcde4"];
                
                [cell.age_sex setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

                [cell.age_sex setTitle:[NSString stringWithFormat:@" %@ ",model.age] forState:UIControlStateNormal];

                if (!model.age||[model.age isEqualToString:@""]) {
                    
                    cell.age_sexWidth.constant = 0;
                    
                }else{
                    
                    cell.age_sexWidth.constant = 30;
                    
                }
            }
            [cell layoutIfNeeded];


            NSString *occupation_industry;
            
            if (!model.company||[model.company isEqualToString:@""]) {///公司为空
                
                if (!model.industry||[model.industry isEqualToString:@""]) {///职业为空
                    
                    occupation_industry = @"";
                }else{
                    occupation_industry = [NSString stringWithFormat:@"%@",model.industry];

                
                }
                
            }else {///公司不为空
                
                if (!model.industry||[model.industry isEqualToString:@""]) {///职业为空
                    
                    occupation_industry = [NSString stringWithFormat:@"%@",model.company];
                }else{
                    occupation_industry = [NSString stringWithFormat:@"%@ - %@",model.company,model.industry];
                    
                    
                }
                
            }
            
            CGRect  occupation_industryRect = [occupation_industry boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-140, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
            
            if(occupation_industryRect.size.width>[UIScreen mainScreen].bounds.size.width-140){
            
                cell.occupation_industryWidth.constant = [UIScreen mainScreen].bounds.size.width-140;
            }else{
            
                cell.occupation_industryWidth.constant = occupation_industryRect.size.width+4;
            }
            if(occupation_industryRect.size.width<8){
                cell.age_sexLeft.constant = 0;
            }else{
                cell.age_sexLeft.constant = 5;
            }
            
            cell.occupation_industry.text =occupation_industry;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconClick:)];
            [cell.icon addGestureRecognizer:tap];
            cell.icon.userInteractionEnabled = YES;
            return cell;
        }
        
        
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([self.orderModel.table_alloc_left_time integerValue]>0){
//        
//        return 0;
//        
//    }
    
    //判断section的标记是否为1,如果是说明为展开,就返回真实个数,如果不是就说明是缩回,返回0.
    
    if (section == 0) {
        return 3;
    }
    else if(section == self.orderModel.tables.count +1){
        return self.orderModel.order_tips.count;
    }
    
    else if ([_selectedArray[section-1] isEqualToString:@"1"])
    {
        
        TablesModel *model = self.orderModel.tables[section-1];
        ///还有几个路人甲，，如果路人甲人数＝＝0不显示下面的
        if ([model.total_people intValue]-[model.total_order_people intValue]==0&&[model.group_id integerValue] == 0) {
            return [_rowInSectionArray[section-1] count];
        }
        return [_rowInSectionArray[section-1] count]+1;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self merchant_phoneBtnClick];
            
        }
        
        else if (indexPath.row==1) {
            /**餐厅详情*/
            FDMerchantIntroductionViewController *detail = [[FDMerchantIntroductionViewController alloc] init];
            MerchantModel *model = [[MerchantModel alloc] init];
            model.merchant_id =self.orderModel.merchant_id;
            model.merchant_name = self.orderModel.merchant_name;
            model.lat = self.orderModel.lat;
            model.lng = self.orderModel.lng;
            model.address = self.orderModel.address;
            model.icon = self.orderModel.icon;
            detail.latString = self.orderModel.lat;
            detail.lngString = self.orderModel.lng;
            detail.local_lat = [HQDefaultTool getLat];
            detail.local_lng = [HQDefaultTool getLng];
            detail.local = @"1";
            detail.model = model;
            detail.kdate = self.orderModel.order_date_std;
            detail.kdate_desc = self.orderModel.order_date;
            detail.meal_id = self.orderModel.meal_id;
            detail.menu_id= self.menu_id;
            detail.is_bz = self.orderModel.is_bz;
            ///餐厅简介
            detail.is_introduction = YES;
            
            [self.navigationController pushViewController:detail animated:YES];
            
        }
        else if (indexPath.row == 2) {
            [self QRcodeBtnClick];
        }

    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    ///分组数量+2
    return self.orderModel.tables.count+2;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    
    return 10;
    
    
    
}
#pragma cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.orderModel.tables.count == 0) {
            
            return 0.01;
 
        }
        return 100;
    }
    else if (section == self.orderModel.tables.count+1) {
        return 10;
    }
    else{
        if ([self.orderModel.is_bz integerValue]==1) {
            return 0.01;
        }
            return 42;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    view.backgroundColor = [FDUtils colorWithHexString:@"#f2f2f2"];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        if (self.orderModel.tables.count == 0) {
            
            return nil;
            
        }
        
        TablesModel *model =self.orderModel.tables[0];
        
        FDTicketHeadView *ticketHeadView = [FDTicketHeadView selfTicketHeadView];
        
        ticketHeadView.frame = CGRectMake(0, 0, ScreenW, 80);
        
        ticketHeadView.leftLabel.text = [NSString stringWithFormat:@"%@  %@%@",self.orderModel.merchant_name,model.table_no,model.table_desc];
        
        ticketHeadView.detailStr.text = [NSString stringWithFormat:@"%@ %@ %@",self.orderModel.order_date,self.orderModel.meal_time,self.orderModel.meal_desc];
        
        
        
        return ticketHeadView;
        
        
    }
    else if (section != self.orderModel.tables.count+1) {
        
        if (self.orderModel.tables.count>0) {
            if ([self.orderModel.is_bz integerValue]==1) {
                
                return nil;
  
            }else{
                UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 42)];
                
                headerView.backgroundColor = [UIColor whiteColor];
                
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 200, 41)];
                
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                
                [btn setImage:[UIImage imageNamed:@"popup_ico_xzrs"] forState:UIControlStateNormal];
                
                [btn setTitle:@"  已加入的饭友" forState:UIControlStateNormal];
                
                [btn setTitleColor:[FDUtils colorWithHexString:@"#222222"] forState:UIControlStateNormal];
                
                btn.titleLabel.font = [UIFont systemFontOfSize:17];
                
                
                
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 41.5, ScreenW, 0.5)];
                
                lineView.backgroundColor = [FDUtils colorWithHexString:@"#dedede"];
                
                [headerView addSubview:lineView];
                
                [headerView addSubview:btn];
                
                
                
                return headerView;
            
            }
            
            
        }else{
            ///未分桌
            return [[UITableViewCell alloc]init];
        }
        
        
    }
    return nil;
}
#pragma mark - Click
-(void)buttonAction:(UIButton *)button
{
    if ([_selectedArray[button.tag-1] isEqualToString:@"0"]) {
        ///现在要打开
        [_selectedArray replaceObjectAtIndex:button.tag-1 withObject:@"1"];
        [self.tableView reloadData];
    }
    else
    {
        ///现在要关闭
        [_selectedArray replaceObjectAtIndex:button.tag-1 withObject:@"0"];
        [self.tableView reloadData];
    }
}


- (void)editMySelfBtnClick:(UIButton *)sender{
    
    FDInputViewController *input = [[FDInputViewController alloc] init];
    input.NumberCounts = 20;
    input.navtitle = @"个人描述";
    input.attribute = @"一句话描述下你自己，方便同桌的人认出你";
    input.placehorder = @"";
    input.index = 60;
    input.submitStr =@"确定";
    TablesModel *model = self.orderModel.tables[sender.tag];
    table_id = model.table_id;
    
    [self presentViewController:input animated:YES completion:nil];
    
}

- (void)leftClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 分享一元饭票
- (void)shareBtnClick{
    
    share_type = @"3";
    [self.shareView removeFromSuperview];
    [self.navigationController.view addSubview:self.shareTicketView];
    
}

#pragma mark  分享红包
- (void)sendTo_weixin_Click{
    
    share_type = @"2";
    [self.bonusView removeFromSuperview];
    [self.navigationController.view addSubview:self.shareTicketView];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bag_url"];
    
    
}

- (void)iconClick:(UITapGestureRecognizer *)sender{
    FDUserDetailViewController *userprofile = [[FDUserDetailViewController alloc] init];
    FDHeadImageView *icon= (FDHeadImageView *)sender.view;
    userprofile.kid = icon.kid;
    [self.navigationController pushViewController:userprofile animated:YES];
    
}

- (void)cancleOrder{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确认退款？" delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alertView.tag =10002;
    [alertView show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10002) {
        ///退订
        if (buttonIndex == 1) {
            if ([self.orderModel.is_cancel intValue]==0) {
                [SVProgressHUD showImage:nil status:self.orderModel.refund_toast];
                return;
            }
            [MobClick event:@"click_certificate_cancel"];
            HttpOrderCancel *cancle = [HttpOrderCancel sharedInstance];
            [cancle loadCancleOrder:self];
            
        }
    }else if (alertView.tag == 10001){
        if (self.isFromPay) {
            ///下单成功之后退订成功
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            ///退订成功
            [[NSNotificationCenter defaultCenter] postNotificationName:RefreshOrderListViewController object:self];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (alertView.tag == 10003){
        ///退订失败，什么也不做
        
    }else if (alertView.tag ==10004){
        ///分享到微信
        if (buttonIndex==1) {
            share_type = @"5";
            [self.navigationController.view addSubview:self.shareTicketView];
        }
    }

    
}

- (void)QRcodeBtnClick{
    /**
     *  点击查看二维码
     */
    [MobClick event:@"click_Qrcode"];
    FDQRCodeView *qrCodeView = [[[NSBundle mainBundle]loadNibNamed:@"FDQRCodeView" owner:nil options:nil]lastObject];
    qrCodeView.CodeImageView.image = [QRCodeGenerator qrImageForString:self.orderModel.validation imageSize:qrCodeView.CodeImageView.bounds.size.width];
    qrCodeView.order_num.text = [NSString stringWithFormat:@"票号：%@",self.orderModel.order_num];
    [qrCodeView.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qrCodeCancleBtnClick)]];
    qrCodeView.CodeImageView.transform = CGAffineTransformScale(qrCodeView.CodeImageView.transform, 0.2, 0.2);
    qrCodeView.backView.transform =CGAffineTransformScale(qrCodeView.backView.transform, 0.2, 0.2);
    [self.navigationController.view addSubview:qrCodeView];
    self.qrCodeView = qrCodeView;
    [UIView animateWithDuration:0.5 animations:^{
        qrCodeView.CodeImageView.transform = CGAffineTransformIdentity;
        qrCodeView.backView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    
}


- (void)qrCodeCancleBtnClick{
    [UIView animateWithDuration:0.5 animations:^{
        self.qrCodeView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.qrCodeView removeFromSuperview];
    }];
}


- (void)cancleRightItem{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"退款" style:UIBarButtonItemStylePlain target:self action:@selector(cancleOrder)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)noRightItem{
    UIBarButtonItem *item;
    if (self.orderModel.tables.count>0) {
        item = [[UIBarButtonItem alloc]initWithTitle:@"通知饭友" style:UIBarButtonItemStylePlain target:self action:@selector(shareOrderTicket)];
    }else{

        
        item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(noCancleOrder)];
    
    }

    self.navigationItem.rightBarButtonItem = item;
}
- (void)noCancleOrder{
    //不能退订，还没分桌，话题发起人，不显示右上角按钮
    
}
#pragma mark  退订成功
- (void)cancleSuccessed{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"已支付的%@元会在24小时内退回你",self.orderModel.paid] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = 10001;
    [alertView show];
}

#pragma mark 分享饭票
- (void)shareOrderTicket{
   
    share_type = @"4";
    [self.navigationController.view addSubview:self.shareTicketView];
    
}

- (void)cancleFailed{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"退订失败，请稍后重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = 10003;
    [alertView show];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 进入群聊
- (void)gotoGroupBtnClick:(UIButton *)sender{
    
    TablesModel *model = self.orderModel.tables[sender.tag];
    
    sender.enabled = NO;
    if (![[EaseMob sharedInstance].chatManager isLoggedIn]) {
        //异步登陆账号
        FDHuanXinLoginTool *tool = [FDHuanXinLoginTool sharedInstance];
        [tool huanxinLogin:self];
    }else{
        
    }
    ///先请求群组id
    HttpImGroupId *groupId = [HttpImGroupId sharedInstance];
    
    [groupId imGroupIdWithOrder_no:self.order_no table_id:model.table_id viewController:self button:sender];
    
    
}

- (void)descriptionMySelfBack:(NSNotification *)no{
    HttpOrderSelfDesc *tool =[HttpOrderSelfDesc sharedInstance];
    [tool loadTopicPersonalDescribe:table_id andMy_Desc:no.userInfo[@"myself_desc"] andOrder_no:self.order_no viewController:self];
}

- (void)merchant_phoneBtnClick{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"拨打餐厅电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.orderModel.phone, nil];
    sheet.tag = 100;
    [sheet showInView:self.view.window];

    
}

#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 100){
        if (buttonIndex==0) {///拨打餐厅电话
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.orderModel.phone]]];
        }

    }else{
    
        if (buttonIndex==0) {///拨打客服电话
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[HQDefaultTool getService]]]];
        }
    
    }

}

- (void)phoneClick{

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"拨打客服电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[HQDefaultTool getService], nil];
    sheet.tag = 200;
    [sheet showInView:self.view.window];
    
}


- (void)bonus_NO_Click{
    [self.bonusView removeFromSuperview];
    
}
@end