/************************************************************
 
 *  * EaseMob CONFIDENTIAL
 
 * __________________
 
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 
 *
 
 * NOTICE: All information contained herein is, and remains
 
 * the property of EaseMob Technologies.
 
 * Dissemination of this information or reproduction of this material
 
 * is strictly forbidden unless prior written permission is obtained
 
 * from EaseMob Technologies.
 
 */



#import "ChatGroupDetailViewController.h"

#import "GroupSettingViewController.h"

#import "EMGroup.h"

#import "ContactView.h"

#import "GroupBansViewController.h"

#import "GroupSubjectChangingViewController.h"

#import "UIViewController+HUD.h"

#import "MBProgressHUD.h"

#import "EMAlertView.h"



#import "MemberModel.h"

#import "HQHttpTool.h"

#import "UIImageView+WebCache.h"



#import "ApiParseImGroupExit.h"

#import "RequestModel.h"

#import "ReqImGroupExitModel.h"

#import "RespImGroupExitModel.h"

#import "HQConst.h"

#import "UIPopoverListView.h"

#import "PayFail.h"

#import "FDGroupDetailTool.h"

#import "SVProgressHUD.h"



//#import "HttpImGroupDetail.h"

#import "HttpImGroupExit.h"

#import "FDUserDetailViewController.h"

#import "FDGroupSettingHeaderView.h"

#import "FDGroupSettingFooterView.h"

#import "FDUtils.h"

#import <UIKit/UIKit.h>

#pragma mark - ChatGroupDetailViewController



#define kColOfRow ([UIScreen mainScreen].bounds.size.height == 736 ? 5 : 4)

//#define kContactSize [UIScreen mainScreen].bounds.size.width/4



#define kContactSize ([UIScreen mainScreen].bounds.size.height == 736 ? ([UIScreen mainScreen].bounds.size.width-20)/5: ([UIScreen mainScreen].bounds.size.width-20)/4)



@interface ChatGroupDetailViewController ()<IChatManagerDelegate, UIActionSheetDelegate>

{
    
    UISwitch *_pushSwitch;
    
}

- (void)unregisterNotifications;

- (void)registerNotifications;

@property (nonatomic) GroupOccupantType occupantType;



@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIView *footerView;

@property (strong, nonatomic) UIButton *exitButton;

@property (strong, nonatomic) UIButton *dissolveButton;

@property (strong, nonatomic) UIButton *configureButton;

@property (strong, nonatomic) ContactView *selectedContact;



- (void)dissolveAction;

- (void)clearAction;

- (void)exitAction;

- (void)configureAction;



@end



@implementation ChatGroupDetailViewController



- (void)registerNotifications {
    
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    
    
}



- (void)unregisterNotifications {
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    
}



- (void)dealloc {
    
    [self unregisterNotifications];
    
}



- (instancetype)initWithGroup:(EMGroup *)chatGroup

{
    
    self = [super init];
    
    if (self) {
        
        // Custom initialization
        
        _chatGroup = chatGroup;
        
        _dataSource = [NSMutableArray array];
        
        _occupantType = GroupOccupantTypeMember;
        
        [self registerNotifications];
        
    }
    
    return self;
    
}

- (void)headDidSelectedWithKid:(NSString *)kid{
    
    FDUserDetailViewController *userprofile = [[FDUserDetailViewController alloc] init];
    
    userprofile.kid = kid;
    
    [self.navigationController pushViewController:userprofile animated:YES];
    
}



- (instancetype)initWithGroupId:(NSString *)chatGroupId

{
    
    EMGroup *chatGroup = nil;
    
    NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
    
    for (EMGroup *group in groupArray) {
        
        if ([group.groupId isEqualToString:chatGroupId]) {
            
            
            
            chatGroup = group;
            
            break;
            
        }
        
    }
    
    
    
    if (chatGroup == nil) {
        
        chatGroup = [EMGroup groupWithId:chatGroupId];
        
    }
    
    
    
    self = [self initWithGroup:chatGroup];
    
    if (self) {
        
        //
        
    }
    
    
    
    return self;
    
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    
    
    if (self) {
        
        self = [super initWithStyle:UITableViewStyleGrouped];
        
    }
    
    return self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick event:@"pv_discussiondetails"];
    
    
    
    
    
}

