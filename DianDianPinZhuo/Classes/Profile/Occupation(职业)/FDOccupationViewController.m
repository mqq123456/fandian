//
//  FDOccupationViewController.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/6.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDOccupationViewController.h"
#import "WSDropMenuView.h"
#import "OccupationModel.h"
#import "HttpUserEdit.h"
@interface FDOccupationViewController ()<WSDropMenuViewDataSource,WSDropMenuViewDelegate>


@end

@implementation FDOccupationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"职业信息";
    self.view.backgroundColor = Background_Color;
    [self.view addSubview:[FDUtils addNavBarView]];

    WSDropMenuView *dropMenu = [[WSDropMenuView alloc] initWithFrame:CGRectMake(0,-44, self.view.frame.size.width,0)];
    dropMenu.dataSource = self;
    dropMenu.delegate = self;
    
    for(int i=0;i<self.dataArray.count;i++){
        OccupationModel *model = self.dataArray[i];
        if ([model.name isEqualToString:[HQDefaultTool getIndustry]]) {
            dropMenu.currSelectRow = i;
            dropMenu.currSelectRank = i;
            for (int j=0; j<model.children.count; j++) {
                if ([model.children[j] isEqualToString:[HQDefaultTool getOccupation]]) {
                    dropMenu.currSelectItem = j;
                    
                }
            }
        }
        
    }
    if ([[HQDefaultTool getOccupation] isEqualToString:@""]) {
        dropMenu.currSelectRow = 0;
    }
    
    [dropMenu reloadLeftTableView_1];
    
    [self.view addSubview:dropMenu];
}


#pragma mark - WSDropMenuView DataSource -
- (NSInteger)dropMenuView:(WSDropMenuView *)dropMenuView numberWithIndexPath:(WSIndexPath *)indexPath{
    
    //WSIndexPath 类里面有注释
    
    if (indexPath.column == 0 && indexPath.row == WSNoFound) {
        
        return self.dataArray.count;
    }
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        OccupationModel *model = self.dataArray[indexPath.row];
        NSMutableArray *array = model.children;
        return array.count;
    }
    
    
    return 0;
}

- (NSString *)dropMenuView:(WSDropMenuView *)dropMenuView titleWithIndexPath:(WSIndexPath *)indexPath{
    
    OccupationModel *model = self.dataArray[indexPath.row];
    //左边 第一级
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        
        return model.name;
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        
        return model.children[indexPath.item];
    }
    
    return @"";
    
}

#pragma mark - WSDropMenuView Delegate -

- (void)dropMenuView:(WSDropMenuView *)dropMenuView didSelectWithIndexPath:(WSIndexPath *)indexPath{
    OccupationModel *model = self.dataArray[indexPath.row];
    
    HttpUserEdit *userEdit = [HttpUserEdit sharedInstance];
    [userEdit loadUserEditWithIndustry:model.name occupation:model.children[indexPath.item]];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
