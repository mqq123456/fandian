
//
//  FDEvaluationViewController.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDEvaluationViewController.h"
#import "FDEvaluationCell1.h"
#import "FDEvaluationCell4.h"
#import "FDEvaluationCell2.h"
#import "FDEvaluationCell3.h"
#import "RequestModel.h"
#import "UsedCommentModel.h"
#import "HttpMerchantComment.h"
#import "HttpMerchantCommonComment.h"
#import "HttpUserOrderDetail.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialData.h"
#import "PhotoPickerViewController.h"

#import "ApiParseBaseImageUpload.h"
#import "ReqBaseImageUploadModel.h"
#import "RespBaseImageUploadModel.h"
#import "HQHttpTool.h"
#import "QQWKImageScale.h"
#import "FDEvaluationSuccessView.h"
#import "FDShareView.h"

@interface FDEvaluationViewController ()<UITextViewDelegate,UMSocialUIDelegate,UIActionSheetDelegate>
{
    NSString *star_count;
    NSMutableArray *_cc_idArray;
    NSMutableArray *questionArray;
    PhotoPickerViewController *photoPicker;
    NSMutableArray *img_idArray;
    NSMutableArray *imgArray;
}
@property (nonatomic ,copy) NSString *img;
@property (nonatomic ,strong) FDShareView *shareView;
@property (nonatomic ,assign) NSInteger nav_count;
@end

@implementation FDEvaluationViewController
- (FDShareView *)shareView{
    if (_shareView==nil) {
        _shareView = [FDShareView shareView];
        _shareView.type = @"8";
        _shareView.delegate = self;
    }
    
    _shareView.umURL = @"";
    _shareView.title = @"评论分享";
    _shareView.contText = @"评论分享";
    _shareView.group_share_title = @"评论分享";
    _shareView.group_share_hint = @"立即查看";
    
    _shareView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    return _shareView;
}
#pragma mark 红包视图
- (FDEvaluationSuccessView *)bonusView{
    if (_bonusView == nil) {
        _bonusView = [FDEvaluationSuccessView selfEvaluationSuccessView];
        _bonusView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    }
    return _bonusView;
    
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ///评价流量
    [MobClick event:@"pv_comment"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _cc_idArray = [[NSMutableArray alloc]init];
    questionArray = [[NSMutableArray alloc]init];
    imgArray = [NSMutableArray array];
    img_idArray = [NSMutableArray array];
    _star1 = [NSMutableArray array];
    _star2 = [NSMutableArray array];
    _star3 = [NSMutableArray array];
    _star4 = [NSMutableArray array];
    _star5 = [NSMutableArray array];
    
    star_count = @"0";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64);
    
    [self addTitleViewWithTitle:@"餐厅评价"];
    
    
    
    //接受点击star
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectStarCount:) name:@"star" object:nil];
    
    [self loadMerchantCommonComment:nil];
    
    
    
    if (self.order_no) {
        [self loadOrderDetail];
    }
    self.nav_count = [NSMutableArray arrayWithArray:self.navigationController.viewControllers].count;
}
- (void)sendTo_weixin_Click{
    [self.bonusView removeFromSuperview];
    [self.navigationController.view addSubview:self.shareView];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    if (navigationarray.count!=self.nav_count) {
        for (int i=0; i<navigationarray.count; i++){
            if ([navigationarray[i] isKindOfClass:[self class]]) {
                [navigationarray removeObjectAtIndex:i];
                self.navigationController.viewControllers = navigationarray;
            }
        }
    }
   
}

