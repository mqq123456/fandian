//
//  ChatViewController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatGroupDetailViewController.h"
#import "CustomMessageCell.h"
#import "UserProfileManager.h"
#import "EaseEmotionManager.h"
#import "EaseEmoji.h"
#import "IQKeyboardManager.h"
#import "MobClick.h"
#import "FDUserDetailViewController.h"
#import "ChatViewHeaderView.h"
#import "FDGroupMemberViewController.h"
#import "FDPerfectInfoView.h"
#import "FDGameView.h"
#import "FDInformationViewController.h"
#import "ContactListSelectViewController.h"
#import "FDWebViewController.h"
#import "HttpUserInfo.h"
#import "HQDefaultTool.h"
#import "HttpImGroupMemberInfos.h"
#import "FDSubjectDetailViewController.h"
#import "FDTopics.h"
#import "FDPerfectInformationViewController.h"
#import "FDMerchantDetailController.h"
#import "FDCommentDetailViewController.h"

@interface ChatViewController ()<UIAlertViewDelegate, EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource,UIApplicationDelegate>
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
//    UIMenuItem *_transpondMenuItem;
    
}

@property (nonatomic) BOOL isPlayingAudio;
@property(nonatomic,strong)FDPerfectInfoView *perfectView;
@property(nonatomic,strong)FDGameView *gameView;

@end

@implementation ChatViewController

- (FDPerfectInfoView *)perfectView{
    if (!_perfectView) {
        _perfectView = [FDPerfectInfoView selfFDPerfectInfoView];
        [_perfectView.perfectBtn addTarget:self action:@selector(perfectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _perfectView;

}
- (FDGameView *)gameView{

    if (!_gameView) {
        _gameView = [FDGameView shareFdGameView];
    }
    return _gameView;


}
- (void)appDidEnterBackgroundNotif:(NSNotification*)notif{
    // 隐藏键盘
    [self.chatToolbar endEditing:YES];
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;

    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackgroundNotif:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];

    [[EaseBaseMessageCell appearance] setSendMessageVoiceAnimationImages:@[[UIImage imageNamed:@"chat_sender_audio_playing_full"], [UIImage imageNamed:@"chat_sender_audio_playing_000"], [UIImage imageNamed:@"chat_sender_audio_playing_001"], [UIImage imageNamed:@"chat_sender_audio_playing_002"], [UIImage imageNamed:@"chat_sender_audio_playing_003"]]];
    [[EaseBaseMessageCell appearance] setRecvMessageVoiceAnimationImages:@[[UIImage imageNamed:@"chat_receiver_audio_playing_full"],[UIImage imageNamed:@"chat_receiver_audio_playing000"], [UIImage imageNamed:@"chat_receiver_audio_playing001"], [UIImage imageNamed:@"chat_receiver_audio_playing002"], [UIImage imageNamed:@"chat_receiver_audio_playing003"]]];
    
    [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];
    
    [[EaseChatBarMoreView appearance] setMoreViewBackgroundColor:[UIColor clearColor]];
    
    [self _setupBarButtonItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAllMessages:) name:KNOTIFICATIONNAME_DELETEALLMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGroup) name:ExitGroup object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCallMessage:) name:@"insertCallMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callControllerClose" object:nil];
    
    //通过会话管理者获取已收发消息
    [self tableViewDidTriggerHeaderRefresh];
    
    EaseEmotionManager *manager= [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:[EaseEmoji allEmoji]];
    [self.faceView setEmotionManagers:@[manager]];

    if (self.conversation.conversationType == eConversationTypeGroupChat) {
        
        self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
        
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"ChatViewHeaderView" owner:self options:nil]lastObject];
        _headView.frame = CGRectMake(0, 64, ScreenW, 60);
        _headView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        _headView.layer.shadowOffset = CGSizeMake(0,1);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
        _headView.layer.shadowOpacity = 0.1;//阴影透明度，默认0
        _headView.layer.shadowRadius = 2;//阴影半径，默认3
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(members:)];
        [_headView addGestureRecognizer:tap];
        [self.view addSubview:_headView];
        
        HttpImGroupMemberInfos *group = [HttpImGroupMemberInfos sharedInstance];
        [group loadChatViewImGroupMemberInfoWithController:self group_id:self.conversation.chatter];
        
    }
    
    
  
}
#pragma mark --查看群成员
- (void)members:(UITapGestureRecognizer *)tap{
    if ([[HQDefaultTool getComplete_info] intValue]==1) {
        
        FDGroupMemberViewController *memberVC = [[FDGroupMemberViewController alloc]init];
        memberVC.group_id = self.conversation.chatter;
        [self.navigationController pushViewController:memberVC animated:YES];
    }else{
        if (![[HQDefaultTool getSex] isEqualToString:@""]&&![[HQDefaultTool getAge]isEqualToString:@""]&&![[HQDefaultTool getCompany]isEqualToString:@""]&&![[HQDefaultTool getOccupation]isEqualToString:@""] ) {
            FDGroupMemberViewController *memberVC = [[FDGroupMemberViewController alloc]init];
            memberVC.group_id = self.conversation.chatter;
            [self.navigationController pushViewController:memberVC animated:YES];
            return;
        }
        FDPerfectInformationViewController *per = [[FDPerfectInformationViewController alloc] init];
        per.group_id= self.conversation.chatter;
        [self.navigationController pushViewController:per animated:YES];
        
//        HttpUserInfo *tool = [HttpUserInfo sharedInstance];
//        [tool loadUserInfoInGroupWithViewController:self];

    }

}
- (void)addPerfectView{
    [self.navigationController.view addSubview:self.perfectView];

}