- (void)addTitleViewWithTitle:(NSString *)title{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 19)];
    
    label1.textAlignment =NSTextAlignmentCenter;
    
    label1.textColor = [UIColor blackColor];
    
    label1.text = title;
    
    //根据字体名称和字号设置字体
    
    label1.font=[UIFont boldSystemFontOfSize:17];
    
    self.navigationItem.titleView = label1;
    
    
    
}

- (void)leftClick{
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (void)viewDidLoad

{
    
    [super viewDidLoad];
    [self fetchGroupInfo];
    if (self.notice &&![self.notice isEqualToString:@""]) {
        FDGroupSettingHeaderView *header = [[[NSBundle mainBundle] loadNibNamed:@"FDGroupSettingHeaderView" owner:nil options:nil]lastObject];
        
        header.notice.text = self.notice;
        CGRect  noticeRect = [self.notice boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-90, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        header.height = noticeRect.size.height+100;
        self.tableView.tableHeaderView = header;
    }
    
    [self addTitleViewWithTitle:@"设置"];

    self.tableView.tableFooterView = self.footerView;

    _pushSwitch = [[UISwitch alloc] init];

    [_pushSwitch addTarget:self action:@selector(pushSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_pushSwitch setOn:!_chatGroup.isPushNotificationEnabled animated:YES];
    
    //设置ON一边的背景颜色，默认是绿色

    _pushSwitch.onTintColor = [FDUtils colorWithHexString:@"#EF2840"];
    //设置OFF一边的背景颜色，默认是灰色，发现OFF背景颜色其实也是控件”边框“颜色

//    _pushSwitch.tintColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:0.5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(groupBansChanged) name:@"GroupBansChanged" object:nil];

    

    
}

- (void)pushSwitchChanged:(id)sender

{

    BOOL toOn = _pushSwitch.isOn;
    
    if (toOn) {
        
        [MobClick event:@"click_discussiondetails_opennews"];
        
    }else{
        
        [MobClick event:@"click_discussiondetails_closenews"];
        
    }
    
    [self isIgnoreGroup:toOn];
    
    [self.tableView reloadData];
    
}

#pragma mark - private



- (void)isIgnoreGroup:(BOOL)isIgnore

{
    
    [self showHudInView:self.view hint:NSLocalizedString(@"group.setting.save", @"set properties")];
    
    
    
    __weak ChatGroupDetailViewController *weakSelf = self;
    
    [[EaseMob sharedInstance].chatManager asyncIgnoreGroupPushNotification:_chatGroup.groupId isIgnore:isIgnore completion:^(NSArray *ignoreGroupsList, EMError *error) {
        
        [weakSelf hideHud];
        
        if (!error) {
            
            [weakSelf showHint:NSLocalizedString(@"group.setting.success", @"set success")];
            
            
        }
        
        else{
            
            [weakSelf showHint:NSLocalizedString(@"group.setting.fail", @"set failure")];
            
        }
        
    } onQueue:nil];

}


- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}



- (void)viewDidDisappear:(BOOL)animated

{
    
    [super viewDidDisappear:animated];
    
}



#pragma mark - getter





- (UIButton *)exitButton

{
    
    if (_exitButton == nil) {
        
        _exitButton = [[UIButton alloc] init];
        
        [_exitButton setTitle:@"退出讨论组" forState:UIControlStateNormal];
        
        [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_exitButton addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_exitButton setBackgroundColor:[FDUtils colorWithHexString:@"#EF2840"]];
        
        _exitButton.layer.cornerRadius = 3;
        
        _exitButton.layer.masksToBounds = YES;
        
        _exitButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
    }
    
    
    
    return _exitButton;
    
}



- (UIView *)footerView

{
    
    if (_footerView == nil) {
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
        
        _footerView.backgroundColor = [UIColor clearColor];
        
        
        
        self.exitButton.frame = CGRectMake(15,  30, _footerView.frame.size.width-30, 50);
        
    }
    
    
    
    return _footerView;
    
}



#pragma mark - Table view data source

-(void)viewDidLayoutSubviews

{
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        
    }
    
    
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15.0f;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    

        return 1;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0&indexPath.section==0)
        
    {
        
        cell.textLabel.text = @"消息免打扰";
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    
        _pushSwitch.frame = CGRectMake(self.tableView.frame.size.width - (_pushSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _pushSwitch.frame.size.height) / 2+5, _pushSwitch.frame.size.width, _pushSwitch.frame.size.height);

        
        [cell.contentView addSubview:_pushSwitch];
        
        [cell.contentView bringSubviewToFront:_pushSwitch];
        
    }
    
    
    
    return cell;
    
}



