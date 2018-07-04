//
//  ConversationListController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "ConversationListController.h"
#import "ChatViewController.h"
#import "UserProfileManager.h"
#import "RealtimeSearchUtil.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "NSDate+Category.h"
#import "HQConst.h"
#import "FDUtils.h"
#import "ApplyViewController.h"
#import "HQIMFriendsTool.h"
#import "FDGroupDetailTool.h"

@interface ConversationListController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource>

@property (nonatomic, strong) UIView *networkStateView;


@end

@implementation ConversationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载申请通知的数据
    [[ApplyViewController shareController] loadDataSourceFromLocalDB];
    
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = Background_Color;
    
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    self.title = @"我的消息";
    [self tableViewDidTriggerHeaderRefresh];
    
    self.tableView.frame = self.view.bounds;
    [self networkStateView];
    
    [self removeEmptyConversationsFromDB];
    
    self.showRefreshHeader = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

#pragma mark - getter
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - EaseConversationListViewControllerDelegate
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController{
    
    [self.navigationController pushViewController:[ApplyViewController shareController] animated:YES];
    
}
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
            
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
//            chatController.type = @"2";
//            chatController.content = @"饭点发抵扣券了，快来抢";
//            chatController.confirm = @"立即查看";

            if (conversation.conversationType==eConversationTypeChat) {
                ///单聊
                if (conversationModel.conversation.latestMessageFromOthers){
                    //                chatController.title = conversationModel.conversation.latestMessageFromOthers.ext[@"userName"];
                    [chatController addTitleViewWithTitle:conversationModel.conversation.latestMessageFromOthers.ext[@"userName"]];
                }else{
                    NSDictionary *dic= [[HQIMFriendsTool sharedInstance] recordFriendDetail:conversationModel.conversation.chatter];
                    //            chatController.title =[dic objectForKey:@"nickname"];
                    [chatController addTitleViewWithTitle:[dic objectForKey:@"nickname"]];
                }
                
            }else{
                
                //            chatController.title = conversationModel.title;
                [chatController addTitleViewWithTitle:conversationModel.title];
            }
            
            
            [self.navigationController pushViewController:chatController animated:YES];
            
        }
    }
}

#pragma mark - EaseConversationListViewControllerDataSource

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.conversationType == eConversationTypeChat) {
        
        UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:conversation.chatter];
        if (profileEntity) {
            model.title = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
            model.avatarURLPath = profileEntity.imageUrl;
        }
    } else if (model.conversation.conversationType == eConversationTypeGroupChat) {
        NSString *imageName = @"placeholder";
        if (![conversation.ext objectForKey:@"groupSubject"] || ![conversation.ext objectForKey:@"isPublic"])
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    model.title = group.groupSubject;
                    imageName = group.isPublic ? @"placeholder" : @"placeholder";
                    model.avatarImage = [UIImage imageNamed:imageName];
                    
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.groupSubject forKey:@"groupSubject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        } else {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    imageName = group.isPublic ? @"placeholder" : @"placeholder";
                    
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.groupSubject forKey:@"groupSubject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    NSString *groupSubject = [ext objectForKey:@"groupSubject"];
                    NSString *conversationSubject = [conversation.ext objectForKey:@"groupSubject"];
                    if (groupSubject && conversationSubject && ![groupSubject isEqualToString:conversationSubject]) {
                        conversation.ext = ext;
                    }
                    break;
                }
            }
            model.title = [conversation.ext objectForKey:@"groupSubject"];
            imageName = [[conversation.ext objectForKey:@"isPublic"] boolValue] ? @"placeholder" : @"placeholder";
            model.avatarImage = [UIImage imageNamed:imageName];
        }
    }
    return model;
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
      latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case eMessageBodyType_File: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    
    return latestMessageTitle;
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    
    return latestMessageTime;
}

#pragma mark - public

-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
    
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}

- (void)willReceiveOfflineMessages{
    //NSLog(NSLocalizedString(@"message.beginReceiveOffine", @"Begin to receive offline messages"));
}

- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self refreshDataSource];
}

- (void)didFinishedReceiveOfflineMessages{
    //NSLog(NSLocalizedString(@"message.endReceiveOffine", @"End to receive offline messages"));
}
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


@end
