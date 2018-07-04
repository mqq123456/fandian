//
//  FDDetailViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/22.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDDetailViewController.h"
#import "FDDetailImageCell.h"
#import "FDDetailSection0Row1Cell.h"
#import "FDDetailSection1Row0Cell.h"
#import "FDDetailSection2Cell.h"
#import "CommentModel.h"
#import "FDOrderViewController.h"
#import "FDDetailMapViewController.h"
#import "ImagesModel.h"
#import "NSString+Urldecode.h"
#import "FDLoginViewController.h"
#import "HQCommentViewController.h"
#import "FDEvaluationViewController.h"
#import "FDMenuView.h"
#import "DashedLine.h"
#import "AdView.h"
#import "HttpMerchantDetail.h"

@interface FDDetailViewController ()<FDLoginViewControllerDelegate>

@property (nonatomic ,weak) FDMenuView *menu;
@end

@implementation FDDetailViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///餐厅详情流量
    [MobClick event:@"pv_detail"];    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.menu removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTitleViewWithTitle:self.model.merchant_name];

    ///评价完成之后刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMerchantDetail) name:RefreshDetailViewController object:nil];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    self.tableView.tableFooterView = footerView;
    
    _imagesURL = [NSMutableArray array];
    _menuArray = [NSMutableArray array];
    _commentArray = [NSMutableArray array];
    _categoryArray = [NSMutableArray array];
    _merchantArray = [NSMutableArray array];
    _small_menusArray = [NSMutableArray array];
    _small_categoryArray = [NSMutableArray array];
    _small_imagesURL = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_btn_pinglun_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
    
    [self loadMerchantDetail];
}

#pragma mark - 加载数据
- (void)loadMerchantDetail{
//    
//    HttpMerchantDetail *detail = [HttpMerchantDetail sharedInstance];
//    [detail merchantDetailWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng meal_id:self.meal_id merchant_id:[NSString stringWithFormat:@"%d",self.model.merchant_id] meal_date:self.kdate local:self.local viewController:self];
   
}

#pragma mark - 去下单
- (void)isToOrder{
    [self orderClick];
}
- (void)orderClick{
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        FDLoginViewController *verification = [[FDLoginViewController alloc] init];
        verification.isFromDetail = YES;
        verification.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }else{
        ///点击下单
        NSString *mode;
        
        if ([self.peopleNum intValue]==10) {
            mode = @"包桌";
        }else{
        
            mode = @"拼桌";
        }
        
        [MobClick event:@"click_detail_order" attributes:@{@"restaurant" : self.model.merchant_name,
                                                           @"price":[NSString stringWithFormat:@"%@", self.model.price],
                                                           @"time" : self.meal_time ,
                                                              @"mode" :mode ,
                                                              @"number":self.peopleNum}];
        

        FDOrderViewController *order = [[FDOrderViewController alloc] init];
        order.merchant_id = [NSString stringWithFormat:@"%d",self.model.merchant_id];
        order.merchant_name = self.model.merchant_name;
        order.icon = self.model.icon;
        order.kdate = self.kdate;
        order.kdate_desc = self.kdate_desc;
        order.meal_time = self.meal_time;
        order.price = [NSString stringWithFormat:@"%@", self.model.price];
        order.people = self.peopleNum;
        order.meal_id = self.meal_id;
        order.menu_id = self.model.menu_id;
        
        
        [self.navigationController pushViewController:order animated:YES];
        
    }
    
}

