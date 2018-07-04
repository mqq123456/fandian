//
//  FDMerchantDetailController.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//


#import "FDMerchantDetailController.h"
#import "FDDetailImageCell.h"
#import "CommentModel.h"
#import "FDOrderViewController.h"
#import "FDDetailMapViewController.h"
#import "ImagesModel.h"
#import "NSString+Urldecode.h"
#import "FDLoginViewController.h"
#import "HQCommentViewController.h"
#import "FDEvaluationViewController.h"
#import "HttpMerchantDetail.h"
#import "FDMerchantDetail_comment_cell.h"
#import "FDmerchantDetail_local_cell.h"
#import "FDMerchantDetail_Menu_Cell.h"
#import "XHMenu.h"
#import "ButtonsView.h"
#import "FDSubmitOrderViewController.h"
#import "FDCommentCell.h"
#import "FDCommentFrame.h"
#import "SeatsModel.h"
#import "FDUserDetailViewController.h"
#import "FDAlertTableViewCell.h"
#import "TaoCanModel.h"
#import "MenusModel.h"
#import "FDFoodCell.h"
#import "FDDetailPriceView.h"
#import "FDShareView.h"
#import "FDMenus_V2_3Model.h"
#import "FDMerchantDetailShareModel.h"

@interface FDMerchantDetailController ()<FDLoginViewControllerDelegate,XHScrollMenuDelegate, UIScrollViewDelegate,ButtonsViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *menus;
@property (nonatomic ,weak) UIPopoverListView *popoverListView;
@property (nonatomic ,weak) FDShareView *shareView;
@end

@implementation FDMerchantDetailController

#pragma mark -
- (FDShareView *)shareView{
    
    if (_shareView==nil) {
        _shareView = [FDShareView shareView];
        _shareView.delegate = self;
    }
    _shareView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
   // _shareView.umURL = self.shareModel.WeChat_friends_circle_share_title;
    _shareView.title = self.shareModel.WeChat_friends_circle_share_title;
    _shareView.contText = self.shareModel.WeChat_friends_share_text;
    _shareView.group_share_title = self.shareModel.group_share_title;
    _shareView.group_share_hint = self.shareModel.group_share_hint;
    _shareView.type = @"7";
    _shareView.topic_id = [NSString stringWithFormat:@"%d",self.merchant_id];
    return _shareView;
}
- (FDMerchantDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [FDMerchantDetailBottomView detailBottomView];
    }
    _bottomView.frame = CGRectMake(0, ScreenH-62-64, ScreenW, 62);
    return _bottomView;
}

