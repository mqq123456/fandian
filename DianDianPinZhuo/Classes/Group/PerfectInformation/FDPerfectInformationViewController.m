//
//  FDPerfectInformationViewController.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/31.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDPerfectInformationViewController.h"
#import "FDPerfectAgeCell.h"
#import "FDPerfectSexCell.h"
#import "FDPerfectCompanyCell.h"
#import "FDPerfectOccupationCell.h"
#import "FDPerfectHeaderView.h"
#import "HQDefaultTool.h"
#import "HttpUserIndustryCategory.h"
#import "HttpUserEdit.h"

@interface FDPerfectInformationViewController () <FDPerfectSexCellDelegate,FDPerfectAgeCellDelegate>
@property (nonatomic ,weak) UIButton *finishBtn;

@property (nonatomic ,copy) NSString *sex;
@property (nonatomic ,copy) NSString *age;
@property (nonatomic ,copy) NSString *company;
@property (nonatomic ,copy) NSString *occupation;

@end

@implementation FDPerfectInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"完善资料";
    
    self.sex = [HQDefaultTool getSex];
    self.age = [HQDefaultTool getAge];
    self.occupation = [HQDefaultTool getOccupation];
    self.company = [HQDefaultTool getCompany];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64-50);
    
    FDPerfectHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"FDPerfectHeaderView" owner:nil options:nil]lastObject];
    headerView.frame = CGRectMake(0, 0, ScreenW, 50);
    self.tableView.tableHeaderView = headerView;
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    finishBtn.backgroundColor = [UIColor grayColor];
    finishBtn.frame = CGRectMake(0, ScreenH-64-50, ScreenW, 50);
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishBtn.enabled = NO;
    [self.view addSubview:finishBtn];
    [finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.finishBtn = finishBtn;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}
- (void)finishBtnClick{
    HttpUserEdit *edit = [HttpUserEdit sharedInstance];
    [edit loadUserEditWithSex:_sex age:_age company:_company occupation:_occupation controller:self];
}
- (void)keyboardDidHide:(NSNotification *)no{
    
    FDPerfectCompanyCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    self.company = cell.textField.text;
    [self reloadBtn];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.occupation = [HQDefaultTool getOccupation];
    [self reloadBtn];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadBtn{
    if (![self.sex isEqualToString:@""]&&![self.age isEqualToString:@""]&&![self.company isEqualToString:@""]&&![self.occupation isEqualToString:@""]) {
       
        if ([self.age isEqualToString:@"选择年龄"]) {
            
        }else{
            self.finishBtn.backgroundColor = [UIColor redColor];
            self.finishBtn.enabled = YES;
        }
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        FDPerfectSexCell *cell = [FDPerfectSexCell cellWithTableView:tableView];
        cell.delegate = self;
        if ([_sex isEqualToString:@"男"]) {
            [cell.nanBtn setImage:[UIImage imageNamed:@"baw_ico_nanxing_dis"] forState:UIControlStateNormal];
            [cell.nvBtn setImage:[UIImage imageNamed:@"baw_ico_nvxing_nor"] forState:UIControlStateNormal];
        }else if ([_sex isEqualToString:@"女"]) {
            [cell.nanBtn setImage:[UIImage imageNamed:@"baw_ico_nanxing_nor"] forState:UIControlStateNormal];
            [cell.nvBtn setImage:[UIImage imageNamed:@"baw_ico_nvxing_dis"] forState:UIControlStateNormal];
        }else{
            [cell.nanBtn setImage:[UIImage imageNamed:@"baw_ico_nanxing_nor"] forState:UIControlStateNormal];
            [cell.nvBtn setImage:[UIImage imageNamed:@"baw_ico_nvxing_nor"] forState:UIControlStateNormal];
        }
        return cell;
    }else if (indexPath.row==1){
        FDPerfectAgeCell *cell = [FDPerfectAgeCell cellWithTableView:tableView];
        
        cell.delegate = self;
        
        NSArray *array = [NSMutableArray arrayWithObjects:@"选择年龄",@"60前",@"60后",@"70后",@"75后",@"80后",@"85后",@"90后",@"95后", nil];
        
        NSInteger selectRow = 0;
        for (int i = 0; i < array.count; i++) {
            if ([self.age isEqualToString:array[i]]) {
                selectRow = i;
            }
        }
        [cell.pickerView selectRow:selectRow inComponent:0 animated:NO];
        
        //[cell.pickerView reloadAllComponents];
        return cell;
    }else if (indexPath.row==2){
        FDPerfectCompanyCell *cell = [FDPerfectCompanyCell cellWithTableView:tableView];
        if (![self.company isEqualToString:@""]) {
            cell.textField.text = self.company;
        }else{
            cell.textField.text = [HQDefaultTool getCompany];
        }
        
        return cell;
    }else{
        FDPerfectOccupationCell *cell = [FDPerfectOccupationCell cellWithTableView:tableView];
        cell.textField.text = [HQDefaultTool getOccupation];
        return cell;
    }
}
- (void)selectedAndReloadTableViewWithSex:(NSString *)sex{
    self.sex = sex;
    [self reloadBtn];
    [self.tableView reloadData];
}
- (void)selectedAndReloadTableViewWithAge:(NSString *)sex{
    self.age = sex;
    [self reloadBtn];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        HttpUserIndustryCategory *category = [HttpUserIndustryCategory sharedInstance];
        [category loadUserIndustryCategoryWithFDPerfectInformationViewController:self];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
