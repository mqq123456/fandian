//
//  EaseConversationListViewController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseConversationListViewController.h"

#import "EaseMob.h"
#import "EaseSDKHelper.h"
#import "EaseEmotionEscape.h"
#import "EaseConversationCell.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "NSDate+Category.h"
#import "UIImageView+EMWebCache.h"
#import "FDGroupDetailTool.h"
#import "HQDefaultTool.h"
#import "MobClick.h"
#import "XBNullView.h"
#import "HQConst.h"
#import "ApplyViewController.h"
#import "EaseSigalChatCell.h"
#import "HQIMFriendsTool.h"

@interface EaseConversationListViewController () <IChatManagerDelegate>
//@property(nonatomic,strong)XBNullView *nullView;

@end

@implementation EaseConversationListViewController
///空数据时显示的视图
//- (XBNullView *)nullView{
//    if (!_nullView) {
//        _nullView = [[XBNullView alloc]initNullViewWithFrame:self.view.bounds andImage:[UIImage imageNamed:@"content_ico_tlz"] andDescription:@"无讨论组"];
//        _nullView.desTextColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:102.0/255.0];
//        _nullView.desTextFont = [UIFont systemFontOfSize:20];
//        _nullView.backgroundColor = FDColor(242, 242, 242, 1);
//        _nullView.imgCenterYGap = -100;
//        self.nullView.hidden = YES;
//    }
//    _nullView.desLabel.text = @"无讨论组";
//    _nullView.nullImgView.image = [UIImage imageNamed:@"content_ico_tlz"];
//
//    return _nullView;
//}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick event:@"pv_discussionlist"];
    [self tableViewDidTriggerHeaderRefresh];
    [self registerNotifications];
    [self setupUntreatedApplyCount];
}
- (void)setupUntreatedApplyCount
{
    //    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
    //    applyCount = count;
    //    NSLog(@"reloadApplyView-----%zd",applyCount);
    [self.tableView reloadData];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:setupUntreatedApplyCount object:nil];
    //    [self.tableView addSubview:self.nullView];
    ///注册通知，被对方删除
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataSource) name:deleteMyFriend object:nil];
    
}
///被对方删除，刷新数据
- (void)reloadDataSource{
    [self tableViewDidTriggerHeaderRefresh];
    [self setupUntreatedApplyCount];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (self.share) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.share) {
        return [self.dataArray count];
    }else{
        if (section == 0) {
            return 1;
        }
        return [self.dataArray count];
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];

    if (indexPath.row == 0&&indexPath.section == 0&&!self.share) {
        EaseSigalChatCell *cell = (EaseSigalChatCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[EaseSigalChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        cell.titleLabel.text =@"待处理事项";
        cell.avatarView.layer.cornerRadius = 0;
        cell.avatarView.layer.masksToBounds = YES;
        cell.avatarView.imageView.image =[UIImage imageNamed:@"list_ico_dclsx_nor"];
        if ([[[ApplyViewController shareController] dataSource] count]==0) {
            cell.badgeView.hidden = YES;
            cell.detailLabel.text = @"没有待处理事项";
        }else{
            cell.badgeView.hidden= YES;
            //            cell.badgeView.text = [NSString stringWithFormat:@"%zd",[[[ApplyViewController shareController] dataSource] count]];
            cell.detailLabel.text = [NSString stringWithFormat:@"%zd个请求待处理",[[[ApplyViewController shareController] dataSource] count]];
            
        }
        
        return cell;
        
    }else{
        
        
        id<IConversationModel> model = [self.dataArray objectAtIndex:indexPath.row];
        
        
        //单聊
        if (model.conversation.conversationType==eConversationTypeChat) {
            EaseSigalChatCell *cell = (EaseSigalChatCell *)[tableView dequeueReusableCellWithIdentifier:@"EaseSigalChatCell"];
            if (cell == nil) {
                cell = [[EaseSigalChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EaseSigalChatCell"];
            }
            cell.model = model;
            if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTitleForConversationModel:)]) {
                cell.detailLabel.text = [_dataSource conversationListViewController:self latestMessageTitleForConversationModel:model];
            } else {
                cell.detailLabel.text = [self _latestMessageTitleForConversationModel:model];
            }
            
            if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTimeForConversationModel:)]) {
                cell.timeLabel.text = [_dataSource conversationListViewController:self latestMessageTimeForConversationModel:model];
            } else {
                cell.timeLabel.text = [self _latestMessageTimeForConversationModel:model];
            }
            
            
            if (!model.conversation.latestMessageFromOthers) {
                
                NSDictionary *dic= [[HQIMFriendsTool sharedInstance] recordFriendDetail:model.conversation.chatter];
                
                cell.titleLabel.text = [dic objectForKey:@"nickname"];
                
                [cell.avatarView.imageView sd_setImageWithURL:[dic objectForKey:@"url"] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                
                
            }else{
                cell.titleLabel.text = [model.conversation.latestMessageFromOthers.ext objectForKey:@"userName"];
                [cell.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:[model.conversation.latestMessageFromOthers.ext objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                
            }
            cell.avatarView.layer.cornerRadius = 24.5;
            cell.avatarView.layer.masksToBounds = YES;
            return cell;
        }else{
            //群聊
            EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.model = model;
            
            
            if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTitleForConversationModel:)]) {
                cell.detailLabel.text = [_dataSource conversationListViewController:self latestMessageTitleForConversationModel:model];
            } else {
                cell.detailLabel.text = [self _latestMessageTitleForConversationModel:model];
            }
            
            if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTimeForConversationModel:)]) {
                cell.timeLabel.text = [_dataSource conversationListViewController:self latestMessageTimeForConversationModel:model];
            } else {
                cell.timeLabel.text = [self _latestMessageTimeForConversationModel:model];
            }