- (NSMutableArray *)menus {
    if (!_menus) {
        _menus = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _menus;
}


- (void)initMealTimeView{
    for (int i = 0; i < 4; i ++) {
        XHMenu *menu = [[XHMenu alloc] init];
        NSString *title = @"";
        NSString *time_title = @"";
        menu.title = title;
        menu.time_title = time_title;
        menu.titleNormalColor = [FDUtils colorWithHexString:@"#666666"];
        menu.titleSelectedColor = [FDUtils colorWithHexString:@"#666666"];
        menu.titleFont = [UIFont systemFontOfSize:14];
        
        [self.menus addObject:menu];
        
    }
    
    _scrollMenu = [[XHScrollMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),108)];
    _scrollMenu.backgroundColor = [UIColor whiteColor];
    _scrollMenu.delegate = self;
    //加阴影--任海丽编辑
    _scrollMenu.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _scrollMenu.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _scrollMenu.layer.shadowOpacity = 0.03;//阴影透明度，默认0
    _scrollMenu.layer.shadowRadius = 2;//阴影半径，默认3
    _scrollMenu.menus = self.menus;
    [_scrollMenu reloadData];

}
- (void)initBottonView{
    
    [self.view addSubview:self.bottomView];
    if (self.left_right==1) {
        TaoCanModel *model = self.menus_copy[0];
        _bottomView.price.text =[NSString stringWithFormat:@"%@",model.price];
        _bottomView.price_desc.text =[NSString stringWithFormat:@"元"];
        _bottomView.yiyou.text =[NSString stringWithFormat:@"%@ %@",self.kdate_desc,self.meal_time];
    }else{
        if (self.left_right==2) {
            TaoCanModel *model = self.menus_copy[1];
            _bottomView.price.text =[NSString stringWithFormat:@"%@",model.price];
            _bottomView.price_desc.text =[NSString stringWithFormat:@"元"];
            _bottomView.yiyou.text =[NSString stringWithFormat:@"%@ %@",self.kdate_desc,self.meal_time];
        }
    }
    
    [_bottomView.orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)initShareBtn{
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setTitleColor:[FDUtils colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
}

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    ///餐厅详情流量
    [MobClick event:@"pv_detail"];
    self.title = self.model.merchant_name;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.title = @"";
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Background_Color;
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64-62);
    self.tableView.backgroundColor = Background_Color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.meal_id = @"";
    self.kdate = @"";
    self.is_bz = @"1";
    
    self.merchant_id = self.model.merchant_id;
    self.title = self.model.merchant_name;
    
    [self initMealTimeView];
   
    
    [self initBottonView];
    
    [self initShareBtn];
    
    ///评价完成之后刷新数据
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMerchantDetailComment) name:RefreshDetailViewController object:nil];

    _imagesURL = [NSMutableArray array];
    _menuArray = [NSMutableArray array];
    _commentArray = [NSMutableArray array];
    _categoryArray = [NSMutableArray array];
    _kdates = [NSMutableArray array];
    _kdescs = [NSMutableArray array];
    _kmeal_ids = [NSMutableArray array];
    _kmeal_state = [NSMutableArray array];
    _is_discounts = [NSMutableArray array];
    _ktimes = [NSMutableArray array];
    _seats = [NSMutableArray array];
    
    [self loadMerchantDetail:-1];
    
    

}
- (void)shareClick{
    [self.navigationController.view addSubview:self.shareView];
}
#pragma mark - 数据加载完成，刷新

- (void)loadMerchantDetailBack{
    
    [self.menus removeAllObjects];
    
    for (int i = 0; i < self.kdates.count; i ++) {
        XHMenu *menu = [[XHMenu alloc] init];
        menu.title = self.kdescs[i];
        menu.time_title = self.ktimes[i];
        menu.state =self.kmeal_state[i];
        menu.is_discount =self.is_discounts[i];
        menu.titleNormalColor = [FDUtils colorWithHexString:@"#bababa"];
        menu.titleFont = [UIFont systemFontOfSize:13];
        [self.menus addObject:menu];
        
    }
    
    _scrollMenu.selectedIndex = self.select_index;
    _scrollMenu.best_selectedIndex = self.best_select_index;
    _scrollMenu.menus = self.menus;
    [_scrollMenu reloadData];
    
    _bottomView.yiyou.text =[NSString stringWithFormat:@"%@ %@",self.kdate_desc,self.meal_time];
    if (self.left_right==1) {
        TaoCanModel *model = self.menus_copy[0];
        _bottomView.price.text =[NSString stringWithFormat:@"%@",model.price];
        _bottomView.price_desc.text =[NSString stringWithFormat:@"元"];
    }else{
        if (self.left_right==2) {
            TaoCanModel *model = self.menus_copy[1];
            _bottomView.price.text =[NSString stringWithFormat:@"%@",model.price];
            _bottomView.price_desc.text =[NSString stringWithFormat:@"元"];
        }else{
            _bottomView.price.text =@"";
            _bottomView.price_desc.text =@"";
        }
    }
    
}

- (void)loadMerchantDetail:(NSInteger)best{

    HttpMerchantDetail *detail = [HttpMerchantDetail sharedInstance];
    [detail merchantDetailWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng meal_id:self.meal_id merchant_id:[NSString stringWithFormat:@"%d",self.merchant_id] meal_date:self.kdate local:self.local viewController:self bestSelect_index:best];
}

- (void)loadMerchantDetailComment{
    [self loadMerchantDetail:self.best_select_index];
}

