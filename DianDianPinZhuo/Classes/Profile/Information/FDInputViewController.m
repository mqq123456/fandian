//
//  FDInputViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInputViewController.h"
#import "HttpUserEdit.h"
#import "EaseMob.h"
#import "UIViewController+HUD.h"
#import "EMAlertView.h"
#import "HQIMFriendsTool.h"
#import "HttpImFriendAdd.h"
#import "ApplyViewController.h"
#import "InvitationManager.h"

@interface FDInputViewController ()<IChatManagerDelegate,UITextFieldDelegate>
@property (nonatomic ,strong) UITextField *textField;
@end

@implementation FDInputViewController
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
    
    [super viewWillAppear:animated];
    if (self.index == 60) {
        ///修改描述页流量
        [MobClick event:@"pv_editdescription"];
    }
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 83, [UIScreen mainScreen].bounds.size.width-20, 21)];
    label.text = self.attribute;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = FDColor(153, 153, 153, 1);
    [self.view addSubview:label];
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 114, [UIScreen mainScreen].bounds.size.width, 50)];
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width-20, 50)];
    [textView addSubview:self.textField];
    self.textField.placeholder = self.placehorder;
    self.textField.text = self.content;
    [self.textField becomeFirstResponder];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(50, 214, [UIScreen mainScreen].bounds.size.width-100, 50);
    button.layer.cornerRadius = 3;
    button.clipsToBounds = YES;
    button.backgroundColor = FDButtonColor;
    [button setTitle:self.submitStr? self.submitStr:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.textField) {
//        if (textField.text.length > self.NumberCounts) {
//            [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"输入字数大于%zd",self.NumberCounts]];
//        }
//    }
//}

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
    
    if ([self.textField.text isEqualToString:@""]&&self.index !=4) {
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@不可为空",self.navtitle]];
        return;
    }
    
    [self.textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.index==60) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DescriptionMySelf object:nil userInfo:@{@"myself_desc":self.textField.text}];
        return;
    }
    
    if(self.index == 4){
        
        NSString *buddyName = self.kid;
        if ([self didBuddyExist:buddyName]) {//已经存在
            
            NSDictionary *dic = [[HQIMFriendsTool sharedInstance] recordFriendDetail:buddyName];
            
            NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeat", @"'%@'has been your friend!"), [dic objectForKey:@"nickname"]];
            
            [EMAlertView showAlertWithTitle:message
                                    message:nil
                            completionBlock:nil
                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                          otherButtonTitles:nil];
            
        }
        else if([self hasSendBuddyRequest:buddyName])
        {//已经发送
            NSDictionary *dic = [[HQIMFriendsTool sharedInstance] recordFriendDetail:buddyName];
            
            NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatApply", @"you have send fridend request to '%@'!"), [dic objectForKey:@"nickname"]];
            
            [EMAlertView showAlertWithTitle:message
                                    message:nil
                            completionBlock:nil
                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                          otherButtonTitles:nil];
            
        }else{
            
            //判断是否已发来申请
            NSArray *applyArray = [[ApplyViewController shareController] dataSource];
            if (applyArray && [applyArray count] > 0) {
                for (ApplyEntity *entity in applyArray) {
                    ApplyStyle style = [entity.style intValue];
                    BOOL isGroup = style == ApplyStyleFriend ? NO : YES;
                    if (!isGroup && [entity.applicantUsername isEqualToString:buddyName]) {
                        NSString *str = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatInvite", @"%@ have sent the application to you"), self.nickname];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:str delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                        [alertView show];
                        
                        return;
                    }
                }
            }
            [self showMessageAlertView];
        }
        
        
        
        
    }else{
        [SVProgressHUD showWithStatus:@"修改中..."];
        HttpUserEdit *userEdit = [HttpUserEdit sharedInstance];
        [userEdit loadUserEditWithIndex:self.index content:self.textField.text];
    }
    
    
    
    
}

- (BOOL)hasSendBuddyRequest:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState == eEMBuddyFollowState_NotFollowed &&
            buddy.isPendingApproval) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)didBuddyExist:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState != eEMBuddyFollowState_NotFollowed) {
            return YES;
        }
    }
    return NO;
}

- (void)showMessageAlertView
{
    NSString *messageStr;
    if(!self.textField.text ||[self.textField.text isEqualToString:@""]){
        messageStr = [NSString stringWithFormat:@"请求添加你为饭友:;%@:;%@",[HQDefaultTool getNickName],[HQDefaultTool getHead]];
        
    }else{
        
        messageStr = [NSString stringWithFormat:@"%@:;%@:;%@",self.textField.text,[HQDefaultTool getNickName],[HQDefaultTool getHead]];
        
    }
    UsersModel *model = [[UsersModel alloc]init];
    model.nickname = self.nickname;
    model.kid = self.kid;
    model.url = self.url;
    
    [[HQIMFriendsTool sharedInstance] addFriendsName:model idString:self.kid];
    
    [self sendFriendApplyWithMessage:messageStr];
}

- (void)sendFriendApplyWithMessage:(NSString *)message
{
    NSString *buddyName = self.kid;
    if (buddyName && buddyName.length > 0) {
        [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
        EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:message error:&error];
        
        [self hideHud];
        if (error) {
            [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
        }
        else{
            
            HttpImFriendAdd *addFriend = [HttpImFriendAdd sharedInstance];
            [addFriend addFriendTopush:self.kid];
            [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
