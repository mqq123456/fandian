//
//  FDSponsorTopicViewController.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSponsorTopicViewController.h"
#import "HJCActionSheet.h"
#import "FDTimeView.h"
#import "FDSponsorTopicContentCell.h"
#import "FDSponsorTopicSelectCell.h"
#import "PhotoPickerViewController.h"
#import "FDHomeViewController.h"
#import "QQWKImageScale.h"
#import "FDSponsorTopicHeaderCell.h"
#import "FDMerchantListViewController.h"

@interface FDSponsorTopicViewController ()<HJCActionSheetDelegate,FDTimeViewDelegate,UITextViewDelegate,UIActionSheetDelegate>
{
    PhotoPickerViewController *photoPicker;
    UIImage *_image;
    UIButton *makeTopic;
}


@property (nonatomic ,strong) NSMutableArray *peopleArray;
@property (nonatomic ,strong) NSMutableArray *kdatesArray;//开餐
@property (nonatomic ,strong) NSMutableArray *kdates;//开餐日期数组
@property (nonatomic ,strong) NSMutableArray *kdescs;//开餐日期描述
@property (nonatomic ,strong) NSMutableArray *ktimes;//开餐时间数组
@property (nonatomic ,strong) NSMutableArray *kmeal_ids;//开餐时间对应的id
@property (nonatomic ,strong) NSMutableArray *eatingDatesArray;//开餐日期数组


@end

@implementation FDSponsorTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTitleViewWithTitle:@"发起拼桌"];
    
    self.tableView.backgroundColor = Background_Color;
    _peopleArray = [NSMutableArray arrayWithObjects:@"1人",@"2人", nil];
    _people = @"1人";
    _img = @"";
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64-50);
    makeTopic = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenH-64-50, ScreenW, 50)];
    makeTopic.backgroundColor = [FDUtils colorWithHexString:@"#d3d3d3"];
    [makeTopic setTitle:@"下一步 选择餐厅" forState:UIControlStateNormal];
    [makeTopic setTitleColor:FDColor(51, 51, 51, 1) forState:UIControlStateNormal];
    makeTopic.enabled = NO;
    [makeTopic addTarget:self action:@selector(makeTopicBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeTopic];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    FDHomeViewController *home = self.navigationController.viewControllers.firstObject;
    
    
    self.kmeal_ids = [NSMutableArray arrayWithArray:home.kmeal_ids];
    self.kdescs = [NSMutableArray arrayWithArray:home.kdescs];
    self.ktimes = [NSMutableArray arrayWithArray:home.ktimes];
    self.kdates = [NSMutableArray arrayWithArray:home.kdates];
    self.best_select_index = home.best_select_index;
    self.time_select_index = home.best_select_index;
    
    
    self.meal_date = self.kdates[self.best_select_index-1];
    self.meal_id = self.kmeal_ids[self.best_select_index-1];
    self.meal_time = self.ktimes[self.best_select_index-1];
    self.kdate_desc = self.kdescs[self.best_select_index-1];
    self.eatingDatesArray = [NSMutableArray arrayWithArray:home.eatingDatesArray];
    [self.tableView reloadData];

    [self reloadBtn];
}
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///发起话题页流量
    [MobClick event:@"pv_posttopic"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)imageBtnClick{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    FDSponsorTopicContentCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.contentLabel resignFirstResponder];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:self.view.window];
    
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
    
    
    _image = image;
    self.img=[QQWKImageScale image2Data:image];
    
    [self.tableView reloadData];
    
}

-(void) PhotoPickerCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    photoPicker = nil;
}