- (void)loadMerchantDetailtap{
    [self loadMerchantDetail:1];
}
- (void)umClick{
    ///点击下单
    NSString *mode;
    mode = @"包桌";
    if (!self.model.merchant_name) {
        self.model.merchant_name = @"";
    }
    if (!self.model.price) {
        self.model.price = @(0);
    }
    if (!self.meal_time) {
        self.meal_time = @"";
    }
    if (!self.peopleNum) {
        self.peopleNum = @"";
    }
    
    [MobClick event:@"click_detail_order" attributes:@{@"restaurant" : self.model.merchant_name,
                                                       
                                                       @"price":[NSString stringWithFormat:@"%@", self.model.price],
                                                       
                                                       @"time" : self.meal_time ,
                                                       
                                                       @"mode" :mode ,
                                                       
                                                       @"number":self.peopleNum}];
    
}
- (void)pushToSubmitOrderViewController{
    FDSubmitOrderViewController *submit = [[FDSubmitOrderViewController alloc] init];
    submit.merchant_id=[NSString stringWithFormat:@"%d",self.merchant_id];
    submit.merchant_name =self.model.merchant_name;
    submit.icon =self.model.icon;
    submit.kdate =self.kdate;
    submit.kdate_desc = self.kdate_desc;
    submit.meal_time = self.meal_time;
    submit.price = [NSString stringWithFormat:@"%@",self.price];
    submit.people_desc = self.people_desc;
    submit.people = self.peopleNum;
    submit.meal_id = self.meal_id;
    submit.menu_id = self.menu_id;
    submit.is_bz = self.is_bz;
    [self.navigationController pushViewController:submit animated:YES];
    
    [self umClick];

}
#pragma mark - Click
- (void)taocanSelectedWithIndex:(int)index{
    TaoCanModel *model = [self.menus_copy objectAtIndex:index];
    [self.menuArray removeAllObjects];
    [self.categoryArray removeAllObjects];
    [self.imagesURL removeAllObjects];
    for (MenusModel *menusModel in model.menus) {//小菜单
        NSArray *array = [menusModel.menu_detail componentsSeparatedByString:@","];
        [self.menuArray addObject:array];
        [self.categoryArray addObject:menusModel.menu_name];
    }
    for (ImagesModel *imageModel in model.imgs) {
        [self.imagesURL addObject:imageModel.url];
    }
    self.price = model.price;
    self.peopleNum = model.menu_people;
    self.people_desc = model.menu_people_desc;
    self.menu_id = model.menu_id;
    self.original_price = model.original_price;
    self.jzjg = model.jzjg;
    self.total_deduction = model.total_deduction;
    self.paid = model.paid;
    [self loadMerchantDetailBack];
    
}
- (void)taocan1Selected:(UIButton *)sender{
    self.left_right = 1;
    [self taocanSelectedWithIndex:0];
    [self.tableView reloadData];
}

- (void)taocan2Selected:(UIButton *)sender{
    
    self.left_right = 2;
    [self taocanSelectedWithIndex:1];
    [self.tableView reloadData];
    
}

- (void)pushToCommentController{
    
    ///点击查看评论
    [MobClick event:@"click_detail_comment"];
    HQCommentViewController *comment = [[HQCommentViewController alloc] init];
    comment.merchant_id = [NSString stringWithFormat:@"%d",self.merchant_id];
    [self.navigationController pushViewController:comment animated:YES];
    
}
- (void)commentClick{
    
    ///点击撰写评价
    [MobClick event:@"click_detail_review"];
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        [self presentLoginViewController:999];
        return;
    }else{
        [self pushToEvaluationViewController];
    }
    
}
- (void)pushToEvaluationViewController{
    FDEvaluationViewController *envaluation = [[FDEvaluationViewController alloc] init];
    envaluation.merchant_id =[NSString stringWithFormat:@"%d", self.merchant_id];
    envaluation.merchant_name = self.model.merchant_name;
    envaluation.icon = self.model.icon;
    NSDate *date=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    envaluation.creat_time = [dateformatter stringFromDate:date];
    [self.navigationController pushViewController:envaluation animated:YES];
}

