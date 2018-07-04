//
//  FDNotJoinGroupsViewController.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDNotJoinGroupsViewController.h"
#import "FDNotJoinGroupsFrame.h"
#import "FDNotJoinGroupsCell.h"
#import "NotJoinGroupModel.h"
#import "HttpImRecommendGroupList.h"
#import "FDLoginViewController.h"
#import "ChatViewController.h"
#import "HttpImJoinGroup.h"
@interface FDNotJoinGroupsViewController ()

@end

@implementation FDNotJoinGroupsViewController

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
    
    [self addTitleViewWithTitle:@"未加入群组"];
    
    
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //第一次加载数据
    [self loadFirstMerchantSearch];
    
    self.haveMJRefresh = NO;
    
}

#pragma mark - 第一次加载
- (void)loadFirstMerchantSearch{
    HttpImRecommendGroupList *group = [HttpImRecommendGroupList sharedInstance];
    [group loadRecommendGroupListWithController:self];

}

#pragma mark - UITableViewDataSource Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDNotJoinGroupsFrame *frame = self.datyArray[indexPath.row];
    
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDNotJoinGroupsCell *cell = [FDNotJoinGroupsCell cellWithTableView:tableView];
    
    cell.statusFrame = self.datyArray[indexPath.row];
    cell.nav = self.navigationController;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        FDLoginViewController *verification = [[FDLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }else{
        FDNotJoinGroupsFrame *frame = self.datyArray[indexPath.row];
        NotJoinGroupModel *model = frame.status;
        HttpImJoinGroup *join = [HttpImJoinGroup sharedInstance];
        [join loadImJoinGroupWithGroup_id:model.group_id controller:self group_name:model.name];
        
        
        return;
    }
    
    
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
