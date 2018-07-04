//
//  FDInvoiceViewController.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInvoiceViewController.h"
#import "FDInvocieCell.h"
#import "FDExplanationViewController.h"
#import "FDPickerbgView.h"
#import "HttpInvoiceDefault.h"
#import "HttpInvoiceAdd.h"
#import "FDInvoiceHistoryViewController.h"
#import "ReqInvoiceAddModel.h"
@interface FDInvoiceViewController ()<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)FDPickerbgView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;

@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;
@property (strong ,nonatomic) NSMutableArray *contentArray;

@end

@implementation FDInvoiceViewController
#pragma mark - life cycle
- (FDPickerbgView *)pickerBgView{
    
    if (!_pickerBgView) {
        _pickerBgView = [FDPickerbgView fdPickerbgView];
        _pickerBgView.frame = CGRectMake(0, 0, ScreenW, 255);
        _pickerBgView.myPicker.delegate = self;
        _pickerBgView.myPicker.dataSource = self;
        [_pickerBgView.cancleBtn addTarget:self action:@selector(hideMyPicker) forControlEvents:UIControlEventTouchUpInside];
        [_pickerBgView.ensureBtn addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return _pickerBgView;
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    [MobClick event:@"pv_invoice"];
    [self loadInvoiceData];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"发票"];
    [self getPickerData];
    [self initView];
    self.defaultModel = [[RespInvoiceDefaultModel alloc] init];
    self.tableView.backgroundColor = Background_Color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
}

#pragma  mark - 第一次加载数据

- (void)loadInvoiceData{
    HttpInvoiceDefault *def = [HttpInvoiceDefault sharedInstance];
    [def invoiceDefaultWithViewController:self];
}

#pragma mark - init view
- (void)initView {
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.tag==100) {
        [self.contentArray replaceObjectAtIndex:0 withObject:textField.text];
    }else if (textField.tag ==101){
        [self.contentArray replaceObjectAtIndex:1 withObject:textField.text];
    }else if (textField.tag ==200){
        [self.contentArray replaceObjectAtIndex:2 withObject:textField.text];
    }else if (textField.tag ==202){
        [self.contentArray replaceObjectAtIndex:3 withObject:textField.text];
    }else if (textField.tag ==206){
        [self.contentArray replaceObjectAtIndex:5 withObject:textField.text];
    }
}
#pragma mark - UITableViewDelegate Datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDInvocieCell *cell = [FDInvocieCell cellWithTableView:tableView];
    
    if (IPhone6||IPhone6Plus) {
        cell.inputTextfiled.font = [UIFont systemFontOfSize:16];
        cell.leftTitle.font = [UIFont systemFontOfSize:18];
    }else{
    
        cell.inputTextfiled.font = [UIFont systemFontOfSize:15];
        cell.leftTitle.font = [UIFont systemFontOfSize:17];
    }
    cell.inputTextfiled.tag = (indexPath.row+100)*(indexPath.section+1);
    [cell.inputTextfiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    cell.inputTextfiled.delegate = self;
    NSArray *titleArray1 = @[@"开票金额",@"发票抬头"];
    NSArray *titleArray2 = @[@"收件人",@"联系电话",@"所在地区",@"详细地址"];
    
    NSArray *placeholder1 = @[@"可开额度0元，满200包送",@"输入发票抬头"];
    NSArray *placeholder2 = @[@"收件人姓名",@"收件人联系电话",@"选择所在地区",@"收件人详细地址"];
    cell.inputTextfiled.adjustsFontSizeToFitWidth = YES;
    if(indexPath.section == 0)
    {
        if (indexPath.row==0) {
            cell.inputTextfiled.keyboardType = UIKeyboardTypeNumberPad;
        }
        cell.leftTitle.text = titleArray1[indexPath.row];
        cell.inputTextfiled.placeholder = placeholder1[indexPath.row];
        
    }else{

        if (indexPath.row==1) {
        cell.inputTextfiled.keyboardType = UIKeyboardTypeNumberPad;

        }
        cell.leftTitle.text = titleArray2[indexPath.row];
        cell.inputTextfiled.placeholder = placeholder2[indexPath.row];
    }
    
    if(indexPath.section == 0)
    {
        cell.leftTitle.text = titleArray1[indexPath.row];
        if (indexPath.row==0) {
            cell.inputTextfiled.keyboardType = UIKeyboardTypeNumberPad;
            if ([self.defaultModel.invoice_amount integerValue]==0||self.defaultModel.invoice_amount==nil) {
                cell.inputTextfiled.placeholder = @"可开额度0元，满200元包送";
            }else{
              cell.inputTextfiled.placeholder = [NSString stringWithFormat:@"可开额度%@元，满200元包送",self.defaultModel.invoice_amount];
            }
            
        }else if (indexPath.row==1){
            cell.inputTextfiled.text = self.defaultModel.invoice_title;
        }
    }else{
        cell.leftTitle.text = titleArray2[indexPath.row];
        if (indexPath.row==0) {
            cell.inputTextfiled.text = self.defaultModel.invoice_receiver;
        }else if (indexPath.row==1){
            cell.inputTextfiled.text = self.defaultModel.invoice_phone;
        }else if (indexPath.row==2){
            if ([self.defaultModel.invoice_city isEqualToString:@""]||self.defaultModel.invoice_city==nil) {
                cell.inputTextfiled.text = @"";
            }
            else{
                cell.inputTextfiled.text = [NSString stringWithFormat:@"%@ ｜ %@ ｜ %@",self.defaultModel.invoice_province,self.defaultModel.invoice_city,self.defaultModel.invoice_district];
            }
        }else if (indexPath.row==3){
            cell.inputTextfiled.text = self.defaultModel.invoice_address;
        }
        
    }
    
    if (indexPath.section == 1 &&indexPath.row == 2) {
        
        cell.arrowView.hidden =NO;
        cell.inputTextfiled.enabled = NO;
        
    }else{
        
        cell.arrowView.hidden =YES;
        cell.inputTextfiled.enabled = YES;
        
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.inputTextfiled.text = self.contentArray[0];
        }else{
            cell.inputTextfiled.text = self.contentArray[1];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.inputTextfiled.text = self.contentArray[2];
        }else if(indexPath.row ==1){
            cell.inputTextfiled.text = self.contentArray[3];
        }else if (indexPath.row==2){
            cell.inputTextfiled.text = self.contentArray[4];
        }else if (indexPath.row==3){
            cell.inputTextfiled.text = self.contentArray[5];
        }
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return 2;
        
    }
    
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 42;
    }
    return 16;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    footerView.backgroundColor = Background_Color;
    
    UIButton *historyBtn = [[UIButton alloc]init];
    [historyBtn setTitle:@"提交" forState:UIControlStateNormal];
    [historyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    historyBtn.backgroundColor = FDButtonColor;
    historyBtn.layer.cornerRadius = 3;
    historyBtn.layer.masksToBounds = YES;
    
    if(IPhone6Plus ||IPhone6 ){
        historyBtn.frame=CGRectMake(15, 30, ScreenW - 30, 50);
        historyBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    }else{
        historyBtn.frame=CGRectMake(15, 30, ScreenW - 30, 40);
        historyBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    }
    
    [historyBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:historyBtn];
    
    return footerView;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 42)];
    headerView.backgroundColor = Background_Color;
    
    UIButton *historyBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW - 80, 0, 70, 42)];
    [historyBtn setTitle:@"开票历史" forState:UIControlStateNormal];
    [historyBtn setTitleColor:FDColor(153, 153, 153, 1) forState:UIControlStateNormal];
    historyBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [historyBtn addTarget:self action:@selector(historyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:historyBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(historyBtn.frame)-5, 8, 0.5, 26)];
    lineView.backgroundColor = FDColor(153, 153, 153, .5);
    
    [headerView addSubview:lineView];
    
    
    UIButton *explanationBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(historyBtn.frame)-70-10, 0, 70, 42)];
    [explanationBtn setTitle:@"开票说明" forState:UIControlStateNormal];
    [explanationBtn setTitleColor:FDColor(153, 153, 153, 1) forState:UIControlStateNormal];
    explanationBtn.titleLabel.textAlignment = NSTextAlignmentRight;

    [explanationBtn addTarget:self action:@selector(explanationBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:explanationBtn];
    
    if(IPhone6Plus ||IPhone6 ){
        historyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        explanationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }else{
        historyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        explanationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    UIView *headerView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 16)];
    headerView1.backgroundColor = Background_Color;
    
    if (section == 0) {
        return headerView;
    }
    return headerView1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 &&indexPath.row == 2) {
        [self.view addSubview:self.maskView];
        [self.view addSubview:self.pickerBgView];
        self.maskView.alpha = 0;
        self.pickerBgView.y = self.view.height;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 0.3;
            self.pickerBgView.y = self.view.height-255;
        }];
        
    }else{
        
    }
    
    
}
#pragma  mark - 查看发票历史

