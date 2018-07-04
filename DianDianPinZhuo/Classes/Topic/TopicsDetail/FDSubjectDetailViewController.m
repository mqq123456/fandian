//
//  FDSubjectDetailViewController.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSubjectDetailViewController.h"
#import "FDSubjectDetail_BottomView.h"
#import "FDSubjectDetail_DateDetail_cell.h"
#import "FDSubjectDetail_TopUserCell.h"
#import "FDSubjectUsers_View.h"
#import "FDSubject_Users_cell.h"
#import "FDSubjectDetail_content_cell.h"
#import "HttpTopicDetail.h"
#import "TopicCommentModel.h"
#import "NSString+Urldecode.h"
#import "HQTextView.h"
#import "IQKeyboardManager.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "FDMerchantDetailController.h"
#import "MemberModel.h"
#import "FDUserDetailViewController.h"
#import "FDTopicCommentCell.h"
#import "FDTopicCommentFrame.h"
#import "HttpTopicComment.h"
#import "FDMerchantIntroductionViewController.h"
#import "FDTopicDetailEmptyCell.h"
#import "HJCActionSheet.h"
#import "FDTopicDetailFreeCell.h"
#import "ButtonsView.h"
#import "UIPopoverListView.h"
#import "FDSubmitOrderViewController.h"
#import "SeatsModel.h"
#import "FDLoginViewController.h"
#import "HttpTopicJoin.h"
#import "HttpTopicCommentDelete.h"
#import "FDShareView.h"
#import "FDUsersCell.h"
#import "FDUsersFrame.h"
#import "FDTopicDetailSection1HeadView.h"


@interface FDSubjectDetailViewController ()<SubjectUsers_ViewDelegate,UITextViewDelegate,HJCActionSheetDelegate,ButtonsViewDelegate,UIAlertViewDelegate>
{
    int index;
}
@property (nonatomic, strong)FDSubjectDetail_BottomView *bottomView;
@property (weak, nonatomic) HQTextView * textView;
@property (weak, nonatomic) UIView * text_view;
@property (nonatomic ,strong)UIActionSheet * actionSheet;

@property (nonatomic ,strong) UIPopoverListView *popoverListView;
@property (nonatomic ,assign) int comment_count;
@property (nonatomic ,strong) FDShareView *shareView;
@end

@implementation FDSubjectDetailViewController

