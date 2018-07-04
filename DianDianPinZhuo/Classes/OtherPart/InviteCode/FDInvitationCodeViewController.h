//
//  FDInvitationCodeViewController.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootViewController.h"
#import "RespUserExchangeVoucher.h"

@interface FDInvitationCodeViewController : RootViewController<UITextFieldDelegate>
@property (strong, nonatomic) RespUserExchangeVoucher *model;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
- (IBAction)activationBtnClick:(id)sender;
- (void)exchangeSuccess;

@end