- (void)commentBtnClick{
    
    ///点击查看评论
    [MobClick event:@"click_detail_comment"];
    HQCommentViewController *comment = [[HQCommentViewController alloc] init];
    comment.merchant_id = [NSString stringWithFormat:@"%d",self.merchant_id];
    [self.navigationController pushViewController:comment animated:YES];
    
}


- (void)locationMapClick{
    [MobClick event:@"click_detail_address"];
    FDDetailMapViewController *map = [[FDDetailMapViewController alloc] init];
    map.lat = self.model.lat;
    map.lng = self.model.lng;
    map.name = self.model.merchant_name;
    map.address = self.model.address;
    [self.navigationController pushViewController:map animated:YES];
    
}


#pragma mark 去下单，西餐（弹起选择人数）

- (void)orderBtnClick{

    if ([[HQDefaultTool getKid] isEqualToString:@""]) {//登录
        [self presentLoginViewController:0];
        return;
    }else{
        if ([self.is_western_restaurant intValue]==0) {
            if ([self.peopleNum intValue]==0) {
                return;
            }
            [self pushToSubmitOrderViewController];
            return;
           
        }else{//西餐
            if (self.seats.count==0) {//如果没加载到座位，不执行
                return;
            }
            [self alertButtonView];
        }
        
    }
    
    
    
}
- (void)alertButtonView{
    ButtonsView *buttonsView = [[ButtonsView alloc] initWithDelegate:self selectedIndex:1 OtherTitles:self.seats viewTag:0 num:4 frame:CGRectMake(0,0, ScreenW-30, 0)people_hint:self.people_hint];
    buttonsView.userInteractionEnabled = YES;
    CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 30.0f;
    CGFloat yHeight = buttonsView.size.height;
    [buttonsView addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
    CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(15, yOffset, xWidth, yHeight)];
    poplistview.listView.scrollEnabled = FALSE;
    poplistview.isTouchOverlayView = YES;
    [poplistview show];
    self.popoverListView = poplistview;
    self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [poplistview addSubview:buttonsView];
    
}
- (void)phoneClick{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"电话：%@",[HQDefaultTool getService]], nil];
    [sheet showInView:self.view.window];
}

- (void)headImageClick:(UITapGestureRecognizer *)tap{
    
    FDHeadImageView *head = (FDHeadImageView *)tap.view;
    FDUserDetailViewController *userDetail = [[FDUserDetailViewController alloc] init];
    userDetail.kid = head.kid;
    [self.navigationController pushViewController:userDetail animated:YES];
    
}


