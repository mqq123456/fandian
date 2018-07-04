//
//  FDInvitationCodeViewController.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDInvitationCodeViewController.h"
#import "FDCouponsViewController.h"
#import "IQKeyboardManager.h"
#import "HttpUserExchangeVoucher.h"
#import "FDWebViewController.h"

@interface FDInvitationCodeViewController ()<UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation FDInvitationCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[FDUtils addNavBarView]];
    [self addTitleViewWithTitle:@"激活优惠码"];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self.textFiled becomeFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 点击激活
- (IBAction)activationBtnClick:(id)sender{
    
    NSString *string = self.textFiled.text;
    NSRange _range = [string rangeOfString:@" "];
    if (_range.location != NSNotFound||string.length==0) {
        //有空格
        [SVProgressHUD showImage:nil status:@"请输入正确的优惠码"];

    }else {
        //没有空格
        UIButton *btn =(UIButton *)sender;
        btn.enabled = NO;
        [self.textFiled resignFirstResponder];
        HttpUserExchangeVoucher *tool = [HttpUserExchangeVoucher sharedInstance];
        [tool userExchangeVoucher_occ_code:self.textFiled.text andViewController:self sender:sender];
    }
}
///兑换成功
- (void)exchangeSuccess{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"兑换成功" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即查看", nil];
        alertView.tag = 100;
        [alertView show];
    });

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (!self.model.url||[self.model.url isEqualToString:@""]){
                
                FDCouponsViewController *vc = [[FDCouponsViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{

                FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
                webView.url = self.model.url;
                webView.titleString = self.model.url_title;
                [self.navigationController pushViewController:webView animated:YES];
            }

        });

    }


}

@end