#pragma mark 跳转评价
- (void)rightClick{
    ///点击撰写评价
    [MobClick event:@"click_detail_review"];
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        FDLoginViewController *verification = [[FDLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
        [self presentViewController:nav animated:YES completion:nil];
        return;
        
    }else{
        FDEvaluationViewController *envaluation = [[FDEvaluationViewController alloc] init];
        envaluation.merchant_id =[NSString stringWithFormat:@"%d", self.model.merchant_id];
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
    comment.merchant_id = [NSString stringWithFormat:@"%d",self.model.merchant_id];
    [self.navigationController pushViewController:comment animated:YES];
}
#pragma mark - 查看小菜单
- (void)small_menu_hintBtnClick{
    [MobClick event:@"click_detail_selection"];
    //点击查看小菜单
    FDMenuView *menu = [[[NSBundle mainBundle]loadNibNamed:@"FDMenuView" owner:nil options:nil]lastObject];
    
    menu.menuTitle.text = _small_menu_title;
    
    if (IPhone6Plus) {
        menu.headImageViewH.constant = 180;
    }else if (IPhone6) {
        menu.headImageViewH.constant = 165;
    }else{
        menu.headImageViewH.constant = 145;
    }
    if (self.small_imagesURL.count<=1) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.frame = menu.headImageView.bounds;
        if (IPhone6Plus) {
            imageView.height = 180;
        }else if (IPhone6) {
            imageView.height =  165;
        }else{
            imageView.height = 145;
        }
        
        if (self.small_imagesURL.count==0) {
            imageView.image = [UIImage imageNamed:@"ad_image"];
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.small_imagesURL[0]] placeholderImage:[UIImage imageNamed:@"ad_image"]];
        }
        
        [menu.headImageView addSubview:imageView];
        
    }else{
        
        AdView *view = [AdView adScrollViewWithFrame:CGRectMake(0, 0, IPhone6Plus?[UIScreen mainScreen].bounds.size.width-40:[UIScreen mainScreen].bounds.size.width-30, menu.headImageViewH.constant) imageLinkURL:self.small_imagesURL placeHoderImageName:@"ad_image" pageControlShowStyle:UIPageControlShowStyleCenter];
        [menu.contentView addSubview:view];
        

//        if (IPhone6Plus) {
//            AdView *view = [AdView adScrollViewWithFrame:CGRectMake(0, 0, menu.headImageView.bounds.size.width, menu.headImageView.bounds.size.height+20) imageLinkURL:self.small_imagesURL placeHoderImageName:@"ad_image" pageControlShowStyle:UIPageControlShowStyleCenter];
//            [menu.contentView addSubview:view];
//            
//        }else if (IPhone6) {
//            AdView *view = [AdView adScrollViewWithFrame:CGRectMake(0, 0, menu.headImageView.bounds.size.width, menu.headImageView.bounds.size.height+20) imageLinkURL:self.small_imagesURL placeHoderImageName:@"ad_image" pageControlShowStyle:UIPageControlShowStyleCenter];
//            [menu.contentView addSubview:view];
//            view.height =  195;
//        }else{
//            AdView *view = [AdView adScrollViewWithFrame:CGRectMake(0, 0, menu.headImageView.bounds.size.width-60, menu.headImageView.bounds.size.height-10) imageLinkURL:self.small_imagesURL placeHoderImageName:@"ad_image" pageControlShowStyle:UIPageControlShowStyleCenter];
//            [menu.contentView addSubview:view];
//            view.height = 175;
//        }
        
        
        
    }
    
    if (IPhone6Plus) {
        double y = 0;
        for (int i = 0 ; i < self.small_categoryArray.count; i++) {
            UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 60, 30)];
            categoryLabel.font = [UIFont systemFontOfSize:15];
            categoryLabel.textAlignment = NSTextAlignmentCenter;
            categoryLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
            categoryLabel.text = self.small_categoryArray[i];
            [menu.menuListView addSubview:categoryLabel];
            NSArray *array = self.small_menusArray[i];
            double x = 60;
            double menuY = y;
            for (int j=0; j<array.count; j++ ) {
                double w = ([UIScreen mainScreen].bounds.size.width-100)/3;
                double h = 30;
                UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, menuY, w, h)];
                menuLabel.text = array[j];
                menuLabel.font = [UIFont systemFontOfSize:15];
                if (i>0) {
                    menuLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
                }else{
                    menuLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
                }
                [menu.menuListView addSubview:menuLabel];
                j%3!=2?(x += w ):(x=60,menuY += 26);
                
            }
            NSInteger count = (array.count%3)==0?(array.count/3):(array.count/3+1);
            y += count*26;
        }
        
    }else{
        double y = 0;
        for (int i = 0 ; i < self.small_categoryArray.count; i++) {
            UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 60, 30)];
            categoryLabel.font = [UIFont systemFontOfSize:15];
            categoryLabel.textAlignment = NSTextAlignmentCenter;
            categoryLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
            categoryLabel.text = self.small_categoryArray[i];
            [menu.menuListView addSubview:categoryLabel];
            NSArray *array = self.small_menusArray[i];
            double x = 60;
            double menuY = y;
            for (int j=0; j<array.count; j++ ) {
                double w = ([UIScreen mainScreen].bounds.size.width-90)/2;
                double h = 30;
                UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, menuY, w, h)];
                menuLabel.text = array[j];
                menuLabel.font = [UIFont systemFontOfSize:15];
                if (i>0) {
                    menuLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
                }else{
                    menuLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
                }
                [menu.menuListView addSubview:menuLabel];
                j%2!=1?(x += w ):(x=60,menuY += 26);
                
            }
            NSInteger count = (array.count%2)==0?(array.count/2):(array.count/2+1);
            y += count*26;
        }
        
    }
    
    double y = 0;
    if (IPhone6Plus) {
        for (int i = 0 ; i < self.small_categoryArray.count; i++) {
            NSArray *array = self.small_menusArray[i];
            double menuY = y;
            for (int j=0; j<array.count; j++ ) {
                j%3!=2?(menuY += 0):(menuY += 26);
                
            }
            NSInteger count = (array.count%3)==0?(array.count/3):(array.count/3+1);
            y += count*26;
        }
        
    }else{
        for (int i = 0 ; i < self.small_categoryArray.count; i++) {
            
            NSArray *array = self.small_menusArray[i];
            double menuY = y;
            for (int j=0; j<array.count; j++ ) {
                
                j%2!=1?(menuY+=0 ):(menuY += 26);
                
            }
            NSInteger count = (array.count%2)==0?(array.count/2):(array.count/2+1);
            y += count*26;
        }
        
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IPhone6Plus) {
        button.x = ([UIScreen mainScreen].bounds.size.width-40-140)/2;
    }else{
        button.x =  ([UIScreen mainScreen].bounds.size.width-30-140)/2+5;
    }
    
    if (IPhone6Plus) {
        button.y = 254+y;
    }else if (IPhone6){
        button.y = 230+y;
    }else{
        button.y = 205+y;
    }
    button.width = 140;
    button.height = 40;
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 3;
    [button setTitle:@"我知道了" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"detail_pin_btn_back_nor"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"detail_pin_btn_back_hei"] forState:UIControlStateHighlighted];
    [menu.contentView addSubview:button];
    [button addTarget:self action:@selector(menuCancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (IPhone6Plus) {
        menu.backViewH.constant = 224+y+100;
    }else if (IPhone6){
        menu.backViewH.constant = 200+y+100;
    }else{
        menu.backViewH.constant = 165+y+100;
    }
    
    menu.contentView.transform = CGAffineTransformScale(menu.contentView.transform, 0.2, 0.2);
    [self.navigationController.view addSubview:menu];
    self.menu = menu;
    [UIView animateWithDuration:0.5 animations:^{
        menu.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)menuCancleBtnClick{
    [UIView animateWithDuration:0.5 animations:^{
        self.menu.alpha = 0;
    } completion:^(BOOL finished) {
        [self.menu removeFromSuperview];
    }];
}


#pragma mark - UITableViewDataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }else{
        return self.merchantArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {//餐厅图片
        FDDetailImageCell *cell = [FDDetailImageCell cellWithTableView:tableView imagesURL:_imagesURL];
        
        return cell;
    }else if(indexPath.section == 0 && indexPath.row == 1) {//今日菜单，我要拼桌
        FDDetailSection0Row1Cell *cell = [FDDetailSection0Row1Cell cellWithTableView:tableView menuArray:self.menuArray categoryArray:self.categoryArray];
        if ([_kdate_desc isEqualToString:@"今天"]) {
           cell.today_menu.text = @"今日菜单";
        }else if ([_kdate_desc isEqualToString:@"明天"]){
           cell.today_menu.text = @"明日菜单";
        }else{
        
            cell.today_menu.text = _kdate_desc;
        
        }
        
        if ([self.peopleNum integerValue]==10) {
            [cell.pinBtn setTitle:@"我要包桌" forState:UIControlStateNormal];
            cell.meirenLabel.text = @"/桌";
            cell.price.text = [NSString stringWithFormat:@"%d",[self.model.price intValue]*10];
            
        }else{
            [cell.pinBtn setTitle:@"我要拼桌" forState:UIControlStateNormal];
            cell.meirenLabel.text = @"/人";
            cell.price.text = [NSString stringWithFormat:@"%@",self.model.price];
            
        }
        [cell.pinBtn addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
        if ([_small_menu_hint isEqualToString:@""]||self.small_categoryArray.count==0||self.small_menusArray.count==0) {
            cell.small_line.hidden = YES;
            cell.small_menu_ViewH.constant=0;
            cell.small_menu_hintBtn.hidden = YES;
            DashedLine *line = [[DashedLine alloc] initWithFrame:CGRectMake(0, 0, IPhone6Plus?[UIScreen mainScreen].bounds.size.width-40:[UIScreen mainScreen].bounds.size.width-30, 3)];
            cell.line1H.constant = 0.5;
            cell.line2H.constant = 0.5;
            [cell.priceView addSubview:line];
            [cell.backView.layer setShadowColor:[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1].CGColor];//阴影的颜色
            [cell.backView.layer setShadowOffset:CGSizeMake(0, 4)];// 阴影的范围
            [cell.backView.layer setShadowOpacity:1];// 阴影透明度
            [cell.backView.layer setShadowRadius:1];// 阴影扩散的范围控制

        }else{
//            
//            if ([self.peopleNum intValue] > 4) {
//                cell.small_line.hidden = YES;
//                cell.small_menu_ViewH.constant=0;
//                cell.small_menu_hintBtn.hidden = YES;
//                DashedLine *line = [[DashedLine alloc] initWithFrame:CGRectMake(0, 0, IPhone6Plus?[UIScreen mainScreen].bounds.size.width-40:[UIScreen mainScreen].bounds.size.width-30, 3)];
//                cell.line1H.constant = 0.5;
//                cell.line2H.constant = 0.5;
//                [cell.priceView addSubview:line];
//                [cell.backView.layer setShadowColor:[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1].CGColor];//阴影的颜色
//                [cell.backView.layer setShadowOffset:CGSizeMake(0, 4)];// 阴影的范围
//                [cell.backView.layer setShadowOpacity:1];// 阴影透明度
//                [cell.backView.layer setShadowRadius:1];// 阴影扩散的范围控制
//
//            }else{
                cell.small_line.hidden = NO;
                [cell.small_menu_hintBtn setTitle:_small_menu_hint forState:UIControlStateNormal];
                cell.clean_plate_hint.text = _clean_plate_hint;
                [cell.small_menu_hintBtn addTarget:self action:@selector(small_menu_hintBtnClick) forControlEvents:UIControlEventTouchUpInside];
                DashedLine *line = [[DashedLine alloc] initWithFrame:CGRectMake(0, 0, IPhone6Plus?[UIScreen mainScreen].bounds.size.width-40:[UIScreen mainScreen].bounds.size.width-30, 3)];
                cell.line1H.constant = 0.5;
                cell.line2H.constant = 0.5;
                [cell.small_menu_view addSubview:line];
                [cell.backView.layer setShadowColor:[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1].CGColor];//阴影的颜色
                [cell.backView.layer setShadowOffset:CGSizeMake(0, 4)];// 阴影的范围
                [cell.backView.layer setShadowOpacity:1];// 阴影透明度
                [cell.backView.layer setShadowRadius:1];// 阴影扩散的范围控制

            
//            }
            
            
        }
        
        return cell;
    }else if (indexPath.section == 1){//评价,地址，
        FDDetailSection1Row0Cell *cell = [FDDetailSection1Row0Cell cellWithTableView:tableView];//如果没有评论的情况
        [cell.addressBtn addTarget:self action:@selector(addressBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cell.merchant_name.text = self.model.merchant_name;
        cell.address.text = self.model.address;
        [cell.merchant_icon sd_setImageWithURL:[NSURL URLWithString:self.model.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.mearchant_star.show_star = [self.model.star doubleValue];
        if (self.commentArray.count>=1) {
            CommentModel *commentModel = self.commentArray[0];
            [cell.comment_icon sd_setImageWithURL:[NSURL URLWithString:commentModel.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            cell.comment_name.text = commentModel.nick_name;
            NSString *decodedString = [commentModel.content stringByDecodingURLFormat];
            cell.content.text = decodedString;
            cell.comment_star.show_star = [commentModel.star doubleValue];
            cell.creat_time.text = commentModel.create_time;
            [cell.commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }else{
            cell.commentHead_height.constant = 0;
            cell.commentHeadView.hidden = YES;
            cell.commentView.hidden = YES;
        }
        
        return cell;
    }else{//附近推荐
        FDDetailSection2Cell *cell = [FDDetailSection2Cell cellWithTableView:tableView];
        
        MerchantModel *merchantModel = self.merchantArray[indexPath.row];
        
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:merchantModel.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.merchant_name.text = merchantModel.merchant_name;
        cell.distance.text = [NSString stringWithFormat:@"距您约%@  %d人品尝",merchantModel.distance,merchantModel.tastes];
        cell.price.text = [NSString stringWithFormat:@"%@",merchantModel.price];
        cell.star.show_star = [merchantModel.star doubleValue];
        
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return ([UIScreen mainScreen].bounds.size.width-30)*0.566;
    }else if (indexPath.section ==0 && indexPath.row ==1){
        double y = 0;
        if (IPhone6Plus) {
            for (int i = 0 ; i < self.categoryArray.count; i++) {
                NSArray *array = self.menuArray[i];
                double menuY = y;
                for (int j=0; j<array.count; j++ ) {
                    j%3!=2?(menuY += 0):(menuY += 26);
                    
                }
                NSInteger count = (array.count%3)==0?(array.count/3):(array.count/3+1);
                y += count*26;
            }
            
        }else{
            for (int i = 0 ; i < self.categoryArray.count; i++) {
                
                NSArray *array = self.menuArray[i];
                double menuY = y;
                for (int j=0; j<array.count; j++ ) {
                    
                    j%2!=1?(menuY+=0 ):(menuY += 26);
                    
                }
                NSInteger count = (array.count%2)==0?(array.count/2):(array.count/2+1);
                y += count*26;
            }
            
        }
        if ([_small_menu_hint isEqualToString:@""]||self.small_categoryArray.count==0||self.small_menusArray.count==0) {
            return 160+y;
        }else{
//            if ([self.peopleNum intValue]>4) {
//                return 160+y;
//            }
            return 160 + y+60;
        }
    }else if (indexPath.section ==1){
        if (self.commentArray.count>=1) {
            CommentModel *commentModel = self.commentArray[0];
            NSString *decodedString = [commentModel.content stringByDecodingURLFormat];
            CGRect contentRect = [decodedString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-83, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            return 285+contentRect.size.height;
        }else{
            return 140.0;
        }
        
    }else{
        return 80;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        ///点击附近推荐
        [MobClick event:@"click_detail_recommend"];
        
        MerchantModel *model = self.merchantArray[indexPath.row];
        FDDetailViewController *detail = [[FDDetailViewController alloc] init];
        detail.model = model;
        detail.latString = self.latString;
        detail.lngString = self.lngString;
        detail.local_lat = self.local_lat;
        detail.local_lng = self.local_lng;
        detail.local = self.local;
        detail.kdate = self.kdate;
        detail.peopleNum = self.peopleNum;
        detail.meal_id=self.meal_id;
        detail.meal_time = self.meal_time;
        detail.kdate_desc = self.kdate_desc;
        [self.navigationController pushViewController:detail animated:YES];
    }
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
