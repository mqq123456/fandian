//
//  FDConfigViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDConfigViewController.h"
#import "HttpUserLogout.h"
#import "FDConfigFooterView.h"
#import "HFDConfigHeadView.h"
#import "PayFail.h"
#import "FDTSettingCell.h"
@interface FDConfigViewController ()<UIActionSheetDelegate>

@end

@implementation FDConfigViewController
- (void)initHeader{
    HFDConfigHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"HFDConfigHeadView" owner:nil options:nil]lastObject];
    headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 64- 48*2)*0.45);
    self.tableView.tableHeaderView = headView;
}
- (void)initFooter{
    FDConfigFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"FDConfigFooterView" owner:nil options:nil]lastObject];
    footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 64- 48*2)*0.55);
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        footerView.quitBtn.hidden = YES;
    }else{
        footerView.quitBtn.hidden = NO;
    }
    [footerView.quitBtn addTarget:self action:@selector(quitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = footerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = Background_Color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:[FDUtils addNavBarView]];
    [self addTitleViewWithTitle:@"设置"];
    
    [self initHeader];
    
    [self initFooter];
    
    

}

- (void)makeScoreBtnClick{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[HQDefaultTool getDown_url]]];
}

- (void)makeCallBtnClick{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"客服工作时间：工作日9:00-18:00" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[HQDefaultTool getService], nil];
    [sheet showInView:self.view.window];

}


- (void)quitBtnClick{
    CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 40.0f;
    CGFloat yHeight = 220.0f;
    CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
    poplistview.listView.scrollEnabled = FALSE;
    poplistview.isTouchOverlayView = YES;
    [poplistview show];
    self.popoverListView = poplistview;
    self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
    PayFail *payResult = [[[NSBundle mainBundle] loadNibNamed:@"PayFail" owner:nil options:nil]lastObject];
    payResult.frame = self.popoverListView.bounds;
    [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
    payResult.title.text = @"注销";
    payResult.detail.text = @"注销当前帐户";
    [payResult.doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [payResult.cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [poplistview addSubview:payResult];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)doneBtnClick:(UIButton *)button{
    
    button.enabled = NO;
    HttpUserLogout *tool = [HttpUserLogout sharedInstance];
    [tool loadUserLogOutBtnClick:button Controller:self];
    
}

- (void)cancleBtnClick{
    [self.popoverListView dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FDTSettingCell *cell = [FDTSettingCell cellWithTableView:self.tableView];
    NSArray *leftArray = @[@"联系客服",@"给我打分"];
    
    NSArray *rightArray = @[[HQDefaultTool getService],@""];
    
    cell.left_label.text = leftArray[indexPath.row];
    cell.right_label.text = rightArray[indexPath.row];
    if (indexPath.row == 2) {
        cell.lineView.hidden = YES;
        cell.arrowImage.hidden = YES;
    }else{
        cell.lineView.hidden = NO;
        cell.arrowImage.hidden = NO;
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 48;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [self makeCallBtnClick];
        }
            break;
        case 1:
        {
            [self makeScoreBtnClick];
        }
            break;
        case 2:
        {
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[HQDefaultTool getService]]]];
    }
}



@end
