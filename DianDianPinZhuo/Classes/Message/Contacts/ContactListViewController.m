//
//  ContactListViewController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/24.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "ContactListViewController.h"
#import "HQConst.h"
#import "EaseChineseToPinyin.h"
#import "ChatViewController.h"
#import "RobotListViewController.h"
#import "ChatroomListViewController.h"
#import "AddFriendViewController.h"
#import "ApplyViewController.h"
#import "EMSearchBar.h"
#import "EMSearchDisplayController.h"
#import "UserProfileManager.h"
#import "RealtimeSearchUtil.h"
#import "UserProfileManager.h"
#import "usersModel.h"
#import "HttpUserKid.h"
#import "UIImageView+EMWebCache.h"
#import "FDUserDetailViewController.h"

@implementation UsersModel (search)

//根据用户昵称进行搜索
- (NSString*)showName
{
    return [[UserProfileManager sharedInstance] getNickNameWithUsername:self.nickname];
}

@end

@interface ContactListViewController ()<UISearchBarDelegate, UISearchDisplayDelegate,BaseTableCellDelegate,UIActionSheetDelegate>
{
    NSIndexPath *_currentLongPressIndex;
    NSIndexPath *_deleteIndexPath;
    
}

@property (strong, nonatomic) NSMutableArray *sectionTitles;
@property (strong, nonatomic) NSMutableArray *contactsSource;

@property (nonatomic, assign) NSInteger unapplyCount;
@property (strong, nonatomic) EMSearchBar *searchBar;
@property (strong, nonatomic) UIView *footerView;

@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的饭友";
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:setupUntreatedApplyCount object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataSource) name:deleteMyFriend object:nil];
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.showRefreshHeader = NO;
    
    _contactsSource = [NSMutableArray array];
    _sectionTitles = [NSMutableArray array];
    
    //    [self tableViewDidTriggerHeaderRefresh];
    
    [self searchController];
    self.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    //    [self.view addSubview:self.searchBar];
    
    self.tableView.tableHeaderView = self.searchBar;
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor whiteColor];
    //改变索引的颜色
    self.tableView.sectionIndexColor = [UIColor blackColor];
    //    //改变索引选中的背景颜色
    //    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    [self reloadDataSource];
    
    
    
    // 环信UIdemo中有用到Parse, 加载用户好友个人信息
#warning Parse这里打开会报错。。。。。。。。。
    //    [[UserProfileManager sharedInstance] loadUserProfileInBackgroundWithBuddy:self.contactsSource saveToLoacal:YES completion:NULL];
}
- (void)setupTableFooterView{
    
    self.footerView = nil;
    self.tableView.tableFooterView = self.footerView;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadApplyView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView setEditing:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (NSArray *)rightItems
{
    if (_rightItems == nil) {
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [addButton setImage:[UIImage imageNamed:@"addContact.png"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addContactAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
        _rightItems = @[addItem];
    }
    
    return _rightItems;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[EMSearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.placeholder = NSLocalizedString(@"search", @"Search");
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}
- (UIView *)footerView{
    if(self.dataArray.count == 0){
        return nil;
    }
    
    if (_footerView == nil) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        _footerView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1];
    }
    UIButton *friendCount = [[UIButton alloc]initWithFrame:_footerView.bounds];
    [friendCount setTitle:[NSString stringWithFormat:@"%zd位饭友",[self.contactsSource count]] forState:UIControlStateNormal];
    [friendCount setTitleColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] forState:UIControlStateNormal];
    friendCount.titleLabel.font = [UIFont systemFontOfSize:14];
    [_footerView addSubview:friendCount];
    return _footerView;
}
- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak ContactListViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ContactListCell";
            BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            UsersModel *buddy = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            
            
            if ([buddy.url hasPrefix:@"http://image.fundot.com.cn/"]) {
                NSString *img;
                if (IPhone6Plus) {//
                    img = [NSString stringWithFormat:@"%@@120w",buddy.url];
                }else{
                    img = [NSString stringWithFormat:@"%@@80w",buddy.url];
                }
                
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    cell.imageView.image = image;
                }];
            }else{
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:buddy.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    cell.imageView.image = image;
                }];
            }
            