#pragma mark - Table view delegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{

        
    return 51;

}





#pragma mark - EMChooseViewDelegate



- (void)groupBansChanged

{
    
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:self.chatGroup.occupants];
    

}



#pragma mark - data



- (void)fetchGroupInfo

{
    
//    HttpImGroupDetail *gorupDetail = [HttpImGroupDetail sharedInstance];
//    
//    [gorupDetail imGroupDetailWithGroupID:_chatGroup.groupId viewController:self];
    
    
    
    __weak typeof(self) weakSelf = self;
    
    [self showHudInView:self.view hint:NSLocalizedString(@"loadData", @"Load data...")];
    
    [[EaseMob sharedInstance].chatManager asyncFetchGroupInfo:_chatGroup.groupId completion:^(EMGroup *group, EMError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf hideHud];
            
            if (!error) {
                
                weakSelf.chatGroup = group;
                
                EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:group.groupId conversationType:eConversationTypeGroupChat];
                
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    
                    [ext setObject:group.groupSubject forKey:@"groupSubject"];
                    
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    
                    conversation.ext = ext;
                    
                }
                
                
                
                [weakSelf reloadDataSource];
                
            }
            
            else{
                
                [weakSelf showHint:NSLocalizedString(@"group.fetchInfoFail", @"failed to get the group details, please try again later")];
                
            }
            
        });
        
    } onQueue:nil];
    
}



- (void)reloadDataSource

{
    
    [self.dataSource removeAllObjects];
    
    
    
    self.occupantType = GroupOccupantTypeMember;
    
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    
    if ([self.chatGroup.owner isEqualToString:loginUsername]) {
        
        self.occupantType = GroupOccupantTypeOwner;
        
    }
    
    
    
    if (self.occupantType != GroupOccupantTypeOwner) {
        
        for (NSString *str in self.chatGroup.members) {
            
            if ([str isEqualToString:loginUsername]) {
                
                self.occupantType = GroupOccupantTypeMember;
                
                break;
                
            }
            
        }
        
    }
    
    
    
    [self.dataSource addObjectsFromArray:self.chatGroup.occupants];
    
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    [self refreshFooterView];
    
    [self hideHud];
    
    //    });
    
}



- (void)refreshFooterView

{
    
    [_dissolveButton removeFromSuperview];
    
    [_footerView addSubview:self.exitButton];
    
}



//清空聊天记录

- (void)clearAction

{
    
    __weak typeof(self) weakSelf = self;
    
    [EMAlertView showAlertWithTitle:NSLocalizedString(@"prompt", @"Prompt")
     
                            message:NSLocalizedString(@"sureToDelete", @"please make sure to delete")
     
                    completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
                        
                        if (buttonIndex == 1) {
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveAllMessages" object:weakSelf.chatGroup.groupId];
                            
                        }
                        
                    } cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
     
                  otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
    
    
    
}