#pragma mark - UITableViewDataSource Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 115;
    }
    
    if (section == 3) {
        return 50;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 60;
    }
    if (section == 3) {
        return 30;
    }
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return self.menuArray.count;
    }else if (section==3){
        return self.friend_hint.count;
    }else if (section==4){
        return 1;
    }else{
        return self.commentArray.count>2?2:self.commentArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0&&indexPath.row == 0) {
        FDDetailImageCell *cell = [FDDetailImageCell cellWithTableView:tableView imagesURL:_imagesURL];
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        FDMerchantDetail_Menu_Cell *cell = [FDMerchantDetail_Menu_Cell cellWithTableView:tableView categoryArray:self.categoryArray menuArray:self.menuArray hasTC:self.menus_copy.count==0?NO:YES is_introduction:NO];
        [cell.leftBtn addTarget:self action:@selector(taocan1Selected:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.rightBtn addTarget:self action:@selector(taocan2Selected:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (self.menus_copy.count == 0) {///一个套餐也没有
            cell.rightViewWidth.constant = 0;
            cell.rightView.hidden = YES;
            cell.leftbtnCenterY.constant = 0;
            cell.leftView.hidden = YES;
            cell.booked1.hidden = YES;
            cell.booked2.hidden = YES;
        }else{///有套餐
            cell.rightViewWidth.constant = ScreenW/2-1;
            if (self.left_right==1) {///点击左边
                cell.left_price.textColor = [UIColor whiteColor];
                cell.left_tao_desc.textColor = [UIColor whiteColor];
                cell.right_price.textColor = [FDUtils colorWithHexString:@"#666666"];
                cell.right_tao_desc.textColor = [FDUtils colorWithHexString:@"#222222"];
                cell.leftBtn.selected = YES;
                cell.rightBtn.selected = NO;
            }else if (self.left_right==2) {///点击右边
                cell.right_price.textColor = [UIColor whiteColor];
                cell.right_tao_desc.textColor = [UIColor whiteColor];
                cell.left_price.textColor = [FDUtils colorWithHexString:@"#666666"];
                cell.left_tao_desc.textColor = [FDUtils colorWithHexString:@"#222222"];
                cell.rightBtn.selected = YES;
                cell.leftBtn.selected = NO;
            }else{
                
            }
            if (self.menus_copy.count == 1) {///只有一个套餐，隐藏右边
                cell.rightViewWidth.constant = 0;
                cell.rightView.hidden = YES;
                cell.leftbtnCenterY.constant = 0;
                
                TaoCanModel *model1 = [self.menus_copy objectAtIndex:0];
                cell.left_tao_desc.text = model1.menu_people_desc;
                cell.left_price.text = [NSString stringWithFormat:@"%@",model1.price_desc];
                if ([model1.is_soldout isEqualToString:@"1"]) {
                    cell.booked1.hidden = NO;
                    cell.leftBtn.enabled = NO;
                    cell.left_price.textColor = [FDUtils colorWithHexString:@"#bababa"];
                    cell.left_tao_desc.textColor = [FDUtils colorWithHexString:@"#bababa"];
                    
                }else{
                    
                    cell.booked1.hidden = YES;
                    cell.leftBtn.enabled = YES;
                    
                }
                if (self.left_right==1) {
                    cell.tuijian_people.text = model1.recommend_hint;
                }
                
                //cell.suggest1.text = model1.recommend_hint;
                
            }else{
                if (self.menus_copy.count == 2) {
                    cell.leftView.hidden = NO;
                    cell.rightView.hidden = NO;
                    
                    TaoCanModel *model1 = [self.menus_copy objectAtIndex:0];
                    cell.left_tao_desc.text = model1.menu_people_desc;
                    cell.left_price.text = [NSString stringWithFormat:@"%@",model1.price_desc];
                    TaoCanModel *model2 = [self.menus_copy objectAtIndex:1];
                    cell.right_tao_desc.text = model2.menu_people_desc;
                    cell.right_price.text = [NSString stringWithFormat:@"%@",model2.price_desc];
                    //cell.suggest1.text = model1.recommend_hint;
                    //cell.suggest2.text = model2.recommend_hint;
                    if (self.left_right==2) {
                        cell.tuijian_people.text = model2.recommend_hint;
                    }
                    if ([model1.is_soldout isEqualToString:@"1"]) {
                        cell.booked1.hidden = NO;
                        cell.leftBtn.enabled = NO;
                        cell.left_price.textColor = [FDUtils colorWithHexString:@"#bababa"];
                        cell.left_tao_desc.textColor = [FDUtils colorWithHexString:@"#bababa"];
                    }else{
                        
                        cell.booked1.hidden = YES;
                        cell.leftBtn.enabled = YES;
                    }
                   
                    if ([model2.is_soldout isEqualToString:@"1"]) {
                        cell.booked2.hidden = NO;
                        cell.rightBtn.enabled = NO;
                        cell.right_price.textColor = [FDUtils colorWithHexString:@"#bababa"];
                        cell.right_tao_desc.textColor = [FDUtils colorWithHexString:@"#bababa"];
                    }else{
                        
                        cell.booked2.hidden = YES;
                        cell.rightBtn.enabled = YES;
                        
                    }
                }
            }
        }
        
        return cell;
        
    }else if (indexPath.section == 2){
        
        FDFoodCell *cell = [FDFoodCell cellWithTableView:tableView];
//        FDMenus_V2_3Model *model = self.menuArray[indexPath.row];
//        cell.food_name.text = model.dish_name;
//        cell.food_count.text = model.part_num;
//        cell.food_price.text = model.dish_price;
        cell.food_name.text = @"水煮牛肉";
        cell.food_count.text = @"1份";
        cell.food_price.text = @"40元";
        return cell;
        
    }else if (indexPath.section == 3){
        FDAlertTableViewCell *cell = [FDAlertTableViewCell cellWithTableView:tableView];
        
        
        cell.titleLabel.text = self.friend_hint[indexPath.row];
        if ([self.friend_hint[indexPath.row] hasSuffix:[HQDefaultTool getService]]) {
            NSMutableDictionary *heightLightDict=[NSMutableDictionary dictionary];
            heightLightDict[NSFontAttributeName]=[UIFont systemFontOfSize:14];
            heightLightDict[NSForegroundColorAttributeName]=[FDUtils colorWithHexString:@"#666666" alpha:1];
            NSMutableAttributedString *attributeTitle=[[NSMutableAttributedString alloc] initWithString:self.friend_hint[indexPath.row] attributes:heightLightDict];
            
            NSRange firshRange=[self.friend_hint[indexPath.row] rangeOfString:[HQDefaultTool getService]];
            [attributeTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:firshRange];
            [attributeTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:firshRange];
            [cell.titleLabel setAttributedText:attributeTitle];
            cell.titleLabel.userInteractionEnabled = YES;
            [cell.titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneClick)]];
        }else{
            cell.titleLabel.userInteractionEnabled = NO;
        }
        
        return cell;
    }
    
    else if (indexPath.section == 4){
        
        FDmerchantDetail_local_cell *cell = [FDmerchantDetail_local_cell cellWithTableView:tableView];
        
        cell.local_address.text = self.model.address;
        
        cell.local_star.show_star = [self.model.star doubleValue];
        
        cell.content_view.userInteractionEnabled = YES;
        
        [cell.content_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationMapClick)]];
        cell.line1H.constant = 0.3;
        
        cell.line2H.constant = 0.3;
        
        cell.local_name.text = self.model.merchant_name;
        
        [cell.local_comment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect contentRect = [self.model.merchant_name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-130, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        cell.merchant_Bg_W.constant = contentRect.size.width+100;
        
        return cell;
        
    }else if(indexPath.section == 5){
        
        FDCommentCell *cell = [FDCommentCell cellWithTableView:tableView];
        cell.statusFrame = self.commentArray[indexPath.row];
        [cell.icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick:)]];
        
        return cell;
        
    }
    
    return nil;
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return ([UIScreen mainScreen].bounds.size.width)*0.56649744;
    }else if (indexPath.section ==1){
//        double y = 0;
//        for (int i = 0 ; i < self.categoryArray.count; i++) {
//            NSArray *array = self.menuArray[i];
//            
//            double menuY = y;
//            for (int j=0; j<array.count; j++ ) {
//                j%2!=1?(menuY+=0 ):(menuY += 30);
//            }
//            
//            NSInteger count = (array.count%2)==0?(array.count/2):(array.count/2+1);
//            y += count*30;
//            
//        }
//        
//        y += 23;
//        if (y==0) {
//            return self.menus_copy.count == 0?150:270;
//        }
//        return self.menus_copy.count == 0?(20+y+40*self.categoryArray.count):(140+ y+40*self.categoryArray.count);
        
        return 148;
        
    }else if (indexPath.section == 2){
        return 50;
    }else if (indexPath.section == 3){
        CGRect contentRect = [self.friend_hint[indexPath.row] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-50, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        return contentRect.size.height+10;
        
    }else if (indexPath.section == 4){
        return 179;
    }else if (indexPath.section ==5){
        FDCommentFrame *frame = self.commentArray[indexPath.row];
        return frame.cellHeight;
    }else{
        return 80;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 115)];
