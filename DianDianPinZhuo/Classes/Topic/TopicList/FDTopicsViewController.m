//
//  FDTopicsViewController.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicsViewController.h"
#import "FDTopics.h"
#import "FDTopicsCell.h"
#import "FDTopicsFrame.h"
#import "FDSubjectDetailViewController.h"
#import "HttpTopicSearch.h"
#import "FDSponsorTopicViewController.h"
#import "AdsModel.h"
#import "AdView.h"
#import "FDLoginViewController.h"
#import "HttpUserBannerNotify.h"
#import "FDWebViewController.h"
#import "FDInvitationViewController.h"
#import "HMLoadMoreFooter.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "FDNearGroupHeaderView.h"
#import "FDNearTopicHeaderView.h"
#import "EaseMob.h"
#import "ConversationListController.h"
#import "EaseSigalChatCell.h"
#import "UIImageView+EMWebCache.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "FDGroupDetailTool.h"
#import "ChatViewController.h"
#import "HQIMFriendsTool.h"
#import "NSDate+Category.h"
#import "UserProfileManager.h"
#import "ApplyViewController.h"
#import "ConversationListController.h"
#import "FDSponsorTopicViewController.h"
#import "FDNotJoinGroupsViewController.h"
#import "FDNotJoinGroupsFrame.h"
#import "FDNotJoinGroupsCell.h"
#import "NotJoinGroupModel.h"
#import "HttpImJoinGroup.h"
#import "HttpTopicInit.h"
#import "HttpImTopicGroupList.h"
#import "FDHuanXinLoginTool.h"


//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface FDTopicsViewController ()<FDLoginViewControllerDelegate,EMChatManagerDelegate>
{
    NSInteger selectedIndex;
    BOOL isfirstScroll;
}
@property(nonatomic,strong) NSString *topic_category_id;

@property (weak, nonatomic) id<EaseConversationListViewControllerDelegate> delegate;
@property (weak, nonatomic) id<EaseConversationListViewControllerDataSource> dataSource;
@property (assign, nonatomic)BOOL hasEMMessage;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;


@end

@implementation FDTopicsViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    ///话题列表流量
    [MobClick event:@"pv_topiclist"];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.latString = @"";
    self.lngString = @"";
    self.topic_category_id = @"0";
    selectedIndex = -1;
    ///支付失败刷新数据
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payback) name:PayFailOrScuessReloadHome object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCell:) name:refreshCell object:nil];
    /**
     *  环信登录状态改变的通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImGroups) name:KNOTIFICATION_LOGINCHANGE object:nil];
    /**
     *  加入群或者登出群通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImGroups) name:JoinInOrOutGroup object:nil];

    self.view.backgroundColor = Background_Color;
    self.tableView.backgroundColor = Background_Color;
    
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-32);
    
    self.haveMJRefresh = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationClick:) name:GetLocation object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadingClick:) name:loadingBack object:nil];
 
    self.groupArray = [NSMutableArray array];
    self.groupArray_desc = [NSMutableArray array];

    ///注册环信 ，计算环信未读消息
    [self registerNotifications];
    
    [self setupUnreadMessageCount];
    
    [self setupUntreatedApplyCount];
   
    
}

- (void)locationClick:(NSNotification *)no{
    _latString = no.userInfo[@"lat"];
    _lngString = no.userInfo[@"lng"];
    _topic_category_id = @"1";
    /**
     *  初次加载话题和群组数据
     */
    [self loadFirstMerchantSearch];
    [self loadImGroupsFrist];
}
/**
 *  加载广告数据
 */
- (void)loadingClick:(NSNotification *)no{
    NSMutableArray *arry = no.userInfo[@"adsArray"];
    if (arry.count!=self.adsArray.count) {
        self.adsArray = no.userInfo[@"adsArray"];
        [self makeAdsView];
    }
}

