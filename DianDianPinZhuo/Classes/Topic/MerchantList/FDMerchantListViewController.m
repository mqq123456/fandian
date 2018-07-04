//
//  FDMerchantListViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDMerchantListViewController.h"
#import "MerchantModel.h"
#import "AdsModel.h"
#import "HttpMerchantSearch.h"
#import "FDNearMerchantCell.h"
//#import "FDNearMerchantFrame.h"
#import "FDMerchantIntroductionViewController.h"
#import "ApiProtocol.h"
#import "FDTopicMerchantListFram.h"

@interface FDMerchantListViewController ()

@end

@implementation FDMerchantListViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    ///餐厅列表流量
    [MobClick event:@"pv_list"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
#pragma mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.haveMJRefresh = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"FDMerchantCell" bundle:nil] forCellReuseIdentifier:@"FDMerchantCell"];

    [self addTitleViewWithTitle:@"话题餐厅列表"];

    _time_selected = self.best_select_index;
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //第一次加载数据
    [self loadFirstMerchantSearch];
    
    [SVProgressHUD showWithStatus:@" 正在加载... "];
    
    self.tableView.footer.hidden = YES;
}

#pragma mark - 第一次加载
- (void)loadFirstMerchantSearch{
    
    HttpMerchantSearch *search = [HttpMerchantSearch sharedInstance];
    search.ApiUrl =API_TOPIC_MERCHANT_SEARCH;
    [search merchantSearchWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng meal_id:self.meal_id people:self.peopleNum meal_date:self.kdate local:[NSString stringWithFormat:@"%d",self.local] viewController:self];
    
}

- (void)MJRefreshTop{
    HttpMerchantSearch *search = [HttpMerchantSearch sharedInstance];
    search.ApiUrl =API_TOPIC_MERCHANT_SEARCH;
    [search MJRefreshTopmerchantSearchWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng meal_id:self.meal_id people:self.peopleNum meal_date:self.kdate local:[NSString stringWithFormat:@"%d",self.local] viewController:self];
}

- (void)MJRefreshMore{
    HttpMerchantSearch *search = [HttpMerchantSearch sharedInstance];
    search.ApiUrl =API_TOPIC_MERCHANT_SEARCH;
    [search MJRefreshMoremerchantSearchWithLat:self.latString lng:self.lngString local_lat:self.local_lat local_lng:self.local_lng meal_id:self.meal_id people:self.peopleNum meal_date:self.kdate local:[NSString stringWithFormat:@"%d",self.local] viewController:self];
}

#pragma mark - UITableViewDataSource Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDTopicMerchantListFram *frame = self.datyArray[indexPath.row];

    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDNearMerchantCell *cell = [FDNearMerchantCell cellWithTableView:tableView];

    cell.topic_statusFrame = self.datyArray[indexPath.row];

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FDTopicMerchantListFram *frame = self.datyArray[indexPath.row];
    ///已订满
    if([frame.status.sold_out intValue]==1){
    
        [SVProgressHUD showImage:nil status:self.soldout_hint];
        
    }else{
        FDMerchantIntroductionViewController *detail = [[FDMerchantIntroductionViewController alloc] init];
        detail.model = frame.status;
        detail.latString = self.latString;
        detail.lngString = self.lngString;
        detail.local_lng = self.local_lng;
        detail.local_lat = self.local_lat;
        detail.kdate = self.kdate;
        detail.peopleNum = self.peopleNum;
        detail.people_desc = self.people_desc;
        detail.meal_id = self.meal_id;
        detail.meal_time = self.meal_time;
        detail.kdate_desc = self.kdate_desc;
        detail.img =self.img;
        detail.is_bz = @"0";
        detail.content = self.content;
        detail.is_from_topic = YES;
        detail.local = [NSString stringWithFormat:@"%d",self.local];
        
        [self.navigationController pushViewController:detail animated:YES];

    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datyArray.count;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