- (FDShareView *)shareView{
    if (_shareView==nil) {
        _shareView = [FDShareView shareView];
        _shareView.type = @"5";
        _shareView.delegate = self;
    }
    
    _shareView.umURL = self.model.weixin_topic_url;
    _shareView.title = self.model.weixin_topic_title;
    _shareView.contText = self.model.weixin_topic_content;
    _shareView.group_share_title = self.model.weixin_topic_title;
    _shareView.topic_id = self.model.topic_id;
    _shareView.group_share_hint = @"立即查看";
    
    _shareView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    return _shareView;
}
#pragma mark -
- (FDSubjectDetail_BottomView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [FDSubjectDetail_BottomView subjectDetail_BottomView];
        _bottomView.frame = CGRectMake(0, ScreenH-60-40, ScreenW, 60);
        [_bottomView.replayBtn addTarget:self action:@selector(replayBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.joininBtn addTarget:self action:@selector(joininBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        view.backgroundColor = FDColor(233, 233, 233, 1);
        [_bottomView addSubview:view];
        
    }
    
    return _bottomView;
}

- (UIActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet = [[UIActionSheet alloc]init];
        
        _actionSheet.frame = [UIScreen mainScreen].bounds;
        _actionSheet.backgroundColor = [UIColor blackColor];
        [self.navigationController.view addSubview:_actionSheet];
        _actionSheet.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
        [_actionSheet addGestureRecognizer:tap];
    }
    return _actionSheet;
    
}
- (void)coverClick{
    self.actionSheet.alpha  =0;
    [self.textView resignFirstResponder];
}
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///话题详情流量
    [MobClick event:@"pv_topicdetail"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    
    if (!self.fromHtml5) {
        UIView *text_view = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
        text_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.text_view = text_view;
        HQTextView *textView = [[HQTextView alloc] init];
        textView.frame = CGRectMake(5, 3, [UIScreen mainScreen].bounds.size.width-10, 34);
        textView.delegate = self;
        textView.layer.borderWidth = 0.5;
        textView.layer.borderColor = FDColor(153, 153, 153,1).CGColor;
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = [UIFont systemFontOfSize:15];
        textView.returnKeyType = UIReturnKeyDone;
        textView.placeholder = @"我也聊两句";
        textView.layer.cornerRadius = 3;
        self.textView = textView;
        [text_view addSubview:textView];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.text_view];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.text_view];
    }
    _comment_count= 0;
    
    if (!self.share) {
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn setTitleColor:[FDUtils colorWithHexString:@"#222222"] forState:UIControlStateNormal];
        shareBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
        
    }
    
}
- (void)presentToLoginViewController{
    FDLoginViewController *verification = [[FDLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
    [self presentViewController:nav animated:YES completion:nil];

}
- (void)shareClick{
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {//登录
        [self presentToLoginViewController];
        return;
        
    }else{

    [self.navigationController.view addSubview:self.shareView];
        
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.actionSheet.alpha = 0.0;
    [self.textView removeFromSuperview];
    [self.text_view removeFromSuperview];
    self.text_view = nil;
    self.textView = nil;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [self.guideView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(joinSuccess) name:joinSuccess object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(joinFailed:) name:joinFailed object:nil];
    
    self.title = @"话题详情";
    [self.view addSubview:self.bottomView];
    self.commentArray = [NSMutableArray array];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64-60);
    self.tableView.backgroundColor = FDColor(242, 242, 242, 1);
    [self loadTopicDetail];
    _kid = @"";
    UIImageView *endImageView = [[UIImageView alloc] init];
    endImageView.image = [UIImage imageNamed:@"bow_ico_yijieshubq"];
    endImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-72, 15, 72, 85.5);
    self.endImageView = endImageView;
    endImageView.hidden = YES;
    
    [self.tableView addSubview:endImageView];
    
}
- (void)loadTopicDetail{
    HttpTopicDetail *detail = [HttpTopicDetail sharedInstance];
    [detail loadWithTopic_id:self.model.topic_id controller:self];
}
- (void)commentBackAndLoadTopicDetail{
    HttpTopicDetail *detail = [HttpTopicDetail sharedInstance];
    [detail commentBackAndLoadWithTopic_id:self.model.topic_id controller:self];
}
- (void)commentDeleteBackAndLoadTopicDetail{
    HttpTopicDetail *detail = [HttpTopicDetail sharedInstance];
    [detail commentDeleteBackAndLoadWithTopic_id:self.model.topic_id controller:self];
}
#pragma mark - 评论
- (void)commentContentClick:(UITapGestureRecognizer *)tap{
    
    FDTopicCommentFrame *frame = self.commentArray[tap.view.tag];
    
    TopicCommentModel *model = frame.status;
    
    self.kid = model.kid;
    
    
    self.actionSheet.alpha  =0.5;
    
    [_textView becomeFirstResponder];
}

#pragma mark --  回复
- (void)replayBtnClick{
    if ([[HQDefaultTool getKid]isEqualToString:@""]) {
        
        [self presentToLoginViewController];
        return;
    }
    if (!self.text_view) {
        ///回复
        [MobClick event:@"click_topicdetail_comment"];
        UIView *text_view = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
        text_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.text_view = text_view;
        HQTextView *textView = [[HQTextView alloc] init];
        textView.frame = CGRectMake(5, 3, [UIScreen mainScreen].bounds.size.width-10, 34);
        textView.delegate = self;
        textView.layer.borderWidth = 0.5;
        textView.layer.borderColor = FDColor(153, 153, 153,1).CGColor;
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = [UIFont systemFontOfSize:15];
        textView.returnKeyType = UIReturnKeyDone;
        textView.placeholder = @"我也聊两句";
        textView.layer.cornerRadius = 3;
        self.textView = textView;
        [text_view addSubview:textView];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.text_view];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.text_view];
    }
    
    self.actionSheet.alpha  =0.5;
    
    [_textView becomeFirstResponder];
}
#pragma mark --  我要加入
- (void)joininBtnClick{
    if ([[HQDefaultTool getKid]isEqualToString:@""]) {
        
        [self presentToLoginViewController];
        return;
    }
    if (!self.meal_id) {
        [SVProgressHUD showImage:nil status:@"数据获取失败，请返回重试"];
        return;
    }
    if ([self.is_order intValue]==1) {
        [SVProgressHUD showImage:nil status:@"已结束"];
        return;
    }
    
    HttpTopicJoin *join = [HttpTopicJoin sharedInstance];
    [join loadWithTopicJoin:self.model.topic_id andPeople:self.model.free_people controller:self];
    
}
- (void)joinFailed:(NSNotification *)noti{
    NSString *title = (NSString *)noti.object;
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}
- (void)joinSuccess{
    
    if (self.model.is_free ==1) {
        
        FDSubmitOrderViewController *submit = [[FDSubmitOrderViewController alloc] init];
        submit.merchant_id=[NSString stringWithFormat:@"%d",self.merchant.merchant_id];
        submit.merchant_name =self.merchant.merchant_name;
        submit.icon =self.merchant.icon;
        submit.kdate =self.kdate;
        submit.kdate_desc = self.kdate_desc;
        submit.meal_time = self.meal_time;
        submit.price = [NSString stringWithFormat:@"%@",self.merchant.price];
        self.peopleNum = [NSString stringWithFormat:@"%d",[self.model.free_people intValue]];
        submit.people_desc = [NSString stringWithFormat:@"%@人",self.peopleNum];
        submit.people = [NSString stringWithFormat:@"%@",self.peopleNum];
        submit.meal_id = self.meal_id;
        submit.menu_id = self.menu_id;
        submit.topic_id = self.model.topic_id;
        submit.initial_topic = @"0";
        submit.is_bz = @"0";
        
        [self.navigationController pushViewController:submit animated:YES];
        
        
        
    }else{
        if ([self.left_seat intValue]==0) {
            [SVProgressHUD showImage:nil status:@"人数已满，请选择其他话题"];
            return;
        }
        ButtonsView *buttonsView = [[ButtonsView alloc] initWithDelegate:self selectedIndex:1 OtherTitles:self.seats viewTag:0 num:4 frame:CGRectMake(0,0, ScreenW-30, 0) people_hint:@""];
        buttonsView.tag= 101;
        buttonsView.userInteractionEnabled = YES;
        CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 30.0f;
        CGFloat yHeight = buttonsView.size.height;
        [buttonsView addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
        CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
        
        UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(15, yOffset, xWidth, yHeight)];
        poplistview.listView.scrollEnabled = FALSE;
        poplistview.isTouchOverlayView = YES;
        [poplistview show];
        self.popoverListView = poplistview;
        self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
        [poplistview addSubview:buttonsView];
    }
    
}