- (void)lookGroupMembers{

        FDGroupMemberViewController *memberVC = [[FDGroupMemberViewController alloc]init];
        memberVC.group_id = self.conversation.chatter;
        [self.navigationController pushViewController:memberVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick event:@"pv_discussion"];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    //self.navigationController.navigationBar.translucent = NO;
    if (self.conversation.conversationType == eConversationTypeGroupChat) {
        if ([[self.conversation.ext objectForKey:@"groupSubject"] length])
        {
            //            self.title = [self.conversation.ext objectForKey:@"groupSubject"];
        }
    }
}

#pragma mark - setup subviews

- (void)_setupBarButtonItem
{
    
    if (self.conversation.conversationType == eConversationTypeGroupChat) {
        UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//        [detailButton setImage:[UIImage imageNamed:@"chat_icon_set"] forState:UIControlStateNormal];
        [detailButton setTitle:@"设置" forState:UIControlStateNormal];
        [detailButton setTitleColor:[FDUtils colorWithHexString:@"#222222"] forState:UIControlStateNormal];
        detailButton.titleLabel.font = [UIFont systemFontOfSize:16];
//        detailButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [detailButton addTarget:self action:@selector(showGroupDetailAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
        
    }
    
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 888888) {
        
        if (buttonIndex == 1) {
           [self shareToSingal];
        }
        
        
    }else if (alertView.tag == 999999){
        if (buttonIndex == 1) {
             [self shareToGroup];
        }
       
    }else if (alertView.tag == 777777){
        if (buttonIndex == 1) {
             [self shareToGroup];
        }
       
    }
    
    
    
    
    else{
        if (alertView.cancelButtonIndex != buttonIndex) {
            self.messageTimeIntervalTag = -1;
            [self.conversation removeAllMessages];
            [self.dataArray removeAllObjects];
            [self.messsagesSource removeAllObjects];
            
            [self.tableView reloadData];
        }
    
    }
}

