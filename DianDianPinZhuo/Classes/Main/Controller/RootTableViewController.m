//
//  RootTableViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/22.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootTableViewController.h"
#import "HQHttpTool.h"
#import "RequestModel.h"
#import "MJRefresh.h"
#import "IQKeyboardManager.h"
@interface RootTableViewController ()

@property(nonatomic,copy)NSString *placeholderStr;
@property(nonatomic,copy)NSString *imageStr;


@end

@implementation RootTableViewController

#pragma mark - 判断数据是否为空,,传入文字和图片名称
- (void)reloadDataNULL:(NSString *)placehold imageName:(NSString *)imageStr{
    
    self.placeholderStr = placehold;
    
    self.imageStr = imageStr;
    
    if (self.datyArray.count == 0||!self.datyArray) {
        
        self.nullView.desLabel.text = placehold;
        
        self.nullView.nullImgView.image = [UIImage imageNamed:imageStr];
        
        self.nullView.hidden = NO;
        
    }else{
        
        self.nullView.hidden = YES;
    }
}
#pragma mark  空数据时显示的视图
- (XBNullView *)nullView{
    if (!_nullView) {
        _nullView = [[XBNullView alloc]initNullViewWithFrame:self.view.bounds andImage:[UIImage imageNamed:@"tip"] andDescription:self.placeholderStr];
        _nullView.desTextColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:102.0/255.0];
        _nullView.desTextFont = [UIFont systemFontOfSize:20];
        _nullView.backgroundColor = [UIColor clearColor];
        _nullView.imgCenterYGap = -ScreenH*0.16;
        self.nullView.hidden = YES;
    }
    _nullView.desLabel.text = self.placeholderStr;
    _nullView.nullImgView.image = [UIImage imageNamed:self.imageStr];
    //_nullView.nullImgView.contentMode = UIViewContentModeScaleAspectFit;
    return _nullView;
}
- (NSString *)placeholderStr{
    
    if (!_placeholderStr) {
        _placeholderStr = @"这里空空如也";
    }
    
    return _placeholderStr;
    
}
- (NSString *)imageStr{
    if (!_imageStr) {
        _imageStr = @"";
    }
    return _imageStr;
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    self.datyArray = [NSMutableArray array];
    
    if (!self.tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1];
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        [_tableView addSubview:self.nullView]
        ;
    }
    if (!self.activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activity.color = [UIColor grayColor];
        _activity.center =CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-64) ;
        [self.view addSubview:_activity];
    }
    
    
}

- (void)setHaveMJRefresh:(BOOL)haveMJRefresh{
    if (haveMJRefresh==YES) {
        [self setupUpRefresh];
        [self setupDownRefresh];
    }
    _haveMJRefresh = haveMJRefresh;
}
#pragma  mark - 下拉刷新
- (void)setupUpRefresh{
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(MJRefreshTop)];
}
#pragma mark - 加载更多
-(void)setupDownRefresh
{
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(MJRefreshMore)];
}
- (void)MJRefreshTop{
    
}
- (void)MJRefreshMore{
    
}

#pragma mark - UITableViewDelegate datasoure
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datyArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end