#pragma mark - 选择人数
- (void)buttonsView:(ButtonsView *)buttonsView clickedButtonAtIndex:(NSInteger)buttonIndex sender:(UIButton *)sender title:(NSArray *)array{
    
    if (buttonsView.tag==101) {
        [self.popoverListView dismiss];
        FDSubmitOrderViewController *submit = [[FDSubmitOrderViewController alloc] init];
        submit.merchant_id=[NSString stringWithFormat:@"%d",self.merchant.merchant_id];
        submit.merchant_name =self.merchant.merchant_name;
        submit.icon =self.merchant.icon;
        submit.kdate =self.kdate;
        submit.kdate_desc = self.kdate_desc;
        submit.meal_time = self.meal_time;
        submit.price = [NSString stringWithFormat:@"%@",self.merchant.price];
        submit.meal_id = self.meal_id;
        submit.menu_id = self.menu_id;
        SeatsModel *model = self.seats[buttonIndex];
        submit.people_desc = model.seat_desc;
        submit.people = [NSString stringWithFormat:@"%@",model.seat_num];
        submit.topic_id = self.model.topic_id;
        submit.initial_topic = @"0";
        submit.is_bz = @"0";
        [self.navigationController pushViewController:submit animated:YES];
    }else{

        
    }
    
    
}