#pragma mark - EaseMessageViewControllerDelegate

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        if ([cell.model.message.ext[@"type"] isEqualToString:@"1"]) {///进入他人详情
            
            FDUserDetailViewController *userprofile = [[FDUserDetailViewController alloc] init];
            
            if (cell.model.message.groupSenderName.length == 32) {
                userprofile.kid = cell.model.message.groupSenderName;
            }else{
                if (cell.model.message.from.length==32) {
                    userprofile.kid = cell.model.message.from;
                }else{
                    userprofile.kid = cell.model.message.to;
                }
            }
            if (cell.model.isSender) {
                userprofile.kid = [HQDefaultTool getKid];
            }
            [self.navigationController pushViewController:userprofile animated:YES];
            
        }else if ([cell.model.message.ext[@"type"] isEqualToString:@"2"]||[cell.model.message.ext[@"type"] isEqualToString:@"3"]||[cell.model.message.ext[@"type"] isEqualToString:@"4"]||[cell.model.message.ext[@"type"] isEqualToString:@"6"]){
            
            FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
            webView.url = cell.model.message.ext[@"webUrl"];
            webView.titleString = cell.model.message.ext[@"webTitle"];
            
//            if ([cell.model.message.ext[@"type"] isEqualToString:@"2"]) {
//                NSString *url = cell.model.message.ext[@"webUrl"];
//                webView.url = [NSString stringWithFormat:@"%@&toKid=%@",url,[HQDefaultTool getKid]];
//            }
            [self.navigationController pushViewController:webView animated:YES];
            
        }else if ([cell.model.message.ext[@"type"] isEqualToString:@"5"]){
        
            FDSubjectDetailViewController *detail = [[FDSubjectDetailViewController alloc] init];
            FDTopics *model = [[FDTopics alloc] init];
            model.topic_id = cell.model.message.ext[@"webUrl"];
            detail.model = model;
            detail.latString = [HQDefaultTool getLat];
            detail.lngString = [HQDefaultTool getLng];
            detail.local_lng = [HQDefaultTool getLng];
            detail.local_lat = [HQDefaultTool getLat];
            detail.local = 1;
            detail.share = YES;
            [self.navigationController pushViewController:detail animated:YES];
        }
        else if ([cell.model.message.ext[@"type"] isEqualToString:@"7"]){
            
            
            FDMerchantDetailController *detail = [[FDMerchantDetailController alloc] init];
            detail.merchant_id = [cell.model.message.ext[@"webUrl"] intValue];
            MerchantModel *model = [[MerchantModel alloc] init];
            model.merchant_id = [cell.model.message.ext[@"webUrl"] intValue];;
            detail.model = model;
            detail.latString = [HQDefaultTool getLat];
            detail.lngString = [HQDefaultTool getLng];
            detail.local_lng = [HQDefaultTool getLng];
            detail.local_lat = [HQDefaultTool getLat];
            detail.local = @"1";
            [self.navigationController pushViewController:detail animated:YES];
        }
        else if ([cell.model.message.ext[@"type"] isEqualToString:@"8"]){
            //NSLog(@"====%@",[cell.model.message.ext description]);
            FDCommentDetailViewController *detail = [[FDCommentDetailViewController alloc] init];
            detail.comment_id = cell.model.message.ext[@"webUrl"];
            [self.navigationController pushViewController:detail animated:YES];
        }
//        [self _showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
}

- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)model
{
    if (model.bodyType == eMessageBodyType_Text) {
        NSString *CellIdentifier = [CustomMessageCell cellIdentifierWithModel:model];
        //发送cell
        CustomMessageCell *sendCell = (CustomMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (sendCell == nil) {
            sendCell = [[CustomMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
            sendCell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        sendCell.model = model;
        return sendCell;
    }
    return nil;
}

- (CGFloat)messageViewController:(EaseMessageViewController *)viewController
           heightForMessageModel:(id<IMessageModel>)messageModel
                   withCellWidth:(CGFloat)cellWidth
{
    if (messageModel.bodyType == eMessageBodyType_Text) {
        return [CustomMessageCell cellHeightWithModel:messageModel];
    }
    return 0.f;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController didSelectMessageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    return flag;
}

- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel
{
    FDUserDetailViewController *userprofile = [[FDUserDetailViewController alloc] init];
    
    if (messageModel.message.groupSenderName.length == 32) {
        userprofile.kid = messageModel.message.groupSenderName;
    }else{
        if (messageModel.message.from.length==32) {
            userprofile.kid = messageModel.message.from;
        }else{
            userprofile.kid = messageModel.message.to;
        }
    }
    if (messageModel.isSender) {
        userprofile.kid = [HQDefaultTool getKid];
    }
    [self.navigationController pushViewController:userprofile animated:YES];
}

- (void)messageViewController:(EaseMessageViewController *)viewController
            didSelectMoreView:(EaseChatBarMoreView *)moreView
                      AtIndex:(NSInteger)index
{
    // 隐藏键盘
    [self.chatToolbar endEditing:YES];
}

- (void)messageViewController:(EaseMessageViewController *)viewController
          didSelectRecordView:(UIView *)recordView
                 withEvenType:(EaseRecordViewType)type
{
    switch (type) {
        case EaseRecordViewTypeTouchDown:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView  recordButtonTouchDown];
            }
        }
            break;
        case EaseRecordViewTypeTouchUpInside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonTouchUpInside];
            }
            [self.recordView removeFromSuperview];
        }
            break;
        case EaseRecordViewTypeTouchUpOutside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonTouchUpOutside];
            }
            [self.recordView removeFromSuperview];
        }
            break;
        case EaseRecordViewTypeDragInside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonDragInside];
            }
        }
            break;
        case EaseRecordViewTypeDragOutside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonDragOutside];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - EaseMessageViewControllerDataSource

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"placeholder"];
    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.nickname];
    if (profileEntity) {
        model.avatarURLPath = profileEntity.imageUrl;
    }
    model.failImageName = @"imageDownloadFail";
    return model;
}

