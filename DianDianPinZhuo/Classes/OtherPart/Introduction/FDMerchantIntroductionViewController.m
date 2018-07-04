//
//  FDMerchantIntroductionViewController.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/28.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDMerchantIntroductionViewController.h"

#import "FDDetailImageCell.h"
#import "CommentModel.h"
#import "UIPopoverListView.h"
#import "FDDetailMapViewController.h"
#import "ImagesModel.h"
#import "NSString+Urldecode.h"
#import "FDLoginViewController.h"
#import "HQCommentViewController.h"
#import "FDEvaluationViewController.h"

#import "DashedLine.h"
#import "AdView.h"
#import "HttpMerchantDetail.h"
#import "FDMerchantDetail_comment_cell.h"
#import "FDmerchantDetail_local_cell.h"
#import "FDMerchantDetail_Menu_Cell.h"
#import "FDMerchantDetailBottomView.h"
#import "ButtonsView.h"
#import "FDSubmitOrderViewController.h"
#import "FDCommentCell.h"
#import "FDCommentFrame.h"
#import "SeatsModel.h"

#import "FDAlertTableViewCell.h"
#import "MenusModel.h"
#import "TaoCanModel.h"
#import "HttpTopicSponsor.h"

@interface FDMerchantIntroductionViewController ()
<FDLoginViewControllerDelegate,ButtonsViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *menus;

@property (nonatomic ,weak) UIPopoverListView *popoverListView;
@property (nonatomic ,strong) FDMerchantDetailBottomView *bottomView;

@end

@implementation FDMerchantIntroductionViewController

- (FDMerchantDetailBottomView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [FDMerchantDetailBottomView detailBottomView];
    }
    _bottomView.price_top.constant = 23;
    _bottomView.yiyou.hidden = YES;
    _bottomView.frame = CGRectMake(0, ScreenH-70-64, ScreenW, 70);
    return _bottomView;
}