//        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 109, ScreenW, 1)];
//        line.backgroundColor = [UIColor blackColor];
//        line.alpha = 0.03;
//        [headerView addSubview:line];
        [headerView addSubview:_scrollMenu];
        return headerView;
        
    }
    
    if (section == 3) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        headerView.backgroundColor = [UIColor whiteColor];
        UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(6, 20, ScreenW-12, 31)];
        alertView.backgroundColor = [FDUtils colorWithHexString:@"F6F6F6"];
        alertView.layer.cornerRadius = 1;
        alertView.layer.masksToBounds = YES;
        [headerView addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenW-12-80)/2, 10, 80, 20)];
        alertLabel.text = @"温馨提示";
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.font = [UIFont systemFontOfSize:16];
        [alertView addSubview:alertLabel];
        
        UIImageView *menuLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(alertLabel.frame)-74-10, CGRectGetMidY(alertLabel.frame), 74, 2.5)];
        menuLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
        [alertView addSubview:menuLeft_image];
        
        UIImageView *menuRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(alertLabel.frame)+10, CGRectGetMidY(alertLabel.frame), 74, 2.5)];
        menuRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
        [alertView addSubview:menuRight_image];
        
        return headerView;
        
    }
    
    return nil;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
        footerView.backgroundColor = [UIColor whiteColor];
        UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(6, -1, ScreenW-12, 10)];
        alertView.backgroundColor = [FDUtils colorWithHexString:@"F6F6F6"];
        alertView.layer.cornerRadius = 1;
        alertView.layer.masksToBounds = YES;
        [footerView addSubview:alertView];
        return footerView;
        
    }
    if (section == 2) {
        
        FDDetailPriceView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"FDDetailPriceView" owner:nil options:nil]lastObject];
        footerView.backgroundColor = [UIColor whiteColor];
        footerView.fd_price.text = [NSString stringWithFormat:@"%@元",self.jzjg];
        footerView.original_price.text = [NSString stringWithFormat:@"%@元",self.original_price];
        return footerView;
        
    }
    
    return nil;
    
}
#pragma mark - FDLoginViewControllerDelegate

