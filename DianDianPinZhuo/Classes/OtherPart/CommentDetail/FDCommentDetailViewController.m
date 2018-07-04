//
//  FDCommentDetailViewController.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/2.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDCommentDetailViewController.h"
#import "FDCommentDetailCell.h"
#import "FDUserDetailViewController.h"
#import "FDCommentDetailFrame.h"
#import "FDShareView.h"
#import "CommentModel.h"
#import "RespMerchantCommentDetail.h"
#import "HttpMerchantCommentDetail.h"
@interface FDCommentDetailViewController ()
@property (nonatomic ,weak) FDShareView *shareView;
@end

@implementation FDCommentDetailViewController
#pragma mark - life cycle
- (FDShareView *)shareView{
    
    if (_shareView==nil) {
        _shareView = [FDShareView shareView];
        _shareView.delegate = self;
    }
    _shareView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    _shareView.umURL = @"https://www.baidu.com";
    _shareView.title = @"评论详情";
    _shareView.contText = self.model.content;
    _shareView.group_share_title = @"评论详情";
    _shareView.group_share_hint = @"立即查看";
    _shareView.type = @"8";
    _shareView.topic_id = self.comment_id;
    return _shareView;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTitleViewWithTitle:@"评价详情"];
    
    [self initShareBtn];
    
    [self loadMerchantCommentDetail];
    
}
- (void)loadMerchantCommentDetail {
    HttpMerchantCommentDetail *commentDetail = [HttpMerchantCommentDetail sharedInstance];
    [commentDetail loadUMerchantCommentDetailWithComment_id:self.comment_id controller:self];
}

- (void)shareClick{
    [self.navigationController.view addSubview:self.shareView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDCommentDetailCell *cell = [FDCommentDetailCell cellWithTableView:tableView];
    FDCommentDetailFrame *frame = [[FDCommentDetailFrame alloc] init];
    frame.status = self.model;
    cell.statusFrame = frame;
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
    FDCommentDetailFrame *frame = [[FDCommentDetailFrame alloc] init];
    frame.status = self.model;
    return frame.cellHeight;
}


@end