- (NSMutableArray *)menus {
    if (!_menus) {
        _menus = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _menus;
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///餐厅详情流量
    [MobClick event:@"pv_detail"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Background_Color;
    self.tableView.backgroundColor = Background_Color;
    self.tableView.separatorColor = Background_Color;
    
    
    if (self.model.merchant_id) {
        self.merchant_id = self.model.merchant_id;
    }
    
    if (self.is_to_topic_join||self.is_from_topic) {
        [self addTitleViewWithTitle:self.model.merchant_name];
    }
    if (self.is_introduction) {
        [self addTitleViewWithTitle:self.model.merchant_name];
    }
    if (!self.is_introduction) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64-64);
    }
    
    ///评价完成之后刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMerchantDetail) name:RefreshDetailViewController object:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _imagesURL = [NSMutableArray array];
    _menuArray = [NSMutableArray array];
    _commentArray = [NSMutableArray array];
    _categoryArray = [NSMutableArray array];
    _merchantArray = [NSMutableArray array];
    _small_menusArray = [NSMutableArray array];
    _small_categoryArray = [NSMutableArray array];
    _small_imagesURL = [NSMutableArray array];
    
    _kdates = [NSMutableArray array];
    _kdescs = [NSMutableArray array];
    _kmeal_ids = [NSMutableArray array];
    _ktimes = [NSMutableArray array];
    _seats = [NSMutableArray array];
    
    [self loadMerchantDetail];
    

    if (!self.is_introduction) {
        
        [self.view addSubview:self.bottomView];
        _bottomView.yiyou.text =[NSString stringWithFormat:@"%@ %@",self.kdate_desc,self.meal_time];
        if (self.left_right==1) {
            TaoCanModel *model = self.menus_copy[0];
            _bottomView.price.text =[NSString stringWithFormat:@"%@",model.price];
            _bottomView.price_desc.text =[NSString stringWithFormat:@"元/%@",model.menu_people_desc];
            
        }else{
            if (self.left_right==2) {
                TaoCanModel *model = self.menus_copy[1];
                _bottomView.price.text =[NSString stringWithFormat:@"%@",model.price];
                _bottomView.price_desc.text =[NSString stringWithFormat:@"元/%@",model.menu_people_desc];
            }else{
                _bottomView.price.text =@"";
                _bottomView.price_desc.text =@"";
            }
        }
        [_bottomView.orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];

        if (self.is_from_topic) {
            [_bottomView.orderBtn setTitle:@"选择餐厅" forState:UIControlStateNormal];
        }

        

    }
    
    
}
- (void)pushToCommentController{
    ///点击查看评论
    [MobClick event:@"click_detail_comment"];
    HQCommentViewController *comment = [[HQCommentViewController alloc] init];
    comment.merchant_id = [NSString stringWithFormat:@"%d",self.merchant_id];
    [self.navigationController pushViewController:comment animated:YES];
}
- (void)loadMerchantDetailBack{
    [self.menus removeAllObjects];
    _bottomView.yiyou.text =[NSString stringWithFormat:@"%@ %@",self.kdate_desc,self.meal_time];
    if (self.is_from_topic) {
        _bottomView.price.text =[NSString stringWithFormat:@"%@",self.model.price];
        _bottomView.price_desc.text =@"元/人";
    }else{
        if (self.left_right==1) {
            TaoCanModel *model = self.menus_copy[0];
            _bottomView.price.text =[NSString stringWithFormat:@"%@",model.price];
            _bottomView.price_desc.text =[NSString stringWithFormat:@"元/%@",model.menu_people_desc];
            
        }else{
            if (self.left_right==2) {
                TaoCanModel *model = self.menus_copy[1];
                _bottomView.price.text =[NSString stringWithFormat:@"%@",model.price];
                _bottomView.price_desc.text =[NSString stringWithFormat:@"元/%@",model.menu_people_desc];
            }else{
                _bottomView.price.text =@"";
                _bottomView.price_desc.text =@"";
            }
        }

    }
    

    
    if (self.is_to_topic_join) {
        [self orderBtnClick];
    }
    
}
#pragma mark - 加载数据
- (void)loadMerchantDetail{
    
    HttpMerchantDetail *detail = [HttpMerchantDetail sharedInstance];
    [detail merchantDetailWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng merchant_id:[NSString stringWithFormat:@"%d",self.merchant_id] local:self.local viewController:self bestSelect_index:-1 meal_id:self.meal_id meal_date:self.kdate];
    
}
- (void)loadMerchantDetailtap{

    HttpMerchantDetail *detail = [HttpMerchantDetail sharedInstance];
    [detail merchantDetailWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng merchant_id:[NSString stringWithFormat:@"%d",self.merchant_id] local:self.local viewController:self bestSelect_index:-1 meal_id:self.meal_id meal_date:self.kdate];
    
}
#pragma mark- 弹起选择人数
- (void)orderBtnClick{
    if (self.is_from_topic) {
        HttpTopicSponsor *sponsor = [HttpTopicSponsor sharedInstance];
        [sponsor sendWithController:self];
        return;
    }


    ButtonsView *buttonsView = [[ButtonsView alloc] initWithDelegate:self selectedIndex:1 OtherTitles:self.seats viewTag:0 num:4 frame:CGRectMake(0,0, ScreenW-30, 0)people_hint:@""];
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

#pragma mark 跳转评价
- (void)commentClick{
    ///点击撰写评价
    [MobClick event:@"click_detail_review"];
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        FDLoginViewController *verification = [[FDLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
        [self presentViewController:nav animated:YES completion:nil];
        return;
        
    }else{
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
    
}
#pragma mark 跳转地图
- (void)addressBtnClick{
    [MobClick event:@"click_detail_address"];
    
    FDDetailMapViewController *map = [[FDDetailMapViewController alloc] init];
    map.lat = self.model.lat;
    map.lng = self.model.lng;
    map.name = self.model.merchant_name;
    map.address = self.model.address;
    [self.navigationController pushViewController:map animated:YES];
}
#pragma mark 跳转评论
- (void)commentBtnClick{
    ///点击查看评论
    [MobClick event:@"click_detail_comment"];
    HQCommentViewController *comment = [[HQCommentViewController alloc] init];
    comment.merchant_id = [NSString stringWithFormat:@"%d",self.merchant_id];
    [self.navigationController pushViewController:comment animated:YES];
    
    
    
}

#pragma mark - UITableViewDataSource Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 0.01;
        
    }
    if (section == 2) {
        
        return 40;
        
    }
    
    return 0.01;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return 40;
        
    }
    
    return 0.01;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
       if (section == 2) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(6, 10, ScreenW-12, 31)];
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
    if (section == 2) {
        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        footerView.backgroundColor = [UIColor whiteColor];
        UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(6, -1, ScreenW-12, 10)];
        alertView.backgroundColor = [FDUtils colorWithHexString:@"F6F6F6"];
        alertView.layer.cornerRadius = 1;
        alertView.layer.masksToBounds = YES;
        [footerView addSubview:alertView];
        return footerView;
        
    }
    return nil;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }
    else if (section==2){
        return self.friend_hint.count;
    }else{
        
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0&&indexPath.row == 0) {
        FDDetailImageCell *cell = [FDDetailImageCell cellWithTableView:tableView imagesURL:_imagesURL];
        
        return cell;
    }else if (indexPath.section == 1){
        FDMerchantDetail_Menu_Cell *cell = [FDMerchantDetail_Menu_Cell cellWithTableView:tableView categoryArray:self.categoryArray menuArray:self.menuArray hasTC:self.menus_copy.count == 0?NO:YES is_introduction:YES];
        [cell.leftBtn addTarget:self action:@selector(taocan1Selected:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.rightBtn addTarget:self action:@selector(taocan2Selected:) forControlEvents:UIControlEventTouchUpInside];
        cell.select_tips_H.constant = 0;
        cell.select_tip_Btn.hidden = YES;
        if (self.menus_copy.count == 0) {///一个套餐也没有
            cell.rightViewWidth.constant = 0;
            cell.rightView.hidden = YES;
            cell.leftbtnCenterY.constant = 0;
            cell.leftView.hidden = YES;
            cell.booked1.hidden = YES;
            cell.booked2.hidden = YES;
        }
        
        
        else{///有套餐
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
                
                //cell.suggest1.text = model1.recommend_hint;
                
            }
            
            else{
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
                    }
                    else{
                        
                        cell.booked2.hidden = YES;
                        cell.rightBtn.enabled = YES;
                        
                    }
                    
                    
                }
                
            }
            
        }
        
        return cell;
        
        
    }
    else if (indexPath.section == 2){
        
        
        FDAlertTableViewCell *cell = [FDAlertTableViewCell cellWithTableView:tableView];
        cell.titleLabel.text = self.friend_hint[indexPath.row];
        if ([self.friend_hint[indexPath.row] hasSuffix:[HQDefaultTool getService]]) {
            NSMutableDictionary *heightLightDict=[NSMutableDictionary dictionary];
            heightLightDict[NSFontAttributeName]=[UIFont systemFontOfSize:14];
            heightLightDict[NSForegroundColorAttributeName]=[FDUtils colorWithHexString:@"#666666" alpha:0.5];
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

    
    else if (indexPath.section == 3){
        
        FDmerchantDetail_local_cell *cell = [FDmerchantDetail_local_cell cellWithTableView:tableView];
        cell.local_address.text = self.model.address;
        cell.local_star.show_star = [self.model.star doubleValue];
        cell.content_view.userInteractionEnabled = YES;
        [cell.content_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationMapClick)]];
        
        cell.local_name.text = self.model.merchant_name;
        cell.local_comment.hidden = YES;
//        [cell.local_comment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
        CGRect contentRect = [self.model.merchant_name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-130, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        cell.merchant_Bg_W.constant = contentRect.size.width+100;
        return cell;
    }else if(indexPath.section == 2){
        
        FDCommentCell *cell = [FDCommentCell cellWithTableView:tableView];
        cell.statusFrame = self.commentArray[indexPath.row];
        return cell;
        
        
    }
    return nil;
    
}
- (void)phoneClick{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"电话：%@",[HQDefaultTool getService]], nil];
    [sheet showInView:self.view.window];
}
#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[HQDefaultTool getService]]]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        
        return ([UIScreen mainScreen].bounds.size.width)*0.56649744;
        
    }else if (indexPath.section ==1){
        
        double y = 0;
        
        
        
        for (int i = 0 ; i < self.categoryArray.count; i++) {
            
            
            
            NSArray *array = self.menuArray[i];
            
            double menuY = y;
            
            for (int j=0; j<array.count; j++ ) {
                
                
                
                j%2!=1?(menuY+=0 ):(menuY += 30);
                
                
                
            }
            
            NSInteger count = (array.count%2)==0?(array.count/2):(array.count/2+1);
            
            y += count*30;
            
            
            
        }
        
        y += 23;
        
        
        if (y==0) {
            
            return self.menus_copy.count == 0?150:270;
            
        }
        if (self.menus_copy.count == 0) {
            if ((20+y+40*self.categoryArray.count)-50>0) {
                return (20+y+40*self.categoryArray.count)-50;
            }else{
                return 20+y+40*self.categoryArray.count;
            }
        }else{
            if ((140+ y+40*self.categoryArray.count)-50>0) {
                return (140+ y+40*self.categoryArray.count)-50;
            }else{
                return (140+ y+40*self.categoryArray.count);
            }
        }
       // return self.menus_copy.count == 0?(20+y+40*self.categoryArray.count):(140+ y+40*self.categoryArray.count);
        
    }else if (indexPath.section == 2){
        
        CGRect contentRect = [self.friend_hint[indexPath.row] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-50, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        return contentRect.size.height+10;
        
    }
    else {
        return 179;
    }

}