#pragma mark - 加载群组数据
- (void)loadImGroupsFrist{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //显示第0页
    if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] isEqualToString:@"1"]){
        //[SVProgressHUD showWithStatus:@"加载中..."];
    }
    HttpImTopicGroupList *imtopic_group = [HttpImTopicGroupList sharedInstance];
    [imtopic_group loadFristImGroupListWithController:self];
    
}
- (void)loadImGroups{
    HttpImTopicGroupList *imtopic_group = [HttpImTopicGroupList sharedInstance];
    [imtopic_group loadImGroupListWithController:self];
}
#pragma mark 从本地匹配聊天信息
-(void)getGroupInfo{
    NSMutableArray *im_conversationsArray = [NSMutableArray array];
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
    
    
    
    [self.groupArray removeAllObjects];
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
            [im_conversationsArray addObject:model];
        }
    }
    [self.groupArray removeAllObjects];
    [self.tableView reloadData];
    for (int i=0; i<self.groupArray_desc.count; i++) {
        NotJoinGroupModel *model = self.groupArray_desc[i];
        for (int j=0; j<im_conversationsArray.count; j++) {
            EaseConversationModel *im_model = im_conversationsArray[j];
            if ([im_model.conversation.chatter isEqualToString:model.group_id]) {
                im_model.title = model.name;
                im_model.avatarURLPath = model.icon;
                [self.groupArray addObject:im_model];
            }
        }
    }
    if (self.im_list_load_success && self.topic_list_load_success) {
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }
}

- (void)setupDownRefresh{
    HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    footer.frame = CGRectMake(0, 0, ScreenW, 60);
    [footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MJRefreshMore)]];
    self.footer = footer;
    if (self.datyArray.count==0) {
        self.footer.hidden = YES;
    }else{
        self.footer.hidden = NO;
    }
}
#pragma mark - 跳转发起话题
- (void)send_topBtnClick:(UIButton *)sender{
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        
        FDLoginViewController *verification = [[FDLoginViewController alloc] init];
        verification.delegate = self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    HttpTopicInit *topic_init = [HttpTopicInit sharedInstance];
    [topic_init loadTopicInitWithController:self button:sender];

}
#pragma mark -- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        FDSponsorTopicViewController *makeTopic = [[FDSponsorTopicViewController alloc] init];
         makeTopic.default_topic_title = self.default_topic_title;
        [self.navigationController pushViewController:makeTopic animated:YES];
    }
    
}

