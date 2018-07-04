//
//  HQAddressViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/8/22.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "HQAddressViewController.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import <CoreLocation/CoreLocation.h>
#import "HQSearchBar.h"
#import "SearchEmptyView.h"
#import "HQSearchHistoryTool.h"

@interface HQAddressViewController ()< AMapSearchDelegate, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
{
    //...
    UITableView *_tableView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    NSString *textFieldText;
    HQSearchBar *searchBar;
}
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) AMapGeoPolygon *polygon;
@property (nonatomic, weak) UIActivityIndicatorView *activity;
@property (nonatomic, weak) SearchEmptyView *emptyView;
@property (nonatomic, copy) NSMutableArray *pois;
@property (nonatomic,assign)BOOL lishi;
@property (nonatomic,strong)AMapPlaceSearchRequest *request;
@end

@implementation HQAddressViewController

#pragma mark - cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.lishi = YES;

    self.title = @"换饭点";
    self.view.backgroundColor =[FDUtils colorWithHexString:@"#eaeaea"];
    self.request = [[AMapPlaceSearchRequest alloc] init];
    self.request.location = [AMapGeoPoint locationWithLatitude:[self.lat doubleValue] longitude:[self.lng doubleValue]];
    self.request.types = @[@"商务写字楼"];
    self.request.city = @[@"北京"];
    _search=[[AMapSearchAPI alloc]initWithSearchKey:@"65b30caa37e370093985cfc3e3a710aa" Delegate:self];
    _search.delegate = self;
    
    _pois = [NSMutableArray arrayWithArray:[[HQSearchHistoryTool sharedInstance]recordList]];
    textFieldText = @"";
    [self creatUI];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///切换地点流量
    [MobClick event:@"pv_changeaddress"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - creatUI
- (void)creatUI
{
    searchBar = [HQSearchBar searchBar];
    searchBar.x = 20 ;
    searchBar.y = 14;
    searchBar.width = [UIScreen mainScreen].bounds.size.width - 40;
    searchBar.height = 43;
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    [searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    searchBar.keyboardType = UIKeyboardTypeWebSearch;

    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.frame = CGRectMake(0, 131-64, [UIScreen mainScreen].bounds.size.width, 46);
    [locationBtn setTitle:@"定位当前位置" forState:UIControlStateNormal];
    [locationBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] forState:UIControlStateNormal];
    locationBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [locationBtn setImage:[UIImage imageNamed:@"address_ico_dingwei"] forState:UIControlStateNormal];
    locationBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:locationBtn];
    [locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114,CGRectGetWidth(self.view.bounds), [UIScreen mainScreen].bounds.size.height-178) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //通知，没有消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backClick) name:locationback object:nil];
    
}
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)locationBtnClick:(UIButton *)locationBtn{
    [MobClick event:@"click_changeaddress_location"];
    [locationBtn setTitle:@"定位中..." forState:UIControlStateNormal];
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:Reposition object:nil];
    
}

- (void)textFieldDidChange:(UITextField *)textField{
    if (![textField.text isEqualToString:@""]) {
        self.lishi = NO;
        [self searchWithKeyword:textField.text];
        [self.emptyView removeFromSuperview];
    }else{
        self.lishi = YES;
        _tableView.frame = CGRectMake(0, 114,CGRectGetWidth(self.view.bounds), [UIScreen mainScreen].bounds.size.height-178);
        [self.pois removeAllObjects];
        _pois = [NSMutableArray arrayWithArray:[[HQSearchHistoryTool sharedInstance]recordList]];
        [self.emptyView removeFromSuperview];
        [_tableView reloadData];
    }
}