//解散群组

- (void)dissolveAction

{
    
    __weak typeof(self) weakSelf = self;
    
    [self showHudInView:self.view hint:NSLocalizedString(@"group.destroy", @"dissolution of the group")];
    
    [[EaseMob sharedInstance].chatManager asyncDestroyGroup:_chatGroup.groupId completion:^(EMGroup *group, EMGroupLeaveReason reason, EMError *error) {
        
        [weakSelf hideHud];
        
        if (error) {
            
            [weakSelf showHint:NSLocalizedString(@"group.destroyFail", @"dissolution of group failure")];
            
        }
        
        else{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ExitGroup object:nil];
            
        }
        
    } onQueue:nil];
    
    
    
    //    [[EaseMob sharedInstance].chatManager asyncLeaveGroup:_chatGroup.groupId];
    
}



//设置群组

- (void)configureAction {
    
    // todo
    
    [[[EaseMob sharedInstance] chatManager] asyncIgnoreGroupPushNotification:_chatGroup.groupId
     
                                                                    isIgnore:_chatGroup.isPushNotificationEnabled];
    
    
    
    return;
    
    //    UIViewController *viewController = [[UIViewController alloc] init];
    
    //    [self.navigationController pushViewController:viewController animated:YES];
    
}



//退出群组

- (void)exitAction

{

    [MobClick event:@"click_discussiondetails_exit"];
    
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
    
    payResult.title.text = @"退出";
    
    payResult.detail.text = @"确认退出讨论组";
    
    [payResult.doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [payResult.cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [poplistview addSubview:payResult];
    

    
}

- (void)doneBtnClick{
    
    HttpImGroupExit *tool = [HttpImGroupExit sharedInstance];
    
    [tool loadExitGroup:self];
    
}

- (void)cancleBtnClick{
    
    [self.popoverListView dismiss];
    
}



//- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error {

//    __weak ChatGroupDetailViewController *weakSelf = self;

//    [weakSelf hideHud];

//    if (error) {

//        if (reason == eGroupLeaveReason_UserLeave) {

//            [weakSelf showHint:@"退出群组失败"];

//        } else {

//            [weakSelf showHint:@"解散群组失败"];

//        }

//    }

//}



- (void)didIgnoreGroupPushNotification:(NSArray *)ignoredGroupList error:(EMError *)error {
    
    // todo
    
    MQQLog(@"ignored group list:%@.", ignoredGroupList);
    
}



#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    NSInteger index = _selectedContact.index;
    
    if (buttonIndex == 0)
        
    {
        
        //delete
        
        _selectedContact.deleteContact(index);
        
    }
    
    else if (buttonIndex == 1)
        
    {
        
        //add to black list
        
        [self showHudInView:self.view hint:NSLocalizedString(@"group.ban.adding", @"Adding to black list..")];
        
        NSArray *occupants = [NSArray arrayWithObject:[self.dataSource objectAtIndex:_selectedContact.index]];
        
        __weak ChatGroupDetailViewController *weakSelf = self;
        
        [[EaseMob sharedInstance].chatManager asyncBlockOccupants:occupants fromGroup:self.chatGroup.groupId completion:^(EMGroup *group, EMError *error) {
            
            if (weakSelf)
                
            {
                
                __weak ChatGroupDetailViewController *strongSelf = weakSelf;
                
                [strongSelf hideHud];
                
                if (!error) {
                    
                    strongSelf.chatGroup = group;
                    
                    [strongSelf.dataSource removeObjectAtIndex:index];

                    
                }
                
                else{
                    
                    [strongSelf showHint:error.description];
                    
                }
                
            }
            
        } onQueue:nil];
        
    }
    
    _selectedContact = nil;
    
}



- (void)actionSheetCancel:(UIActionSheet *)actionSheet

{
    
    _selectedContact = nil;
    
}

@end