//            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:buddy.url] placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/user"] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
//                
//            }];
            cell.textLabel.text = buddy.nickname;
            cell.username = buddy.nickname;
            
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 50;
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            UsersModel *buddy = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
            NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
            if (loginUsername && loginUsername.length > 0) {
                if ([loginUsername isEqualToString:buddy.nickname]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notChatSelf", @"can't talk to yourself") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    return;
                }
            }
            
            [weakSelf.searchController.searchBar endEditing:YES];
            ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:buddy.kid
                                                                                conversationType:eConversationTypeChat];
            //            chatVC.title = [[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.nickname];
            [chatVC addTitleViewWithTitle:[[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.nickname]];
            [weakSelf.navigationController pushViewController:chatVC animated:YES];
        }];
    }
    
    return _searchController;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.dataArray count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 0;
    }
    
    return [[self.dataArray objectAtIndex:(section - 1)] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [EaseUserCell cellIdentifierWithModel:nil];
    EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.model = nil;
        if (indexPath.row == 0) {
            NSString *CellIdentifier = @"addFriend";
            EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.avatarView.image = [UIImage imageNamed:@"newFriends"];
            cell.titleLabel.text = NSLocalizedString(@"title.apply", @"Application and notification");
            cell.avatarView.badge = self.unapplyCount;
            return cell;
        }
        else if (indexPath.row == 1) {
            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.titleLabel.text = NSLocalizedString(@"title.group", @"Group");
        }
        else if (indexPath.row == 2) {
            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.titleLabel.text = NSLocalizedString(@"title.chatroomlist",@"chatroom list");
        }
        else if (indexPath.row == 3) {
            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.titleLabel.text = NSLocalizedString(@"title.robotlist",@"robot list");
        }
    }
    else{
        if (self.dataArray&&self.dataArray.count>0) {
            NSArray *userSection = [self.dataArray objectAtIndex:(indexPath.section - 1)];
            EaseUserModel *model = [userSection objectAtIndex:indexPath.row];
            cell.indexPath = indexPath;
            cell.delegate = self;
            cell.model = model;
        }
        
        //        UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.nickname];
        //        if (profileEntity) {
        //            model.avatarURLPath = profileEntity.imageUrl;
        //            model.nickname = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
        //        }
        
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.01;
    }
    else{
        return 22;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    [label setText:[self.sectionTitles objectAtIndex:(section - 1)]];
    [contentView addSubview:label];
    return contentView;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            [self.navigationController pushViewController:[ApplyViewController shareController] animated:YES];
        }
        else if (row == 1)
        {
            if (_groupController == nil) {
                _groupController = [[GroupListViewController alloc] initWithStyle:UITableViewStylePlain];
            }
            else{
                [_groupController reloadDataSource];
            }
            [self.navigationController pushViewController:_groupController animated:YES];
        }
        else if (row == 2)
        {
            ChatroomListViewController *controller = [[ChatroomListViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if (row == 3) {
            RobotListViewController *robot = [[RobotListViewController alloc] init];
            [self.navigationController pushViewController:robot animated:YES];
        }
    }
    else{
        EaseUserModel *model = [[self.dataArray objectAtIndex:(section - 1)] objectAtIndex:row];
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        if (loginUsername && loginUsername.length > 0) {
            if ([loginUsername isEqualToString:model.nickname]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notChatSelf", @"can't talk to yourself") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                [alertView show];
                
                return;
            }
        }
//        ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.kid conversationType:eConversationTypeChat];
//        //        chatController.title = model.nickname.length > 0 ? model.nickname : model.nickname;
//        [chatController addTitleViewWithTitle:model.nickname.length > 0 ? model.nickname : model.nickname];
//        [self.navigationController pushViewController:chatController animated:YES];
//        
        FDUserDetailViewController *userprofile = [[FDUserDetailViewController alloc] init];
       
        userprofile.kid = model.kid;
        [self.navigationController pushViewController:userprofile animated:YES];

    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        _deleteIndexPath = indexPath;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定删除好友？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    __weak typeof(self) weakSelf = self;
    //
    //    NSMutableArray *array = [NSMutableArray array];
    //    for (UsersModel* buddy in self.contactsSource) {
    //
    //        EMBuddy *model = [[EMBuddy alloc]init];
    //
    //        if (model) {
    ////            model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
    ////            model.avatarURLPath = buddy.url;
    //            model.username = buddy.nickname;
    ////            model.kid = buddy.kid;
    //            [array addObject:model];
    //        }
    //    }
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.contactsSource searchText:(NSString *)searchText collationStringSelector:@selector(showName) resultBlock:^(NSArray *results) {
        if (results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.searchController.resultsSource removeAllObjects];
                [weakSelf.searchController.resultsSource addObjectsFromArray:results];
                [weakSelf.searchController.searchResultsTableView reloadData];
            });
        }
    }];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - BaseTableCellDelegate