- (void)dismissWithIndex:(NSInteger)index{
    if (index==999) {
        [self commentClick];
    }
    
}
- (void)presentLoginViewController:(NSInteger)info_index{
    FDLoginViewController *verification = [[FDLoginViewController alloc] init];
    verification.info_index = info_index;
    verification.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[HQDefaultTool getService]]]];
    }
}
#pragma mark - XHScrollMenuDelegate
- (void)startObservingContentOffsetForScrollView:(UIScrollView *)scrollView

{
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)scrollMenuDidSelected:(XHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex {
    
    if (self.kmeal_ids.count) {
        self.meal_time = self.ktimes[selectIndex];
        self.meal_id = self.kmeal_ids[selectIndex];
        self.kdate = self.kdates[selectIndex];
        self.select_index = selectIndex;
        self.kdate_desc = self.kdescs[selectIndex];
        [self loadMerchantDetailtap];
    }
}



- (void)scrollMenuDidManagerSelected:(XHScrollMenu *)scrollMenu {
    //    NSLog(@"scrollMenuDidManagerSelected");
}

- (void)scrollMenuDidClickAlertBtn:(XHScrollMenu *)scrollMenu{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[HQDefaultTool getAdvanced_order_tips_content] message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alertView show];
    
}
#pragma mark - ButtonsViewDelegate

- (void)buttonsView:(ButtonsView *)buttonsView clickedButtonAtIndex:(NSInteger)buttonIndex sender:(UIButton *)sender title:(NSArray *)array{
    
    [self.popoverListView dismiss];
    
    FDSubmitOrderViewController *submit = [[FDSubmitOrderViewController alloc] init];
    
    submit.merchant_id=[NSString stringWithFormat:@"%d",self.merchant_id];
    submit.merchant_name =self.model.merchant_name;
    submit.icon =self.model.icon;
    submit.kdate =self.kdate;
    submit.kdate_desc = self.kdate_desc;
    submit.meal_time = self.meal_time;
    submit.price = [NSString stringWithFormat:@"%@",self.price];
    SeatsModel *model = self.seats[buttonIndex];
    submit.people_desc = model.seat_desc;
    self.peopleNum = [NSString stringWithFormat:@"%@",model.seat_num];
    submit.people = [NSString stringWithFormat:@"%@",model.seat_num];
    submit.meal_id = self.meal_id;
    submit.menu_id = self.menu_id;
    submit.is_bz = self.is_bz;
    submit.xican = YES;
    
    [self.navigationController pushViewController:submit animated:YES];
    
    [self umClick];
}
#pragma mark -

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