#pragma mark - 搜索
- (void)searchWithKeyword:(NSString *)keyword
{
    textFieldText = keyword;
    if ( _search == nil)
    {
        [SVProgressHUD showImage:nil status:@"search failed"];

        return;
    }
    if ([keyword isEqualToString:@" "]) {
        [SVProgressHUD showImage:nil status:@"无效输入"];
        textFieldText = @"";
        searchBar.text = textFieldText;
        
        return;
    }
    if ([keyword isEqualToString:@""]||[keyword isEqualToString:@" "]) {
        [_pois removeAllObjects];
        [self.emptyView removeFromSuperview];
        [_tableView reloadData];
        return;
    }
    self.request.keywords =keyword;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_search AMapPlaceSearch:self.request];
    });
    
    
}
#pragma mark - AMapSearchDelegate
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:
(AMapPlaceSearchResponse *)response
{
    if ([searchBar.text isEqualToString:@""]) {
        self.lishi = YES;
    }else{
        if (response.pois.count >0)
        {
            [_pois removeAllObjects];
            _tableView.frame = CGRectMake(0, 114, CGRectGetWidth(self.view.bounds), [UIScreen mainScreen].bounds.size.height-175);
            [self.emptyView removeFromSuperview];
            
            [_pois addObjectsFromArray:response.pois];
            [_tableView reloadData];
        }else{
            [_pois removeAllObjects];
            [self.emptyView removeFromSuperview];
            [_tableView reloadData];
            SearchEmptyView *emptyView = [[[NSBundle mainBundle]loadNibNamed:@"SearchEmptyView" owner:nil options:nil]lastObject];
            emptyView.title.text =@"找不到你所输入的位置";
            emptyView.frame = CGRectMake(0, 114, _tableView.frame.size.width, [UIScreen mainScreen].bounds.size.height-121);
            [self.view addSubview:emptyView];
            self.emptyView = emptyView;
        }

    
    }
}

- (void)searchRequest:(id)request didFailWithError:(NSError *)error{
    [SVProgressHUD showImage:nil status:@"你的网络好像出了点问题"];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if( self.lishi){
        return 44;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.lishi) {
        UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        view.backgroundColor = [FDUtils colorWithHexString:@"#f0f0f0"];
        UILabel *lishi = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 44)];
        lishi.text = @"搜索历史";
        lishi.font = [UIFont systemFontOfSize:16];
        lishi.textColor = FDColor(153, 153, 153, 1);
        [view addSubview:lishi];
        return view;
    }else{
        return nil;
    
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath
                                                                               *)indexPath
{
  
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    AMapPOI *poi = _pois[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.textLabel.textColor = FDColor(51, 51, 51, 1);
    cell.detailTextLabel.textColor = FDColor(153, 153, 153, 1);
    if (poi.address) {
        cell.detailTextLabel.text = poi.address;
    }
    if (self.lishi) {
        cell.imageView.image = [UIImage imageNamed:@"address_ico_llishi"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"bow_ico_mohufeilei"];
    }
  
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, ScreenW, 1)];
    line.backgroundColor = [FDUtils colorWithHexString:@"#f2f2f2"];
    [cell.contentView addSubview:line];
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pois.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ///切换地点搜索结果流量
    [MobClick event:@"pv_searchresult"];
    
    HQSearchHistoryTool *dc=[HQSearchHistoryTool sharedInstance];
    AMapPOI *poi = _pois[indexPath.row];
    
    int i = [[HQDefaultTool getSearchCount]intValue];
    if (![dc isExistRecordWithSearchName:poi.name]) {
        [dc addSearchName:poi idString:[NSString stringWithFormat:@"%d",i]];
        i++;
        [HQDefaultTool setSearchCount:[NSString stringWithFormat:@"%d",i]];
    }else{
        [dc removeSelectedHistoryWithName:poi.name];
        [dc addSearchName:poi idString:[NSString stringWithFormat:@"%d",i]];
        i++;
        [HQDefaultTool setSearchCount:[NSString stringWithFormat:@"%d",i]];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(backWithAddress:lng:lat:)]) {
        AMapPOI *poi = _pois[indexPath.row];
        [self.delegate backWithAddress:poi.name lng:[NSString stringWithFormat:@"%.16f",poi.location.longitude] lat:[NSString stringWithFormat:@"%.16f",poi.location.latitude]];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self searchWithKeyword:textField.text];
    return YES;
}
-(void)viewDidLayoutSubviews
{
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
