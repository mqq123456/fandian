//
//  FDInputMyDescViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInputMyDescViewController.h"
#import "HttpUserEdit.h"
#import "EaseMob.h"
#import "UIViewController+HUD.h"
#import "EMAlertView.h"
#import "HQIMFriendsTool.h"
#import "HttpImFriendAdd.h"
#import "ApplyViewController.h"
#import "InvitationManager.h"
#import "JSTextView.h"
#import "SVProgressHUD.h"

@interface FDInputMyDescViewController ()<IChatManagerDelegate,UITextViewDelegate>
@property (nonatomic ,strong) JSTextView *textField;
@end

@implementation FDInputMyDescViewController
- (instancetype)init{
    if ([super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                    name:@"UITextFieldTextDidChangeNotification"
                                                  object:self.textField];
    }
    
    
    return self;
    
}
- (void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];///键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        ///获取高亮部分
        UITextPosition *position  = [textField positionFromPosition:selectedRange.start offset:0];
        ///没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length>self.NumberCounts) {
                textField.text = [toBeString substringToIndex:self.NumberCounts];
            }
        }
        ///有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
            
        }
        
        
    }
    ///中文输入法以外的直接对其统治限制即可，补考虑其他语种情况
    else{
        
        if (toBeString.length >self.NumberCounts) {
            textField.text = [toBeString substringToIndex:self.NumberCounts];
        }
    }
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Background_Color;
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 63.6, [UIScreen mainScreen].bounds.size.width, 0.4)];
    line.backgroundColor = FDColor(153, 153, 153, 1);
    [navView addSubview:line];
    navView.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-5, 20, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"navbar_back2"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [self.view addSubview:navView];
    
    UILabel *title = [FDUtils createLabel:self.navtitle withTextColor:[UIColor blackColor] frame:CGRectMake(0, 0,100,19) with:17 withBackColor:[UIColor whiteColor] numberOfLines:1 with:NSTextAlignmentCenter];
    title.font=[UIFont boldSystemFontOfSize:17];
    title.frame = CGRectMake(60, 19, [UIScreen mainScreen].bounds.size.width-120, 43);
    title.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:title];

    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0,80, [UIScreen mainScreen].bounds.size.width, 100)];
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];

    self.textField = [[JSTextView alloc]initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width-30, 100)];
    [textView addSubview:self.textField];
    self.textField.myPlaceholder = self.placehorder;
    self.textField.text = self.content;
    [self.textField becomeFirstResponder];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(15, 214, [UIScreen mainScreen].bounds.size.width-30, 50);
    button.layer.cornerRadius = 3;
    button.clipsToBounds = YES;
    button.backgroundColor = FDButtonColor;
    [button setTitle:self.submitStr? self.submitStr:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
}


- (void)btnClick{
    NSString* str=self.textField.text;
    //1. 去除掉首尾的空白字符和换行字符
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去除掉其它位置的空白字符和换行字符
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.textField.text = str;
    if (self.textField.text.length>self.NumberCounts) {
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"输入字数大于%zd",self.NumberCounts]];
        return;
    }
    
    if ([self.textField.text isEqualToString:@""]) {
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@不可为空",self.navtitle]];
        return;
    }
    
    [self.textField resignFirstResponder];
    [SVProgressHUD showWithStatus:@"修改中..."];
    HttpUserEdit *userEdit = [HttpUserEdit sharedInstance];
    [userEdit loadUserEditWithIndex:123 content:self.textField.text];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)backClick{
    
    [self.textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:self.textField];
}

@end
