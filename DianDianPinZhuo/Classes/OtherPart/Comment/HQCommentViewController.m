//
//  HQCommentViewController.m
//  normandy
//
//  Created by user on 15/6/25.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//  评论

#import "HQCommentViewController.h"
#import "MJRefresh.h"
#import "HQHttpTool.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Urldecode.h"
#import "HttpMerchantCommentList.h"
#import "FDCommentCell.h"
#import "FDCommentFrame.h"
#import "FDUserDetailViewController.h"
#import "FDCommentDetailViewController.h"

@interface HQCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HQCommentViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTitleViewWithTitle:@"所有评价"];
    self.dataArray = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    self.view.backgroundColor = Background_Color;
    _tableView.backgroundColor = Background_Color;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setupUpRefresh];
    [self setupDownRefresh];
    _tableView.footer.hidden = YES;
}


#pragma  mark - 下拉刷新
- (void)setupUpRefresh{
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadMerchantCommentList)];
    [_tableView.header beginRefreshing];
}

- (void)loadMerchantCommentList{
    HttpMerchantCommentList *commentList = [HttpMerchantCommentList sharedInstance];
    [commentList commentListWithMerchant_id:self.merchant_id controller:self];
}

#pragma mark - 加载更多
- (void)setupDownRefresh{
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreMerchantCommentList)];
}
- (void)loadMoreMerchantCommentList{
    HttpMerchantCommentList *commentList = [HttpMerchantCommentList sharedInstance];
    [commentList loadMoreMerchantCommentListMerchant_id:self.merchant_id controller:self];
   
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    FDCommentCell *cell = [FDCommentCell cellWithTableView:tableView];
    cell.statusFrame = self.dataArray[indexPath.row];

    [cell.icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick:)]];
    
    return cell;

}
- (void)headImageClick:(UITapGestureRecognizer *)tap{
    FDHeadImageView *head = (FDHeadImageView *)tap.view;
    FDUserDetailViewController *userDetail = [[FDUserDetailViewController alloc] init];
    userDetail.kid = head.kid;
    [self.navigationController pushViewController:userDetail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FDCommentFrame *frame = self.dataArray[indexPath.row];
    return frame.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDCommentDetailViewController *commentDetail = [[FDCommentDetailViewController alloc] init];
    FDCommentFrame *frame = self.dataArray[indexPath.row];
    commentDetail.model = frame.status;
    
    [self.navigationController pushViewController:commentDetail animated:YES];
}
#pragma mark - 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