#pragma mark - banner
- (void)makeAdsView{
    self.tableView.tableHeaderView=nil;
    if (self.adsArray.count>0) {//第一次加载添加广告
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.4+10)];
        head.backgroundColor = Background_Color;
        if (self.adsArray.count==1) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.4)];
            AdsModel *model = self.adsArray[0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"ad_image"]completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
                imageView.image = image;
            }];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adsViewTapClick)]];
            [head addSubview:imageView];
            self.tableView.tableHeaderView = head;
            
        }else{
            NSMutableArray *imagesArray = [NSMutableArray array];
            for (AdsModel *adsModel in self.adsArray) {
                [imagesArray addObject:adsModel.img];
            }
            AdView *adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.4) imageLinkURL:imagesArray placeHoderImageName:@"ad_image" pageControlShowStyle:UIPageControlShowStyleCenter];
            adView.callBack = ^(NSInteger index,NSString * imageURL)
            {
                AdsModel *model = self.adsArray[index];
                if ([model.url isEqualToString:@""]) {
                    return ;
                }else if ([model.url isEqualToString:@"invite"]){
                    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
                        
                        FDLoginViewController *verification = [[FDLoginViewController alloc] init];
                        
                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
                        [self presentViewController:nav animated:YES completion:nil];
                        
                    }else{
                        
                        FDInvitationViewController *invitation = [[FDInvitationViewController alloc] init];
                        [self.navigationController pushViewController:invitation animated:YES];
                    }
                }else{
                    FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
                    webView.url = model.url;
                    webView.titleString = model.title;
                    [self.navigationController pushViewController:webView animated:YES];
                }
                if (![[HQDefaultTool getKid]isEqualToString:@""]) {
                    HttpUserBannerNotify *userBanner = [HttpUserBannerNotify sharedInstance];
                    if (model.banner_id) {
                        [userBanner loadUserBannerNotifyWithBanner_id:model.banner_id];
                    }
                }
                
            };
            
            [head addSubview:adView];
            self.tableView.tableHeaderView = head;
            
        }
        [self.tableView reloadData];
    }

}
- (void)presentToLoginViewController{
    FDLoginViewController *verification = [[FDLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)adsViewTapClick{
    ///
    [MobClick event:@"click_list_banner"];
    
    AdsModel *model = self.adsArray[0];
    if ([model.url isEqualToString:@""]) {//没有点击效果
        return ;
    }else if ([model.url isEqualToString:@"invite"]){
        if ([[HQDefaultTool getKid] isEqualToString:@""]) {
            [self presentToLoginViewController];
        }else{//跳转到有奖邀请
            
            FDInvitationViewController *invitation = [[FDInvitationViewController alloc] init];
            [self.navigationController pushViewController:invitation animated:YES];
        }
    }else{//跳转到webView
        FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
        webView.url = model.url;
        webView.titleString = model.title;
        [self.navigationController pushViewController:webView animated:YES];
    }
    if (![[HQDefaultTool getKid]isEqualToString:@""]) {
        HttpUserBannerNotify *userBanner = [HttpUserBannerNotify sharedInstance];
        if (model.banner_id) {
            [userBanner loadUserBannerNotifyWithBanner_id:model.banner_id];
        }
        
    }
    
}


#pragma mark - 第一次加载
- (void)loadFirstMerchantSearch{
    
    HttpTopicSearch *search = [HttpTopicSearch sharedInstance];
    [search topicSearchWithLat:self.latString lng:self.lngString topic_class_id:self.topic_category_id viewController:self];
    
}


- (void)payback{
    [self.datyArray removeAllObjects];
    [self.footer removeFromSuperview];
    self.tableView.tableFooterView = nil;
    [self.tableView reloadData];
    HttpTopicSearch *search = [HttpTopicSearch sharedInstance];
    [search topicSearchTapWithLat:self.latString lng:self.lngString topic_class_id:self.topic_category_id viewController:self];
}
- (void)MJRefreshTop{
    [self loadImGroups];
    HttpTopicSearch *search = [HttpTopicSearch sharedInstance];
    [search MJRefreshTopTopicSearchWithLat:self.latString lng:self.lngString topic_class_id:self.topic_category_id viewController:self];
}

- (void)MJRefreshMore{
    [self.footer beginRefreshing];
    HttpTopicSearch *search = [HttpTopicSearch sharedInstance];
    [search MJRefreshMoreTopicSearchWithLat:self.latString lng:self.lngString topic_class_id:self.topic_category_id viewController:self];
}
- (void)huanxinLogin{
    
    FDHuanXinLoginTool *tool = [FDHuanXinLoginTool sharedInstance];
    [tool huanxinLogin:self];
    
}


#pragma mark - UITableViewDataSource Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if ([[self.groupArray objectAtIndex:indexPath.row] isKindOfClass:[FDNotJoinGroupsFrame class]]) {
            
            FDNotJoinGroupsFrame *frame = self.groupArray[indexPath.row];
            return frame.cellHeight;
        }
        return 80;
    }
    FDTopicsFrame *frame = self.datyArray[indexPath.row];
    return frame.cellHeight;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {

        if ([[self.groupArray objectAtIndex:indexPath.row] isKindOfClass:[FDNotJoinGroupsFrame class]]) {
            
            FDNotJoinGroupsCell *cell = [FDNotJoinGroupsCell cellWithTableView:tableView];
            
            cell.statusFrame = self.groupArray[indexPath.row];
            cell.nav = self.navigationController;
            return cell;
        }else{
            id<IConversationModel> model = [self.groupArray objectAtIndex:indexPath.row];
            
            EaseSigalChatCell *cell = (EaseSigalChatCell *)[tableView dequeueReusableCellWithIdentifier:@"EaseSigalChatCell"];
            if (cell == nil) {
                cell = [[EaseSigalChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EaseSigalChatCell"];
            }
            cell.model = model;
            cell.avatarView.layer.cornerRadius = 3;
            cell.avatarView.layer.masksToBounds = YES;
            cell.titleLabel.text = model.title;
            [cell.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatarURLPath] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
                cell.avatarView.imageView.image = image;
            }];
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
            
            
            return cell;
            

        
        }
        

    }
    
    FDTopicsCell *cell = [FDTopicsCell cellWithTableView:tableView];
    cell.image.userInteractionEnabled = YES;
    cell.image.tag = indexPath.row;
    [cell.image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
    cell.statusFrame = self.datyArray[indexPath.row];
    cell.nav = self.navigationController;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        if ([[self.groupArray objectAtIndex:indexPath.row] isKindOfClass:[FDNotJoinGroupsFrame class]]) {
            if ([[HQDefaultTool getKid] isEqualToString:@""]) {
                [self presentToLoginViewController];
                return;
            }else{
                FDNotJoinGroupsFrame *frame = self.groupArray[indexPath.row];
                NotJoinGroupModel *model = frame.status;
                HttpImJoinGroup *join = [HttpImJoinGroup sharedInstance];
                [join loadImJoinGroupWithGroup_id_topicsVC:model.group_id controller:self group_name:model.name];
                return;
            }
           

        }
        if (![[EaseMob sharedInstance].chatManager isLoggedIn]) {
            [self huanxinLogin];
            return;
        }
        EaseConversationModel *conversationModel = self.groupArray[indexPath.row];
        if (conversationModel) {
            EMConversation *conversation = conversationModel.conversation;
            if (conversation) {
                
                ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
                
                if (conversation.conversationType==eConversationTypeChat) {
                    ///单聊
                    if (conversationModel.conversation.latestMessageFromOthers){
                        [chatController addTitleViewWithTitle:conversationModel.conversation.latestMessageFromOthers.ext[@"userName"]];
                    }else{
                        NSDictionary *dic= [[HQIMFriendsTool sharedInstance] recordFriendDetail:conversationModel.conversation.chatter];
                        [chatController addTitleViewWithTitle:[dic objectForKey:@"nickname"]];
                    }
                    
                }else{
                    chatController.is_join_in = YES;
                    [chatController addTitleViewWithTitle:conversationModel.title];
                }
                [self.navigationController pushViewController:chatController animated:YES];
                
            }
        }
        return;
    }
    
    selectedIndex = indexPath.row;
    FDTopicsFrame *frame = self.datyArray[indexPath.row];
    FDSubjectDetailViewController *subject = [[FDSubjectDetailViewController alloc] init];
    subject.model = frame.status;
    subject.latString = self.latString;
    subject.lngString = self.lngString;
    subject.local_lat = self.latString;
    subject.local_lng = self.lngString;
    subject.local = 1;
    [self.navigationController pushViewController:subject animated:YES];
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.groupArray.count;
    }
    return self.datyArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        FDNearGroupHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"FDNearGroupHeaderView" owner:nil options:nil]lastObject];
        view.line1H.constant = 0.5;
        view.line2H.constant = 0.5;
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notJoinGroupsClick)]];
        return view;
    }
    if (section==1) {
        FDNearTopicHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"FDNearTopicHeaderView" owner:nil options:nil]lastObject];
        view.line1H.constant = 0.5;
        view.line2H.constant = 0.5;
        [view.sendBtn addTarget:self action:@selector(send_topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return view;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        if (self.groupArray.count==0) {
            return nil;
        }
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 9, ScreenW, 10)];
        view.backgroundColor= Background_Color;
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 46;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        if (self.groupArray.count==0) {
            return 0.0001;
        }
        return 10;
    }
    return 0.001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma mark -- 点击图片查看大图