- (void)bonus_NO_Click{
    [self.bonusView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadOrderDetail{
    HttpUserOrderDetail *detail = [HttpUserOrderDetail sharedInstance];
    [detail userDetailWithEnvaluation:self];
    
}
- (void)loadMerchantCommonComment:(NSString *)star{
    
    HttpMerchantCommonComment *comment = [HttpMerchantCommonComment sharedInstance];
    [comment commentWithViewController:self];
    
    
}


- (void)selectStarCount:(NSNotification *)no{
    [self.view endEditing:YES];
    [questionArray removeAllObjects];
    star_count = no.userInfo[@"star"];
    [_cc_idArray removeAllObjects];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}


#pragma mark - UITableViewDeletate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            if (IPHONE4) {
                return 70;
            }else if (IPhone6){
                return 90;
            }else if (IPhone6Plus){
                return 100;
            }else{
                return 80;
            }
        }
            break;
        case 1:{
            if (IPhone6) {
                return 130;
            }else if (IPhone6Plus){
                return 140;
            }
            else{
                return 110;
            }
        }
            
            break;
        case 2:{
            if (IPhone6||IPhone6Plus) {
                return 140;
            }else{
                return 130;
            }
        }
            
            break;
        case 3:
            if (IPHONE4) {
                return 270;
            }else if (IPhone6){
                return 270;
            }else if (IPhone6Plus){
                return 290;
            }else{
                return 270;
            }
            break;
        default:
            return 0;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        FDEvaluationCell1 *cell=[FDEvaluationCell1 cellWithTableView:tableView];
        [cell.merchant_Icon sd_setImageWithURL:[NSURL URLWithString:self.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            cell.merchant_Icon.image = image;
        }];
        
        
        cell.merchant_name.text = self.merchant_name;
        cell.creat_time.text = self.creat_time;
        return cell;
    }else if(indexPath.section == 1){
        
        FDEvaluationCell2 *cell=[FDEvaluationCell2 cellWithTableView:tableView];
        cell.star.show_star = [star_count integerValue];
        return cell;
    }else if(indexPath.section == 2){
        
        FDEvaluationCell3 *cell=[FDEvaluationCell3 cellWithTableView:tableView];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        switch ([star_count integerValue]) {
                
            case 0:
                array = _star5;
                cell.titleLabel.text = @"请给你喜欢的餐饮一点鼓励";
                break;
            case 1:
                array = _star1;
                cell.titleLabel.text = @"请把你的不满告诉我们";
                break;
                
            case 2:
                array = _star2;
                cell.titleLabel.text = @"请把你的不满告诉我们";
                break;
                
            case 3:
                array = _star3;
                cell.titleLabel.text = @"请把你的不满告诉我们";
                break;
                
                
            case 4:
                array = _star4;
                cell.titleLabel.text = @"请监督餐厅是否存在以下问题";
                break;
                
            case 5:
                array = _star5;
                cell.titleLabel.text = @"请给你喜欢的餐饮一点鼓励";
                break;
                
            default:
                break;
        }
        
        
        
        
        for (int i=0; i<array.count; i++) {
            UsedCommentModel *model = array[i];
            
            if (i==0) {
                
                [cell.environmentBtn setTitle:model.content forState:UIControlStateNormal];
                cell.environmentBtn.tag = [model.cc_id intValue];
                
                
            }
            if (i==1) {
                
                [cell.speetBtn setTitle:model.content forState:UIControlStateNormal];
                cell.speetBtn.tag = [model.cc_id intValue];
                
                
            }
            if (i==2) {
                
                [cell.diffentBtn setTitle:model.content forState:UIControlStateNormal];
                cell.diffentBtn.tag = [model.cc_id intValue];
                
                
            }
            if (i==3) {
                
                [cell.healthBtn setTitle:model.content forState:UIControlStateNormal];
                cell.healthBtn.tag = [model.cc_id intValue];
                
                
            }
            
            
            [cell.environmentBtn addTarget:self action:@selector(cell3BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.diffentBtn addTarget:self action:@selector(cell3BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.healthBtn addTarget:self action:@selector(cell3BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.speetBtn addTarget:self action:@selector(cell3BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
        
    }else{
        
        FDEvaluationCell4 *cell=[FDEvaluationCell4 cellWithTableView:tableView];
        cell.proposalTextView.placeholder =@"其他意见或建议";
        [cell.submitBtn addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.imgBtn1 addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.imgBtn2 addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.imgBtn3 addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.cancelBtn1 addTarget:self action:@selector(cancleBtn1Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.cancelBtn2 addTarget:self action:@selector(cancleBtn2Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.cancelBtn3 addTarget:self action:@selector(cancleBtn3Click) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
}
- (void)imgBtnClick{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:self.view.window];

}
- (void)cancleBtn1Click{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
    FDEvaluationCell4 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.imgBtn2.hidden = YES;
    [cell.imgBtn1 setImage:[UIImage imageNamed:@"bow_ico_pszp"] forState:UIControlStateNormal];
    cell.cancelBtn1.hidden = YES;
    [img_idArray removeLastObject];
    [imgArray removeLastObject];
    
}
- (void)cancleBtn2Click{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
    FDEvaluationCell4 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.imgBtn3.hidden = YES;
    [cell.imgBtn2 setImage:[UIImage imageNamed:@"bow_ico_pszp"] forState:UIControlStateNormal];
    cell.cancelBtn2.hidden = YES;
    cell.cancelBtn1.hidden = NO;
    [img_idArray removeLastObject];
    [imgArray removeLastObject];
}
- (void)cancleBtn3Click{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
    FDEvaluationCell4 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.imgBtn3 setImage:[UIImage imageNamed:@"bow_ico_pszp"] forState:UIControlStateNormal];
    cell.cancelBtn3.hidden = YES;
    cell.cancelBtn2.hidden = NO;
    [img_idArray removeLastObject];
    [imgArray removeLastObject];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
}
#pragma mark - btnClick
- (void)cell3BtnClick:(UIButton *)sender{
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    if ([questionArray containsObject:sender.titleLabel.text]) {
        
    }else{
        
        [questionArray addObject:sender.titleLabel.text];
    }
    
    MQQLog(@"%@",sender.titleLabel.text);
    if (sender.selected ==NO) {
        sender.backgroundColor = [UIColor whiteColor];
        [sender setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
        [_cc_idArray removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }else{
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [FDUtils colorWithHexString:@"#f33d5f"];
        [_cc_idArray addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
    
    
}
#pragma mark - 评价
- (void)commentClick{
    if ([star_count integerValue]== 0) {
        [SVProgressHUD showImage:nil status:@"请对你要评价的餐厅打分"];
        return;
    }
    ///点击提交
    
    NSString *question=@"";
    
    if (questionArray.count == 0||!questionArray) {
        
        question = @"";
        
        
    }else{
        
        question = [questionArray componentsJoinedByString:@","];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    FDEvaluationCell4 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    ///点击提交
    [MobClick event:@"click_comment_submit" attributes:@{@"star" :star_count ,@"question" : question} ];
    
    NSString *ccids;
    if (!(_cc_idArray.count == 0)) {
        ccids = [_cc_idArray componentsJoinedByString:@","];
    }
    NSString *imgs_ids;
    if (!(img_idArray.count == 0)) {
        imgs_ids = [img_idArray componentsJoinedByString:@","];
    }
    HttpMerchantComment *comment = [HttpMerchantComment sharedInstance];
    [comment merchantCommentWithMerchant_id:[self.merchant_id intValue] content:cell.proposalTextView.text star:[star_count intValue] cc_ids:ccids viewController:self order_no:self.order_no imgs:imgs_ids];
    
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            if (!photoPicker)
            {
                photoPicker = [[PhotoPickerViewController alloc] initWithDelegate:self IsCamera:YES IsEdit:NO];
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:photoPicker];
                nav.navigationBar.hidden=YES;
                [self presentViewController:nav animated:YES completion:nil];
            }
        }
            break;
        case 1:
        {
            if (!photoPicker)
            {
                photoPicker = [[PhotoPickerViewController alloc]initWithDelegate:self IsCamera:NO IsEdit:NO];
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:photoPicker];
                nav.navigationBar.hidden=YES;
                [self presentViewController:nav animated:YES completion:nil];
            }
        }
            break;
        default:break;
    }
    
}
#pragma mark - PhotoPickerDelegate
- (void)didFinishPickingWithImage:(UIImage *)image isFromCamera:(BOOL)isFromCamera
{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    photoPicker = nil;
    self.img=[QQWKImageScale image2Data:image];
    [imgArray addObject:image];
    [self upLoadClick];
}

-(void) PhotoPickerCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    photoPicker = nil;
}

#pragma mark - 图片上传
- (void)upLoadClick {
    [SVProgressHUD showWithStatus:@"图片上传中，请勿离开"];
    
    ReqBaseImageUploadModel *reqModel=[[ReqBaseImageUploadModel alloc]init];
    reqModel.img = self.img;
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseBaseImageUpload *request=[[ApiParseBaseImageUpload alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespBaseImageUploadModel *paseData=[request parseData:json];
        if ([paseData.code intValue]==1) {
            [img_idArray addObject:[NSString stringWithFormat:@"%d",paseData.pic_id]];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
            FDEvaluationCell4 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            for (int i = 0; i<img_idArray.count; i++) {
                if (i==0) {
                    [cell.imgBtn1 setImage:imgArray[i] forState:UIControlStateNormal];
                    cell.cancelBtn1.hidden = NO;
                    cell.imgBtn2.hidden = NO;
                }
                if (i==1) {
                    [cell.imgBtn2 setImage:imgArray[i] forState:UIControlStateNormal];
                    cell.cancelBtn2.hidden = NO;
                    cell.imgBtn3.hidden = NO;
                    cell.cancelBtn1.hidden = YES;
                }
                if (i==2) {
                    [cell.imgBtn3 setImage:imgArray[i] forState:UIControlStateNormal];
                    cell.cancelBtn3.hidden = NO;
                    cell.cancelBtn1.hidden = YES;
                    cell.cancelBtn2.hidden = YES;
                }
            }
//            if (img_idArray.count==1) {
//                cell.cancelBtn1.hidden = NO;
//                cell.imgBtn2.hidden = NO;
//            }
//            if (img_idArray.count==2) {
//                cell.cancelBtn2.hidden = NO;
//                cell.imgBtn3.hidden = NO;
//            }
//            if (img_idArray.count==2) {
//                cell.cancelBtn3.hidden = NO;
//            }
        }else{
            [imgArray removeLastObject];
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [imgArray removeLastObject];
        [SVProgressHUD dismiss];
        MQQLog(@"errer = %@",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
}


@end