#pragma mark -- 发起话题
- (void)keyboardWillHide{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    FDSponsorTopicContentCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.content = cell.contentLabel.text;
}
- (void)deleteBtnClick{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    FDSponsorTopicContentCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.content_Image setImage:[UIImage imageNamed:@"placeholder"] forState:UIControlStateNormal];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.img = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)makeTopicBtnClick{
 
    if (self.content.length>100) {
        [SVProgressHUD showImage:nil status:@"输入字数大于100"];
        return;
    }
    FDMerchantListViewController *list = [[FDMerchantListViewController alloc] init];
    
    list.latString = [HQDefaultTool getLat];
    list.lngString = [HQDefaultTool getLng];
    list.local_lat = [HQDefaultTool getLat];
    list.local_lng = [HQDefaultTool getLng];
    list.kdate = self.meal_date;
    list.meal_id = self.meal_id;
    list.local = 1;
    list.is_bz = 0;
    list.peopleNum = [NSString stringWithFormat:@"%d",[self.people intValue]];
    list.people_desc = self.people;
    list.kdate = self.meal_date;
    list.meal_time = self.meal_time;
    list.kdate_desc = self.kdate_desc;
    list.menu_id = self.menu_id;
    list.meal_id = self.meal_id;
    list.img = self.img;
    list.content = self.content;
    [self.navigationController pushViewController:list animated:YES];


}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2&&indexPath.row==0) {
        HJCActionSheet *action = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@[@"1人",@"2人"]];
        action.tag = 999;
        [action show];
    }
    if (indexPath.section ==2 &&indexPath.row==1) {
        
        // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
        UIButton *sender;
        FDTimeView *sheet = [[FDTimeView alloc] initWithDelegate:self  index:3 OtherTitles:self.eatingDatesArray sender:sender selectedIndex:self.time_select_index best_select_index:self.best_select_index];
        
        // 2.显示出来
        [sheet show];
    }

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section ==0){
        return 1;
        
    }
    if (section==1) {
        return 1;
    }
    return 2;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [self reloadBtn];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FDSponsorTopicHeaderCell *cell = [FDSponsorTopicHeaderCell cellWithTableView:tableView];
        return cell;
    }
    if (indexPath.section == 1) {
        
        FDSponsorTopicContentCell *cell = [FDSponsorTopicContentCell cellWithTableView:tableView];
        cell.contentLabel.placeholder = self.default_topic_title;
        cell.contentLabel.text = self.content;
        cell.contentLabel.delegate = self;
        [cell.content_Image addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        if (![self.img isEqualToString:@""]) {
            [cell.content_Image setImage:_image forState:UIControlStateNormal];
        }
       
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        if ([self.img isEqualToString:@""]) {
            cell.deleteBtn.hidden = YES;
        }else{
            cell.deleteBtn.hidden = NO;
        }
        
        return cell;
    }else{
        NSArray *titlearray = @[@"选择人数",@"选择时间"];
        NSArray *imageArray = @[@"baw_icon_renshu_nor",@"baw_icon_time_nor"];
        FDSponsorTopicSelectCell *cell = [FDSponsorTopicSelectCell cellWithTableView:tableView];
        
        if (indexPath.row==0) {
            
            cell.detail.text =[NSString stringWithFormat:@"%@",_people];
            if ([_people isEqualToString:@""]) {
                cell.detail.text = @"请选择人数";
            }
            cell.desc.text = @"一人即可成行，带上同事也不错";
        }
        if (indexPath.row==1) {
            cell.detail.text =[NSString stringWithFormat:@"%@ %@",_kdate_desc,_meal_time];
            cell.desc.text = @"请提前一小时发布话题，方便饭友跟单";
            
        }
        cell.title.text = titlearray[indexPath.row];
        cell.left_icon.image = [UIImage imageNamed:imageArray[indexPath.row]];
        
        return cell;
        
    }
    
    
}
- (void)reloadBtn{
    
    if (![_people isEqualToString:@""]) {
        makeTopic.backgroundColor = [FDUtils colorWithHexString:@"#ef2840"];
        [makeTopic setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        makeTopic.enabled = YES;
    }else{
        makeTopic.backgroundColor = [FDUtils colorWithHexString:@"#d3d3d3"];
        [makeTopic setTitleColor:FDColor(51, 51, 51, 1) forState:UIControlStateNormal];
        makeTopic.enabled = NO;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return ScreenW*0.15333;
    }else if (indexPath.section==1){
        return 240;
    }
    return 80;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0001;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}




- (void)actionSheet:(HJCActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==999) {
        _people = _peopleArray[buttonIndex-1];
        [self reloadBtn];
        [self.tableView reloadData];
    }
    
}

- (void)timeViewSheet:(FDTimeView *)timeViewSheet index:(NSInteger)index clickedButtonAtIndex:(NSInteger)buttonIndex sender:(UIButton *)sender title:(NSArray *)array{
    if (buttonIndex <_best_select_index) {
        
        [SVProgressHUD showImage:nil status:@"订餐时间已过"];
        return;
    }
    
    NSArray *arr = [[array objectAtIndex:buttonIndex-1] componentsSeparatedByString:@" "];
    
    if (arr.count==4) {
        _meal_date = [arr objectAtIndex:3];
        _meal_id = [arr objectAtIndex:2];
        _meal_time = [arr objectAtIndex:1];
        _kdate_desc = [arr objectAtIndex:0];
    }

    [sender setTitle:[NSString stringWithFormat:@"开餐时间：%@ %@",arr[0],arr[1]] forState:UIControlStateNormal];
    _time_select_index = buttonIndex;
  
    [self.tableView reloadData];
    
}

@end