- (void)locationMapClick{
    FDDetailMapViewController *map = [[FDDetailMapViewController alloc] init];
    map.lat = self.model.lat;
    map.lng = self.model.lng;
    map.name = self.model.merchant_name;
    map.address = self.model.address;
    [self.navigationController pushViewController:map animated:YES];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)buttonsView:(ButtonsView *)buttonsView clickedButtonAtIndex:(NSInteger)buttonIndex sender:(UIButton *)sender title:(NSArray *)array{
    [self.popoverListView dismiss];
    FDSubmitOrderViewController *submit = [[FDSubmitOrderViewController alloc] init];
    submit.merchant_id=[NSString stringWithFormat:@"%d",self.merchant_id];
    submit.merchant_name =self.model.merchant_name;
    submit.icon =self.model.icon;
    submit.kdate =self.kdate;
    submit.kdate_desc = self.kdate_desc;
    submit.meal_time = self.meal_time;
    submit.price = [NSString stringWithFormat:@"%@",self.model.price];
    SeatsModel *model = self.seats[buttonIndex];
    submit.people_desc = model.seat_desc;
    submit.people = [NSString stringWithFormat:@"%@",model.seat_num];
    submit.meal_id = self.meal_id;
    submit.menu_id = self.model.menu_id;
    submit.topic_id = self.topic_id;
    
    [self.navigationController pushViewController:submit animated:YES];

    
}
#pragma mark -- 选择套餐
- (void)taocan1Selected:(UIButton *)sender{
    self.left_right = 1;
    TaoCanModel *model = [self.menus_copy objectAtIndex:0];
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

    [self loadMerchantDetailBack];
    
    [self.tableView reloadData];
}

- (void)taocan2Selected:(UIButton *)sender{
    
    self.left_right = 2;
    [self.menuArray removeAllObjects];
    [self.categoryArray removeAllObjects];
    [self.imagesURL removeAllObjects];
    TaoCanModel *model = [self.menus_copy objectAtIndex:1];
    
    for (MenusModel *menusModel in model.menus) {//小菜单
        NSArray *array = [menusModel.menu_detail componentsSeparatedByString:@","];
        [self.menuArray addObject:array];
        [self.categoryArray addObject:menusModel.menu_name];
        
    }
    for (ImagesModel *imageModel in model.imgs) {
        [self.imagesURL addObject:imageModel.url];
    }

    [self loadMerchantDetailBack];
    
    
    [self.tableView reloadData];
    
}

@end