#pragma mark - EaseMob

#pragma mark - EMChatManagerLoginDelegate

- (void)didLoginFromOtherDevice
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)didRemovedFromServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    if (self.deleteConversationIfNull) {
        //判断当前会话是否为空，若符合则删除该会话
        EMMessage *message = [self.conversation latestMessage];
        if (message == nil) {
            [[EaseMob sharedInstance].chatManager removeConversationByChatter:self.conversation.chatter deleteMessages:NO append2Chat:YES];
        }
    }
    
}
- (void)showGroupDetailAction
{
    [self.view endEditing:YES];
    
    if (self.conversation.conversationType == eConversationTypeGroupChat) {
        ChatGroupDetailViewController *detailController = [[ChatGroupDetailViewController alloc] initWithGroupId:self.conversation.chatter];
        detailController.notice = self.notice;
        [self.navigationController pushViewController:detailController animated:YES];


    }
}

- (void)deleteAllMessages:(id)sender
{
    if (self.dataArray.count == 0) {
        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        return;
    }
    
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSString *groupId = (NSString *)[(NSNotification *)sender object];
        BOOL isDelete = [groupId isEqualToString:self.conversation.chatter];
        if (self.conversation.conversationType != eConversationTypeChat && isDelete) {
            self.messageTimeIntervalTag = -1;
            [self.conversation removeAllMessages];
            [self.messsagesSource removeAllObjects];
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        }
    }
    else if ([sender isKindOfClass:[UIButton class]]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"sureToDelete", @"please make sure to delete") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alertView show];
    }
}

- (void)transpondMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
                ContactListSelectViewController *listViewController = [[ContactListSelectViewController alloc] initWithNibName:nil bundle:nil];
                listViewController.messageModel = model;
                [listViewController tableViewDidTriggerHeaderRefresh];
                [self.navigationController pushViewController:listViewController animated:YES];
    }
    self.menuIndexPath = nil;
}

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
        
        [self.conversation removeMessage:model.message];
        [self.messsagesSource removeObject:model.message];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
    self.menuIndexPath = nil;
}

#pragma mark - notification
- (void)exitGroup
{
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)insertCallMessage:(NSNotification *)notification
{
    id object = notification.object;
    if (object) {
        EMMessage *message = (EMMessage *)object;
        [self addMessageToDataSource:message progress:nil];
        [[EaseMob sharedInstance].chatManager insertMessageToDB:message append2Chat:YES];
    }
}

- (void)handleCallNotification:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        //开始call
        self.isViewDidAppear = NO;
    } else {
        //结束call
        self.isViewDidAppear = YES;
    }
}

#pragma mark - private

- (void)_showMenuViewController:(UIView *)showInView
                   andIndexPath:(NSIndexPath *)indexPath
                    messageType:(MessageBodyType)messageType
{
    if (self.menuController == nil) {
        self.menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"delete", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"copy", @"Copy") action:@selector(copyMenuAction:)];
    }
    
//    if (_transpondMenuItem == nil) {
//        _transpondMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"transpond", @"Transpond") action:@selector(transpondMenuAction:)];
//    }

    if (messageType == eMessageBodyType_Text) {
        [self.menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem]];
    } else if (messageType == eMessageBodyType_Image){
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    } else {
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    }
    [self.menuController setTargetRect:showInView.frame inView:showInView.superview];
    [self.menuController setMenuVisible:YES animated:YES];
}
- (void)perfectBtn:(UIButton *)sender{
    [self.perfectView removeFromSuperview];
    FDInformationViewController *vc= [[FDInformationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)addGameView{

    [self.navigationController.view addSubview:self.gameView];
}

@end
