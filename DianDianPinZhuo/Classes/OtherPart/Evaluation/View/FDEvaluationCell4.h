//
//  FDEvaluationCell4.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/30.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQTextView.h"
@interface FDEvaluationCell4 : UITableViewCell<UITextViewDelegate>
///意见输入框
@property (weak, nonatomic) IBOutlet HQTextView *proposalTextView;
///提交按钮
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn1;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn2;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn3;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn1;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn2;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn3;
@end
