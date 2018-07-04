//
//  FDGroupMemberViewController.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDGroupMemberViewController.h"
#import "FDGroupMembersCell.h"
#import "GroupMembersModel.h"
#import "FDGroupMembersFrame.h"
#import "HttpImGroupMemberInfos.h"
#import "FDUserDetailViewController.h"
#import "IQKeyboardManager.h"


@interface FDGroupMemberViewController ()

@end

@implementation FDGroupMemberViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
#pragma mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.haveMJRefresh = YES;
    [self addTitleViewWithTitle:@"群组成员"];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //第一次加载数据
    [self loadFirstMerchantSearch];
    
    self.tableView.footer.hidden = YES;
}

#pragma mark - 第一次加载
- (void)loadFirstMerchantSearch{
    
    HttpImGroupMemberInfos *group = [HttpImGroupMemberInfos sharedInstance];
    [group loadImGroupMemberInfoWithController:self];
    
}

- (void)MJRefreshTop{
    HttpImGroupMemberInfos *group = [HttpImGroupMemberInfos sharedInstance];
    [group loadTopImGroupMemberInfoWithController:self];
}

- (void)MJRefreshMore{
    HttpImGroupMemberInfos *group = [HttpImGroupMemberInfos sharedInstance];
    [group loadMoreImGroupMemberInfoWithController:self];
}

#pragma mark - UITableViewDataSource Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDGroupMembersFrame *frame = self.datyArray[indexPath.row];
    
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDGroupMembersCell *cell = [FDGroupMembersCell cellWithTableView:tableView];
    
    cell.statusFrame = self.datyArray[indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FDGroupMembersFrame *statusFrame = self.datyArray[indexPath.row];
    FDUserDetailViewController *user = [[FDUserDetailViewController alloc] init];
    user.kid = statusFrame.status.kid;
    [self.navigationController pushViewController:user animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datyArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