- (void)cellImageViewLongPressAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row >= 1) {
        // 群组，聊天室
        return;
    }
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    EaseUserModel *model = [[self.dataArray objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
    if ([model.nickname isEqualToString:loginUsername])
    {
        return;
    }
    
    _currentLongPressIndex = indexPath;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") destructiveButtonTitle:NSLocalizedString(@"friend.block", @"join the blacklist") otherButtonTitles:nil, nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - action

- (void)addContactAction
{
    AddFriendViewController *addController = [[AddFriendViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:addController animated:YES];
}

#pragma mark - private data

- (void)_sortDataArray:(NSArray *)buddyList
{
    [self.dataArray removeAllObjects];
    [self.sectionTitles removeAllObjects];
    NSMutableArray *contactsSource = [NSMutableArray array];
    
    //    //从获取的数据中剔除黑名单中的好友
    //    NSArray *blockList = [[EaseMob sharedInstance].chatManager blockedList];
    //    for (EMBuddy *buddy in buddyList) {
    //        if (![blockList containsObject:buddy.username]) {
    //            [contactsSource addObject:buddy];
    //        }
    //    }
    //
    contactsSource = [buddyList mutableCopy];
    
    self.contactsSource = contactsSource;
    
    //建立索引的核心, 返回27，是a－z和＃
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    
    NSInteger highSection = [self.sectionTitles count];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    //按首字母分组
    
    
    for (UsersModel* buddy in contactsSource) {
        
        EaseUserModel *model = [[EaseUserModel alloc]init];
        
        if (model) {
            model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
            model.avatarURLPath = buddy.url;
            model.nickname = buddy.nickname;
            model.kid = buddy.kid;
            NSString *firstLetter = [EaseChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.nickname]];
            NSInteger section=0;
            if (firstLetter &&![firstLetter isEqualToString:@""]) {
                section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
            }
            if (sortedArray.count >0) {
                NSMutableArray *array = [sortedArray objectAtIndex:section];
                [array addObject:model];
            }
            
        }
    }
    
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(EaseUserModel *obj1, EaseUserModel *obj2) {
            NSString *firstLetter1 = [EaseChineseToPinyin pinyinFromChineseString:obj1.buddy.username];
            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
            
            NSString *firstLetter2 = [EaseChineseToPinyin pinyinFromChineseString:obj2.buddy.username];
            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
            
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        
        
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
    
    //去掉空的section
    for (NSInteger i = [sortedArray count] - 1; i >= 0; i--) {
        NSArray *array = [sortedArray objectAtIndex:i];
        if ([array count] == 0) {
            [sortedArray removeObjectAtIndex:i];
            [self.sectionTitles removeObjectAtIndex:i];
        }
    }
    
    [self.dataArray addObjectsFromArray:sortedArray];
    [self.tableView reloadData];
}

//#pragma mark - EaseUserCellDelegate
//
//- (void)cellLongPressAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0 && indexPath.row >= 1) {
//        // 群组，聊天室
//        return;
//    }
//    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
//    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
//    EaseUserModel *model = [[self.dataArray objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
//    if ([model.nickname isEqualToString:loginUsername])
//    {
//        return;
//    }
//
//    _currentLongPressIndex = indexPath;
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") destructiveButtonTitle:NSLocalizedString(@"friend.block", @"join the blacklist") otherButtonTitles:nil, nil];
//    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
//}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex && _currentLongPressIndex) {
        EaseUserModel *model = [[self.dataArray objectAtIndex:(_currentLongPressIndex.section - 1)] objectAtIndex:_currentLongPressIndex.row];
        [self hideHud];
        [self showHudInView:self.view hint:NSLocalizedString(@"wait", @"Pleae wait...")];
        
        __weak typeof(self) weakSelf = self;
        [[EaseMob sharedInstance].chatManager asyncBlockBuddy:model.nickname relationship:eRelationshipFrom withCompletion:^(NSString *username, EMError *error){
            typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf hideHud];
            if (!error)
            {
                //由于加入黑名单成功后会刷新黑名单，所以此处不需要再更改好友列表
            }
            else
            {
                [strongSelf showHint:error.description];
            }
        } onQueue:nil];
    }
    _currentLongPressIndex = nil;
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    //    [self showHudInView:self.view hint:NSLocalizedString(@"loadData", @"Load data...")];
    __weak ContactListViewController *weakSelf = self;
    [[[EaseMob sharedInstance] chatManager] asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (error == nil) {
                [self.contactsSource removeAllObjects];
                [self.contactsSource addObjectsFromArray:buddyList];
                /// 在好友体系中加入自己
                //                NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
                //                NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
                //                if (loginUsername && loginUsername.length > 0) {
                //                    EMBuddy *loginBuddy = [EMBuddy buddyWithUsername:loginUsername];
                //                    [self.contactsSource addObject:loginBuddy];
                //                }
                
                [weakSelf _sortDataArray:self.contactsSource];
            }
            else{
                [weakSelf showHint:NSLocalizedString(@"loadDataFailed", @"Load data failed.")];
            }
            
            [weakSelf tableViewDidFinishTriggerHeader:YES reload:YES];
        });
    } onQueue:nil];
}