//            ///已存
//            if ([[FDGroupDetailTool sharedInstance] isExistRecordWithGroupDetail:model.conversation.chatter]) {
//                
//                NSDictionary *groupDetail = [[FDGroupDetailTool sharedInstance] recordGroupDetail:model.conversation.chatter];
////                cell.creat_timeLabel.text = groupDetail[@"create_time"];
//                cell.titleLabel.text = groupDetail[@"title"];
//                [cell.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:groupDetail[@"icon"]] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
//                    
//                }];
//                
//                
//            }
//            else{
            
                [[EaseMob sharedInstance].chatManager asyncFetchGroupInfo:model.conversation.chatter completion:^(EMGroup *group, EMError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (!error) {
//                            EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:group.groupId conversationType:eConversationTypeGroupChat];
//                            if ([group.groupId isEqualToString:conversation.chatter]) {
//                                NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
//                                [ext setObject:group.groupSubject forKey:@"groupSubject"];
//                                [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
//                                conversation.ext = ext;
//                            }
                            NSArray *array = [group.groupDescription componentsSeparatedByString:@"_"];
                            //cell.creat_timeLabel.text = group.groupDescription;
                            cell.titleLabel.text = group.groupSubject;
                        
                            if (array.count>=2) {
                                
//                                cell.creat_timeLabel.text = array[0];
                                [cell.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
                                    cell.avatarView.image = image;
                                }];
                                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:model.conversation.chatter,@"group_id",[HQDefaultTool getKid],@"kid",group.groupSubject,@"title",array[1],@"icon",array[0],@"create_time", nil];

                                [[FDGroupDetailTool sharedInstance] addgroupDetail:dic group_idString:model.conversation.chatter];
                                
                            }else if(array.count==1){
//                                cell.creat_timeLabel.text = group.groupDescription;
                            }
                            
                        }
                        else{
                            
                        }
                    });
                } onQueue:nil];
                
                
//            }
            return cell;
            
        }
        //
        
        
        
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0&&indexPath.section == 0&&!self.share) {
        if (_delegate && [_delegate respondsToSelector:@selector(conversationListViewController:)]) {
            
            [_delegate conversationListViewController:self];
        }
    }else{
        
        [MobClick event:@"click_discussionlist_discussion"];
        if (_delegate && [_delegate respondsToSelector:@selector(conversationListViewController:didSelectConversationModel:)]) {
            EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
            
            [_delegate conversationListViewController:self didSelectConversationModel:model];
        }
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:model.conversation.chatter deleteMessages:YES append2Chat:YES];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSArray* sorted = [conversations sortedArrayUsingComparator:
                       ^(EMConversation *obj1, EMConversation* obj2){
                           EMMessage *message1 = [obj1 latestMessage];
                           EMMessage *message2 = [obj2 latestMessage];
                           if(message1.timestamp > message2.timestamp) {
                               return(NSComparisonResult)NSOrderedAscending;
                           }else {
                               return(NSComparisonResult)NSOrderedDescending;
                           }
                       }];
    
    
    
    [self.dataArray removeAllObjects];
    for (EMConversation *converstion in sorted) {
        EaseConversationModel *model = nil;
        if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:modelForConversation:)]) {
            model = [_dataSource conversationListViewController:self
                                           modelForConversation:converstion];
        }
        else{
            model = [[EaseConversationModel alloc] initWithConversation:converstion];
        }
        
        if (model) {
            [self.dataArray addObject:model];
        }
    }
    //    if (self.dataArray.count == 0) {
    //        self.nullView.hidden = NO;
    //    }else{
    //        self.nullView.hidden = YES;
    //
    //    }
    [self tableViewDidFinishTriggerHeader:YES reload:YES];
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - private
- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
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

- (NSString *)_latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return latestMessageTime;
}

//#pragma mark --  点击头像
//- (void)iconClick:(UITapGestureRecognizer *)sender{
//
//    FDUserDetailViewController *userprofile = [[FDUserDetailViewController alloc] init];
//    FDHeadImageView *icon= (FDHeadImageView *)sender.view;
//    userprofile.kid = icon.kid;
//    [self.navigationController pushViewController:userprofile animated:YES];
//
//
//}

@end