- (void)historyBtnClick
{
    [MobClick event:@"click_invoice_history"];
    FDInvoiceHistoryViewController *historyVC=[[FDInvoiceHistoryViewController alloc]init];
    
    [self.navigationController pushViewController:historyVC animated:YES];
    
}

#pragma  mark - 查看发票说明
- (void)explanationBtnBtnClick{
    [MobClick event:@"click_invoice_description"];
    FDExplanationViewController *explantionVC=[[FDExplanationViewController alloc]init];
    explantionVC.invoice_instruction = self.defaultModel.invoice_instruction;
    [self.navigationController pushViewController:explantionVC animated:YES];
}
#pragma mark 提交
- (void)submitClick{
    [MobClick event:@"click_invoice_submit"];
    FDInvocieCell *cell00 =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    FDInvocieCell *cell01 =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    FDInvocieCell *cell10 =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    FDInvocieCell *cell11 =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    FDInvocieCell *cell13 =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    
    ReqInvoiceAddModel *reqModel = [[ReqInvoiceAddModel alloc]init];
    reqModel.kid=[HQDefaultTool getKid];
    
    
    reqModel.invoice_amount =cell00.inputTextfiled.text;
    reqModel.invoice_title =cell01.inputTextfiled.text;
    reqModel.invoice_receiver =cell10.inputTextfiled.text;
    reqModel.invoice_phone =cell11.inputTextfiled.text;
    reqModel.invoice_address =cell13.inputTextfiled.text;
    reqModel.invoice_province =[self.provinceArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:0]];
    reqModel.invoice_city =[self.cityArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:1]];
    reqModel.invoice_district =[self.townArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:2]];
    if ([cell00.inputTextfiled.text intValue]==0) {
        [SVProgressHUD showImage:nil status:@"开票金额不能为0元"];
        return;
    }
    if ([cell00.inputTextfiled.text intValue]<200) {
        [SVProgressHUD showImage:nil status:@"开票金额不能低于200元"];
        return;
    }
    if ([_invoice_amount intValue]==0) {
        [SVProgressHUD showImage:nil status:@"开票金额超出，请修改开票金额"];
        return;
    }
    
    if ([_invoice_amount intValue]<[reqModel.invoice_amount intValue]) {
        [SVProgressHUD showImage:nil status:@"开票金额超出，请修改开票金额"];
        return;
    }
    
    
    if ([self isPureFloat:cell01.inputTextfiled.text]) {
        [SVProgressHUD showImage:nil status:@"请输入有效发票抬头"];
        return;
        
    }
    if (cell01.inputTextfiled.text.length>16) {
        [SVProgressHUD showImage:nil status:@"发票抬头不得超过16个字"];
        return;
    }
    
    if ([self isPureFloat:cell10.inputTextfiled.text]) {
        [SVProgressHUD showImage:nil status:@"请输入有效收件人姓名"];
        return;
    }
    if (cell10.inputTextfiled.text.length>16) {
        [SVProgressHUD showImage:nil status:@"收件人姓名不得超过16个字"];
        return;
    }
    if (![self validatePhone:cell11.inputTextfiled.text]) {
        [SVProgressHUD showImage:nil status:@"请输入正确手机号"];
        return;
    }
    
    if (cell13.inputTextfiled.text.length>100) {
        [SVProgressHUD showImage:nil status:@"地址信息输入过长"];
        return;
    }

    if ([cell00.inputTextfiled.text isEqualToString:@""]||[cell01.inputTextfiled.text isEqualToString:@""]||[cell10.inputTextfiled.text isEqualToString:@""]||[cell11.inputTextfiled.text isEqualToString:@""]||[cell13.inputTextfiled.text isEqualToString:@""]||cell11.inputTextfiled.text.length!=11) {
        [SVProgressHUD showImage:nil status:@"请输入完整的开票信息"];
        return;
    }
    
    HttpInvoiceAdd *add = [HttpInvoiceAdd sharedInstance];
    
    [add invoiceAddWithReqInvoiceAddModel:reqModel viewController:self];
    
}

#pragma mark - get data
- (void)getPickerData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}
- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.y= self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

- (void)ensure{
    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:1];
    
    FDInvocieCell *cell = [self.tableView cellForRowAtIndexPath:path];
    cell.inputTextfiled.text = [NSString stringWithFormat:@"%@ ｜ %@ ｜ %@",[self.provinceArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:0]],[self.cityArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:1]],[self.townArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:2]]];
    [self.contentArray replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@ ｜ %@ ｜ %@",[self.provinceArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:0]],[self.cityArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:1]],[self.townArray objectAtIndex:[self.pickerBgView.myPicker selectedRowInComponent:2]]]];
    [self hideMyPicker];
}

//浮点形判断：
- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
#pragma mark -手机号验证
- (BOOL)validatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"1[0-9]{10}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}
@end