- (void)imageClick:(UITapGestureRecognizer *)tap{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.hideDeleteBtn = YES;
    NSMutableArray *photos = [NSMutableArray array];
    FDTopicsFrame *frameModel = self.datyArray[tap.view.tag];;
    NSArray *array = @[frameModel.status.image];
    int count = (int)array.count;
    for (int i = 0; i<count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:array[i]];
        photo.srcImageView = (UIImageView *)tap.view;
        [photos addObject:photo];
    }
    browser.photos = photos;
    browser.currentPhotoIndex = 0;
    [browser show];
    
    
}
-(void)notJoinGroupsClick{
    FDNotJoinGroupsViewController *notJoin = [[FDNotJoinGroupsViewController alloc]init];
    [self.navigationController pushViewController:notJoin animated:YES];
}

- (void)pushToMakeTopic{
    HttpTopicInit *topic_init = [HttpTopicInit sharedInstance];
    [topic_init loadTopicInitWithController:self button:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///刷新某一条cell
- (void)refreshCell:(NSNotification *)noti{
    NSMutableArray *array =(NSMutableArray *) noti.object;
    if (selectedIndex == -1) {
        return;
    }
    FDTopicsFrame *frameModel = self.datyArray[selectedIndex];
    frameModel.status.ordermeal_num = [array[0] intValue];
    frameModel.status.sheng_yu = [array[1] intValue];
    frameModel.status.comment_num = [array[2] intValue];
    [self.tableView reloadData];
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
#pragma mark - 环信未读消息变化
#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}


// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    
    if (unreadCount+[[[ApplyViewController shareController] dataSource] count]>0&&![[HQDefaultTool getKid] isEqualToString:@""]) {
        
        self.hasEMMessage = YES;
        [self getGroupInfo];
        
    }else{
        
        self.hasEMMessage = NO;;
    }
    MQQLog(@"消息%zd",unreadCount);
    
}
#pragma mark --消息数
- (void)setupUntreatedApplyCount{
    
    [[ApplyViewController shareController] loadDataSourceFromLocalDB];
    if ([[[ApplyViewController shareController] dataSource] count]!=0&&![[HQDefaultTool getKid] isEqualToString:@""]) {
        self.hasEMMessage = YES;
        //        [_rightBtnView showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
        
    }
}
// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages
{
    [self setupUnreadMessageCount];
}
- (void)didFinishedReceiveOfflineCmdMessages
{
    
}
- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}


//// 收到消息回调
//-(void)didReceiveMessage:(EMMessage *)message
//{
//    BOOL needShowNotification = (message.messageType != eMessageTypeChat) ? [self needShowNotification:message.conversationChatter] : YES;
//    if (needShowNotification) {
//#if !TARGET_IPHONE_SIMULATOR
//        
//        //        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
//        //        if (!isAppActivity) {
//        //            [self showNotificationWithMessage:message];
//        //        }else {
//        //            [self playSoundAndVibration];
//        //        }
//        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
//        switch (state) {
//            case UIApplicationStateActive:
//                [self playSoundAndVibration];
//                break;
//            case UIApplicationStateInactive:
//                [self playSoundAndVibration];
//                break;
//            case UIApplicationStateBackground:
//                [self showNotificationWithMessage:message];
//                break;
//            default:
//                break;
//        }
//#endif
//    }
//}

-(void)didReceiveCmdMessage:(EMMessage *)message
{
    MQQLog(@"%@",NSLocalizedString(@"receiveCmd", @"receive cmd message"));
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        MQQLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
//    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
//    //发送本地推送
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    notification.fireDate = [NSDate date]; //触发通知的时间
//    
//    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
//        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
//        NSString *messageStr = nil;
//        switch (messageBody.messageBodyType) {
//            case eMessageBodyType_Text:
//            {
//                messageStr = ((EMTextMessageBody *)messageBody).text;
//            }
//                break;
//            case eMessageBodyType_Image:
//            {
//                messageStr = NSLocalizedString(@"message.image", @"Image");
//            }
//                break;
//            case eMessageBodyType_Location:
//            {
//                messageStr = NSLocalizedString(@"message.location", @"Location");
//            }
//                break;
//            case eMessageBodyType_Voice:
//            {
//                messageStr = NSLocalizedString(@"message.voice", @"Voice");
//            }
//                break;
//            case eMessageBodyType_Video:{
//                messageStr = NSLocalizedString(@"message.video", @"Video");
//            }
//                break;
//            default:
//                break;
//        }
//        
//        NSString *title = [[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
//        if (message.messageType == eMessageTypeGroupChat) {
//            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
//            for (EMGroup *group in groupArray) {
//                if ([group.groupId isEqualToString:message.conversationChatter]) {
//                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
//                    break;
//                }
//            }
//        }
//        else if (message.messageType == eMessageTypeChatRoom)
//        {
//            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:@"username" ]];
//            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
//            NSString *chatroomName = [chatrooms objectForKey:message.conversationChatter];
//            if (chatroomName)
//            {
//                title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, chatroomName];
//            }
//        }
//        
//        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
//        
//    }
//    else{
//        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
////        [UIApplication sharedApplication].applicationIconBadgeNumber+=1;
//    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    //    notification.alertAction = NSLocalizedString(@"open", @"Open");
//    notification.timeZone = [NSTimeZone defaultTimeZone];
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
//    if (timeInterval < kDefaultPlaySoundInterval) {
//        MQQLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
//    } else {
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        self.lastPlaySoundDate = [NSDate date];
//    }
//    
//    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
//    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
//    notification.userInfo = userInfo;
//    
//    //发送通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - IChatManagerDelegate 登陆回调（主要用于监听自动登录是否成功）

- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (error) {
        
        
    }
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