#pragma mark - public

- (void)reloadDataSource
{
    [self.dataArray removeAllObjects];
    [self.contactsSource removeAllObjects];
    
    NSArray *buddyList = [[EaseMob sharedInstance].chatManager buddyList];
    NSArray *blockList = [[EaseMob sharedInstance].chatManager blockedList];
    for (EMBuddy *buddy in buddyList) {
        if (![blockList containsObject:buddy.username]) {
            [self.contactsSource addObject:buddy];
        }
    }
    /// 在好友体系中加入自己
    //    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    //    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    //    if (loginUsername && loginUsername.length > 0) {
    //        EMBuddy *loginBuddy = [EMBuddy buddyWithUsername:loginUsername];
    //        [self.contactsSource addObject:loginBuddy];
    //    }
    
    NSMutableArray *kidsArr = [NSMutableArray array];
    for (EMBuddy *buddy  in buddyList) {
        if (![blockList containsObject:buddy.username]) {
            [kidsArr addObject:buddy.username];
        }
    }
    if (kidsArr.count != 0) {
        NSString *kids = [kidsArr componentsJoinedByString:@","];
        HttpUserKid *tools = [HttpUserKid sharedInstance];
        [tools userkidWithKids:kids viewController:self];
        
    }
    else{
        
        [self.sectionTitles removeAllObjects];
        [self.tableView reloadData];
        [self setupTableFooterView];
        [self.tableView addSubview:self.nullView];
        self.nullView.hidden = YES;
        [self setupNullImage];
        
    }
}
- (void)setupNullImage{
    
    if (self.dataArray.count == 0||!self.dataArray) {
        
        self.nullView.hidden = NO;
        
    }else{
        
        self.nullView.hidden = YES;
    }
}
- (XBNullView *)nullView{
    if (!_nullView) {
        _nullView = [[XBNullView alloc]initNullViewWithFrame:self.view.bounds andImage:[UIImage imageNamed:@"content_ico_fyk"] andDescription:@"你暂无饭友"];
        _nullView.desTextColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:102.0/255.0];
        _nullView.desTextFont = [UIFont systemFontOfSize:20];
        _nullView.backgroundColor = [UIColor clearColor];
        _nullView.imgCenterYGap = -100;
        self.nullView.hidden = YES;
    }
    _nullView.desLabel.text = @"你暂无饭友";
    _nullView.nullImgView.image = [UIImage imageNamed:@"content_ico_fyk"];
    return _nullView;
}
- (void)reloadApplyView
{
    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
    self.unapplyCount = count;
    [self.tableView reloadData];
    
}

- (void)reloadGroupView
{
    [self reloadApplyView];
    
    if (_groupController) {
        [_groupController reloadDataSource];
    }
}

- (void)addFriendAction
{
    AddFriendViewController *addController = [[AddFriendViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:addController animated:YES];
}

- (void)setupUntreatedApplyCount
{
    [self reloadApplyView];
    [self reloadDataSource];
}
#pragma mark - EMChatManagerBuddyDelegate
- (void)didUpdateBlockedList:(NSArray *)blockedList
{
    [self reloadDataSource];
}

#pragma mark -- 删除好友

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        EaseUserModel *model = [[self.dataArray objectAtIndex:(_deleteIndexPath.section - 1)] objectAtIndex:_deleteIndexPath.row];
        if ([model.nickname isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notDeleteSelf", @"can't delete self") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager removeBuddy:model.kid removeFromRemote:YES error:&error];
        if (!error) {
            [[EaseMob sharedInstance].chatManager removeConversationByChatter:model.kid deleteMessages:YES append2Chat:YES];
            
            [self.tableView beginUpdates];
            [[self.dataArray objectAtIndex:(_deleteIndexPath.section - 1)] removeObjectAtIndex:_deleteIndexPath.row];
            [self.contactsSource removeObject:model];
            [self.tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:_deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView  endUpdates];
        }
        else{
            [self showHint:[NSString stringWithFormat:NSLocalizedString(@"deleteFailed", @"Delete failed:%@"), error.description]];
            [self.tableView reloadData];
        }
        
    }
}
@end