#pragma mark -- tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section==1) {
        return 56;
    }
    return 11;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 0.001;
    }
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }else{
        if (self.commentArray.count==0) {
            return 1;
        }
        return self.commentArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0&&indexPath.row == 0) {
        FDSubjectDetail_TopUserCell *cell = [FDSubjectDetail_TopUserCell cellWithTableView:tableView];
        [cell.subject_icon sd_setImageWithURL:[NSURL URLWithString:self.model.person_img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            cell.subject_icon.image = image;
        }];
        cell.subject_icon.kid = self.model.kid;
        [cell.subject_icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick:)]];
        
        cell.subject_name.text = self.model.nickname;
        cell.subject_occpution.text = self.model.nickname_desc;
        if (self.model.is_free ==1) {
            cell.subject_free.hidden = NO;
        }else{
            cell.subject_free.hidden = YES;
        }
        return cell;
    }else if (indexPath.section == 0&&indexPath.row == 1){
        
        FDSubjectDetail_content_cell *cell = [FDSubjectDetail_content_cell cellWithTableView:tableView ];
        cell.content_label.text = self.model.content;
        cell.content_imageView.contentMode = UIViewContentModeScaleToFill;
        if (!self.model.image||[self.model.image isEqualToString:@""]) {
            cell.content_imageViewW.constant = 0;
            cell.content_imageViewH.constant = 0;
            [cell.content_imageView layoutIfNeeded];
        }else{
            
            [cell.content_imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                cell.content_imageView.image = image;
                CGSize imageSize = image.size;
                if (imageSize.width >= imageSize.height) {
                    ///宽大于高
                    
                    cell.content_imageViewH.constant = 180;
                    if (180*imageSize.width/imageSize.height>ScreenW - 40) {
                        cell.content_imageViewW.constant = ScreenW - 40;
                    }else{
                        
                        cell.content_imageViewW.constant =180*imageSize.width/imageSize.height;
                    }
                    
                }else{
                    ///高大于宽
                    cell.content_imageViewH.constant = 180;
                    cell.content_imageViewW.constant =180*imageSize.width/imageSize.height;
                }
                
                [cell.content_imageView layoutIfNeeded];
            }];
            cell.content_imageView.userInteractionEnabled = YES;
            cell.content_imageView.contentMode = UIViewContentModeScaleAspectFill;
            cell.content_imageView.layer.masksToBounds = YES;
            [cell.content_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
        }
        return cell;
        
        
    }else if (indexPath.section == 0&& indexPath.row == 2){
        if (self.model.is_free ==1) {
            ///免费的话题
            FDTopicDetailFreeCell *cell = [FDTopicDetailFreeCell cellWithTableView:tableView];
            
            cell.merchant_name.text = self.merchant.merchant_name;
            cell.star.show_star = [self.merchant.star intValue];
            if (!self.model.kdate_desc) {
                cell.time.text = [NSString stringWithFormat:@"%@ %@",self.kdate_desc,self.model.meal_time];
                cell.price.text = [NSString stringWithFormat:@"%@",self.model.free_price];
            }
            
            cell.only_people.text = self.model.seat_desc;
            return cell;
        }else{
            FDSubjectDetail_DateDetail_cell *cell = [FDSubjectDetail_DateDetail_cell cellWithTableView:tableView];
            if (self.kdate_desc!=nil) {
                cell.time.text = [NSString stringWithFormat:@"%@",self.model.meal_time];
                cell.kdate_desc.text = self.kdate_desc;
                cell.price.text = [NSString stringWithFormat:@"%@",self.merchant.price];
            }
           
            cell.distance.text = self.merchant.distance;
            cell.dateDetail_merchantName.text = self.merchant.merchant_name;
            cell.dateDetail_star.show_star = [self.merchant.star intValue];
            
            return cell;
        }
        
    }
    
    else if (indexPath.section == 0&& indexPath.row == 3){
        if (self.usersFrame.status == 0) {
            return [[UITableViewCell alloc]init];
        }else{

            FDUsersCell *cell = [FDUsersCell cellWithTableView:tableView];
            cell.usersFrame = self.usersFrame;
            return cell;
        }
        
    }
    
    else{
        if (self.commentArray.count==0) {
            FDTopicDetailEmptyCell *cell = [FDTopicDetailEmptyCell cellWithTableView:tableView];
            cell.userInteractionEnabled = NO;
            return cell;
        }else{
            FDTopicCommentCell *cell = [FDTopicCommentCell cellWithTableView:tableView];
            cell.statusFrame = self.commentArray[indexPath.row];
            cell.content_view.tag = indexPath.row;
            [cell.icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick:)]];
            
            return cell;
            
        }
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==2&&indexPath.section==0) {
        FDMerchantIntroductionViewController *detail = [[FDMerchantIntroductionViewController alloc] init];
        detail.latString = [HQDefaultTool getLat];
        detail.lngString = [HQDefaultTool getLng];
        detail.local_lat = [HQDefaultTool getLat];
        detail.local_lng = [HQDefaultTool getLng];
        detail.local = [NSString stringWithFormat:@"%d",self.local];
        detail.model = self.merchant;
        detail.is_bz = @"0";
        detail.is_introduction = YES;
        detail.meal_id = self.meal_id;
        detail.meal_time = self.meal_time;
        detail.kdate = self.kdate;
        detail.kdate_desc = self.kdate_desc;
        detail.menu_id = self.menu_id;
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    if (indexPath.section==1) {
        if ([[HQDefaultTool getKid]isEqualToString:@""]) {
            
            [self presentToLoginViewController];
            return;
        }
        NSArray *array = @[@"回复"];
        FDTopicCommentFrame *frame = self.commentArray[indexPath.row];
        TopicCommentModel *model = frame.status;
        if ([model.kid isEqualToString:[HQDefaultTool getKid]]) {
            array = @[@"删除"];
        }
        HJCActionSheet *action = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:array];
        index = (int)indexPath.row;
        [action show];
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        FDTopicDetailSection1HeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"FDTopicDetailSection1HeadView" owner:nil options:nil]lastObject];
        if (self.commentArray.count == 0) {
            view.commentCount.text=@"";
            view.commentDesc.text =@"暂无讨论";
        }else{
        
            view.commentCount.text = [NSString stringWithFormat:@"%zd",self.commentArray.count];
            view.commentDesc.text =@"条讨论";
        }
        return view;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 11)];
    view.backgroundColor = [FDUtils colorWithHexString:@"#f2f2f2"];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 70;
    }else if (indexPath.section ==0 && indexPath.row ==1){
        if (!self.model.image||[self.model.image isEqualToString:@""]) {
            CGRect  titleRect = [self.model.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
            return 16+titleRect.size.height;
        }else{
            CGRect  titleRect = [self.model.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
            return 180+16*2+titleRect.size.height;
        }
        
    }else if (indexPath.section == 0 &&indexPath.row == 2){
        return 122;
    }else if (indexPath.section == 0 &&indexPath.row == 3){
   
        return  self.usersFrame.cellHeight;
        
    }
    
    if (self.commentArray.count==0) {
        return 220;
    }else{
        FDTopicCommentFrame *frame = self.commentArray[indexPath.row];
        return frame.cellHeight;
    }
    
    
}
- (void)headImageClick:(UITapGestureRecognizer *)tap{
    FDHeadImageView *head = (FDHeadImageView *)tap.view;
    FDUserDetailViewController *userDetail = [[FDUserDetailViewController alloc] init];
    userDetail.kid = head.kid;
    [self.navigationController pushViewController:userDetail animated:YES];
}
- (void)imageClick:(UITapGestureRecognizer *)tap{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.hideDeleteBtn = YES;
    //        // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    NSArray *array = @[self.model.image];
    int count = (int)array.count;
    for (int i = 0; i<count; i++) {
        //StatusPhoto *pic = self.photos[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:array[i]];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = (UIImageView *)tap.view;
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = 0;
    
    // 3.显示浏览器
    [browser show];
    
    
}
- (void)actionSheet:(HJCActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    
    FDTopicCommentFrame *frame = self.commentArray[index];
    
    TopicCommentModel *model = frame.status;
    
    if ([model.kid isEqualToString:[HQDefaultTool getKid]]) {
        //评论删除
        
        HttpTopicCommentDelete *delete = [HttpTopicCommentDelete sharedInstance];
        [delete loadTopicCommentDeleteWithController:self comment_id:model.comment_id];
        return;
    }
    
    
    self.kid = model.kid;
    if (!self.text_view) {
        UIView *text_view = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
        text_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.text_view = text_view;
        HQTextView *textView = [[HQTextView alloc] init];
        textView.frame = CGRectMake(5, 3, [UIScreen mainScreen].bounds.size.width-10, 34);
        textView.delegate = self;
        textView.layer.borderWidth = 0.5;
        textView.layer.borderColor = FDColor(51, 51, 51,1).CGColor;
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = [UIFont systemFontOfSize:15];
        textView.returnKeyType = UIReturnKeyDone;
        textView.placeholder = @"我也聊两句";
        textView.layer.cornerRadius = 3;
        self.textView = textView;
        [text_view addSubview:textView];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.text_view];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.text_view];
    }
    
    self.actionSheet.alpha  =0.5;
    
    [_textView becomeFirstResponder];
}



#pragma mark textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        
        
        if ([textView.text isEqualToString:@""]) {
            [SVProgressHUD showImage:nil status:@"回复内容不能为空"];
            return NO;
        }else{
            [textView resignFirstResponder];
            self.actionSheet.alpha = 0;
            HttpTopicComment *comment = [HttpTopicComment sharedInstance];
            [comment loadTopicCommentWithReply_kid:self.kid topic_id:self.model.topic_id content:textView.text controller:self];
            self.textView.text = @"";
            return NO;
        }
        
    }
    return YES;
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
#pragma mark - keyboardNotification
- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    self.text_view.y = self.view.height+64 ;
    
}
- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    
    NSDictionary *userInfo = notification.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]-0.5;
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.text_view.y = self.view.height - self.text_view.height;//
            
        } else {
            _text_view.y = self.view.height - keyboardF.size.height+24;
            
            if (iOS7) {
                
                if (_comment_count
                    !=0) {
                    _text_view.y = self.view.height- keyboardF.size.height+4;
                }
                _comment_count++;
                
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
