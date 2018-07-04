//
//  FDInformationViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInformationViewController.h"
#import "FDPersonalCenterCell.h"
#import "FDOrderStateCell.h"
#import "UINavigationBar+Awesome.h"
#import "UIImageView+WebCache.h"
#import "FDInfoCell.h"
#import "FDInputViewController.h"
#import "PhotoPickerViewController.h"
#import "FDConstellationView.h"
#import "FDInfoSecontion1Cell.h"
#import "FDUtils.h"
#import "FDEditInfoHeaderView.h"
#import "HttpUserEdit.h"
#import "AddressView.h"
#import "FDSexView.h"
#import "FDAgeView.h"
#import "UIPopoverListView.h"
#import "HttpUserIndustryCategory.h"
#import "FDInputMyDescViewController.h"

@interface FDInformationViewController ()<UIActionSheetDelegate,UIScrollViewDelegate>
{
    PhotoPickerViewController *photoPicker;
    CABasicAnimation *caAnimation;
}
@property (nonatomic ,weak) FDConstellationView *constellation;
@property (nonatomic ,strong) NSArray *titleArray;
@property (nonatomic ,strong) NSArray *imageArray;
@property (nonatomic ,strong) FDEditInfoHeaderView *editInfoHeaderView;
@property (nonatomic, strong) AddressView *addressView;
@property (nonatomic, strong) UIView *addressBgView;
@property (nonatomic ,weak) UIPopoverListView *popoverListView;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic,assign)NSInteger index;
@end

@implementation FDInformationViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y>200||scrollView.contentOffset.y<-64) {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        self.title = @"编辑资料";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
        [self.navigationController.navigationBar lt_reset];
    }else{
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}

- (UIView *)addressBgView{
    if (!_addressBgView) {
        _addressBgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-300, ScreenW, 300)];
        _addressBgView.backgroundColor = [UIColor whiteColor];
        
        UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 45)];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW-80, 0, 80, 45)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_addressBgView addSubview:cancleBtn];
        [_addressBgView addSubview:sureBtn];
        
        [_addressBgView addSubview:self.addressView];
    }
    return _addressBgView;

}

#pragma mark -- 取消选择家乡
- (void)cancleBtnClick{
    self.actionSheet.alpha = 0;
    [self.addressView removeFromSuperview];
    [self.addressBgView removeFromSuperview];
    self.addressBgView= nil;
    self.addressView= nil;
}
#pragma mark -- 确定选择家乡
- (void)sureBtnClick{
    self.actionSheet.alpha = 0;
    NSString *province =self.addressView.province;
    
    NSString *city =self.addressView.city;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    NSArray *provinceArray = [[NSArray alloc] initWithContentsOfFile:path];
//    self.selectedArray = provinceArray[row][@"cities"];
    NSInteger fix = 0;
    
    for (int i= 0; i<provinceArray.count; i++) {
        NSDictionary *cities = [provinceArray objectAtIndex:i];
//        NSLog(@"城市:%@",[cities objectForKey:@"state"]);
        if ([[cities objectForKey:@"state"] isEqualToString:province]) {
            NSArray *cityArr =[cities objectForKey:@"cities"];
            
            for (NSDictionary *city_ in cityArr) {
                if ([[city_ objectForKey:@"city"] isEqualToString:city]) {
                    fix++;
                    break;
                }
            }
            if (fix==0) {
                province =@"北京";
                city = @"通州";
            }
            
        }
    }
    

    [self.addressView removeFromSuperview];
    [self.addressBgView removeFromSuperview];
    self.addressBgView= nil;
    self.addressView= nil;
    HttpUserEdit *edit = [HttpUserEdit sharedInstance];
    NSString *cityStr = [NSString stringWithFormat:@"%@-%@",province,city];
    [edit loadUserEditWithIndex:10 content:cityStr];
}
- (AddressView *)addressView{

    if (!_addressView) {
        _addressView = [[AddressView alloc] init];
        _addressView.frame =CGRectMake(0,45, ScreenW, 255);
        _addressView.backgroundColor = [UIColor whiteColor];
    }
    return _addressView;
}
- (FDEditInfoHeaderView *)editInfoHeaderView{
    if (!_editInfoHeaderView) {
        _editInfoHeaderView = [FDEditInfoHeaderView editInfoHeaderView];
        _editInfoHeaderView.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*1.058);
    }
    return _editInfoHeaderView;

}
- (UIActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet = [[UIActionSheet alloc]init];
        
        _actionSheet.frame = [UIScreen mainScreen].bounds;
        _actionSheet.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_actionSheet];
        _actionSheet.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
        [_actionSheet addGestureRecognizer:tap];
    }
    return _actionSheet;
    
}

- (UIToolbar *)toolBar{
    if (_toolBar == nil) {
        self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _toolBar.barTintColor=[UIColor brownColor];
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
        _toolBar.items = @[item1, item2];
    }
    return _toolBar;
}

- (void)click{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    if (IPHONE4) {
        self.tableView.frame = CGRectMake(0, -64-([UIScreen mainScreen].bounds.size.width*1.058-304)-60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+[UIScreen mainScreen].bounds.size.width*1.058-304+60);
    }else if (IPHONE5) {
        self.tableView.frame = CGRectMake(0, -64-([UIScreen mainScreen].bounds.size.width*1.058-304)-60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+[UIScreen mainScreen].bounds.size.width*1.058-304+60);
    }else if(IPhone6){
        self.tableView.frame = CGRectMake(0, -64-([UIScreen mainScreen].bounds.size.width*1.058-304)-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+[UIScreen mainScreen].bounds.size.width*1.058-304+20);
    }else{
        self.tableView.frame = CGRectMake(0, -64-([UIScreen mainScreen].bounds.size.width*1.058-304), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+[UIScreen mainScreen].bounds.size.width*1.058-304);
    }
    
    self.tableView.separatorColor = [UIColor colorWithWhite:0 alpha:0.15];
    
    self.tableView.tableHeaderView = self.editInfoHeaderView;
    self.titleArray = @[@[@"头像",@"昵称",@"性别",@"描述"],
                        @[@"职业",@"公司",@"写字楼"],
                        @[@"年龄",@"星座",@"家乡"]];
    self.imageArray = @[@[@"baw_ico_touxiang_nor",@"baw_ico_nicheng_nor",@"baw_ico_xingbie_nor",@"baw_icon_miaoshu_nor"],
        @[@"baw_ico_zhiye_nor",@"baw_ico_gongsi_nor",@"baw_ico_lou_nor"],
        @[@"baw_ico_shengri_nor",@"baw_ico_xing_nor",@"baw_ico_jia_nor"]];

        
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadCellWithIndex:) name:reloadUserEdit object:nil];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.tableView.contentOffset.y>240) {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        self.title = @"编辑资料";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    }else{
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }

}
- (void)reloadCellWithIndex:(NSNotification *)no{
    [self setHeadPoint];
    if ([no.userInfo[@"index"] intValue]==1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    }
    if ([no.userInfo[@"index"] intValue]==1001 ||[no.userInfo[@"index"] intValue]==1002) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    if ([no.userInfo[@"index"] intValue]==123) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    }
    if ([no.userInfo[@"index"] intValue]>=10001 ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    
    if ([no.userInfo[@"index"] intValue]==10 ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:2];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    
    if ([no.userInfo[@"index"] intValue]==21 ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        NSArray *starArray=@[@{@"title":@"白羊座",@"image":@"constellation_0",@"date":@"03/21-04/19"},@{@"title":@"金牛座",@"image":@"constellation_1",@"date":@"04/20-05/20"},@{@"title":@"双子座",@"image":@"constellation_2",@"date":@"05/21-06/21"},@{@"title":@"巨蟹座",@"image":@"constellation_3",@"date":@"06/22-07/22"},@{@"title":@"狮子座",@"image":@"constellation_4",@"date":@"07/23-08/22"},@{@"title":@"处女座",@"image":@"constellation_5",@"date":@"08/23-09/22"},@{@"title":@"天秤座",@"image":@"constellation_6",@"date":@"09/23-10/23"},@{@"title":@"天蝎座",@"image":@"constellation_7",@"date":@"10/24-11/22"},@{@"title":@"射手座",@"image":@"constellation_8",@"date":@"11/23-12/21"},@{@"title":@"摩羯座",@"image":@"constellation_9",@"date":@"12/22-01/19"},@{@"title":@"水瓶座",@"image":@"constellation_10",@"date":@"01/20-02/18"},@{@"title":@"双鱼座",@"image":@"constellation_11",@"date":@"02/10-03/20"}];
        
        
        
        self.editInfoHeaderView.xingzuoText.text = [HQDefaultTool getConstellation];
        for (NSDictionary *dict in starArray) {
            if ([dict[@"title"] isEqualToString:[HQDefaultTool getConstellation]]) {
                [self.editInfoHeaderView.xingzuoBtn setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
            }
        }
        
    }
    if ([no.userInfo[@"index"] intValue]==2 ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    if ([no.userInfo[@"index"] intValue]==3 ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    if ([no.userInfo[@"index"]intValue]==200) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //导航栏设置成透明色后   还有根线  这句代码就是去线的
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    UIColor *color = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    caAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    caAnimation.toValue = @(M_PI*2);
    caAnimation.duration = 16.0;
    caAnimation.repeatCount = 1000;
    caAnimation.cumulative = YES;
    [self.editInfoHeaderView.rotatingView.layer addAnimation:caAnimation forKey:@"rotationAnimation"];
    
    [self setHeadPoint];
    
    if (self.tableView.contentOffset.y>240) {
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        self.title = @"编辑资料";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    }else{
        UIColor *color = [UIColor whiteColor];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }

    
}
- (void)setHeadPoint{
    if (![HQDefaultTool getAge]||[[HQDefaultTool getAge] isEqualToString:@""]) {
        self.editInfoHeaderView.ageText.text = [HQDefaultTool getAges_default];
    }else{
        self.editInfoHeaderView.ageText.text = [HQDefaultTool getAge];
    }
    
    NSArray *array = [[HQDefaultTool getHometown] componentsSeparatedByString:@"-"];
    if (array.count>=2) {
        self.editInfoHeaderView.provinceText.text = array[0];
        self.editInfoHeaderView.cityText.text = array[1] ;
        self.editInfoHeaderView.cityText.hidden = NO;
    }else{
        self.editInfoHeaderView.provinceText.text = [HQDefaultTool getHometown_default];
        self.editInfoHeaderView.cityText.hidden = YES;
        
    }
    
    
    if (![HQDefaultTool getConstellation]||[[HQDefaultTool getConstellation] isEqualToString:@""]) {
       self.editInfoHeaderView.xingzuoText.text = [HQDefaultTool getConstellation_default];
        [self.editInfoHeaderView.xingzuoBtn setImage:[UIImage imageNamed:@"grzx_ico_sexz"] forState:UIControlStateNormal];
        
    }else
    {
        
       NSArray *starArray=@[@{@"title":@"白羊座",@"image":@"constellation_0",@"date":@"03/21-04/19"},@{@"title":@"金牛座",@"image":@"constellation_1",@"date":@"04/20-05/20"},@{@"title":@"双子座",@"image":@"constellation_2",@"date":@"05/21-06/21"},@{@"title":@"巨蟹座",@"image":@"constellation_3",@"date":@"06/22-07/22"},@{@"title":@"狮子座",@"image":@"constellation_4",@"date":@"07/23-08/22"},@{@"title":@"处女座",@"image":@"constellation_5",@"date":@"08/23-09/22"},@{@"title":@"天秤座",@"image":@"constellation_6",@"date":@"09/23-10/23"},@{@"title":@"天蝎座",@"image":@"constellation_7",@"date":@"10/24-11/22"},@{@"title":@"射手座",@"image":@"constellation_8",@"date":@"11/23-12/21"},@{@"title":@"摩羯座",@"image":@"constellation_9",@"date":@"12/22-01/19"},@{@"title":@"水瓶座",@"image":@"constellation_10",@"date":@"01/20-02/18"},@{@"title":@"双鱼座",@"image":@"constellation_11",@"date":@"02/10-03/20"}];
        
        
        for (NSDictionary *dict in starArray) {
            if ([dict[@"title"] isEqualToString:[HQDefaultTool getConstellation]]) {
                [self.editInfoHeaderView.xingzuoBtn setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
                self.editInfoHeaderView.xingzuoText.text = [HQDefaultTool getConstellation];
                break;
            }else{
                self.editInfoHeaderView.xingzuoText.text = [HQDefaultTool getConstellation_default];
                [self.editInfoHeaderView.xingzuoBtn setImage:[UIImage imageNamed:@"grzx_ico_sexz"] forState:UIControlStateNormal];
            }
        }
        
        
    }
    

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //加这个方法防崩
    [self.navigationController.navigationBar lt_reset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 4;
    }
        return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 65;
    }else if (indexPath.section == 0&&indexPath.row == 3){
        CGRect rect = [[HQDefaultTool getSelf_desc] boundingRectWithSize:CGSizeMake(ScreenW - 122, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];

        return rect.size.height +36;
    
    }
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        FDInfoCell *cell = [FDInfoCell cellWithTableView:tableView];
   
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[HQDefaultTool getHead]] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            cell.headImage.image = image;
        }];

        
        cell.leftLabel.text = self.titleArray[indexPath.section][indexPath.row];
        cell.leftView.image = [UIImage imageNamed:@"baw_ico_touxiang_nor"];
        return cell;
        
    }else{
        FDInfoSecontion1Cell *cell = [FDInfoSecontion1Cell cellWithTableView:tableView];
        cell.miaoshu.hidden = YES;
        cell.rightText.hidden = NO;
        cell.titleImage.image =[UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
        cell.leftLabel.text = self.titleArray[indexPath.section][indexPath.row];
        if (indexPath.section == 0&&indexPath.row == 0) {
            cell.rightText.enabled = YES;
        }else{
            cell.rightText.enabled = NO;
        
        }

        if (indexPath.section==0&&indexPath.row==1) {
            cell.rightText.text = [HQDefaultTool getNickName];
        }else if (indexPath.section==0&&indexPath.row==2){
            cell.rightText.text = [HQDefaultTool getSex];
        }
        else if (indexPath.section==0&&indexPath.row==3){
            cell.miaoshu.text = [HQDefaultTool getSelf_desc];
            cell.rightText.hidden = YES;
            cell.miaoshu.hidden = NO;
            
            CGRect rect = [[HQDefaultTool getSelf_desc] boundingRectWithSize:CGSizeMake(ScreenW - 122, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            
            if (rect.size.height<20) {
                cell.miaoshu.textAlignment = NSTextAlignmentRight;
            }else{
                cell.miaoshu.textAlignment = NSTextAlignmentLeft;
            }
        }
        
        else if (indexPath.section==1&&indexPath.row==0){
            if ([[HQDefaultTool getOccupation] isEqualToString:@""]) {
                cell.rightText.placeholder = [HQDefaultTool getOccupation_hint];
            }else{
                cell.rightText.text = [NSString stringWithFormat:@"%@-%@",[HQDefaultTool getIndustry],[HQDefaultTool getOccupation]];
            }
            
        }else if (indexPath.section==1&&indexPath.row==1){
            if ([[HQDefaultTool getCompany] isEqualToString:@""]) {
                cell.rightText.placeholder = [HQDefaultTool getCompany_hint];
            }else{
                cell.rightText.text = [HQDefaultTool getCompany];
            }
            
        }else if (indexPath.section==1&&indexPath.row==2){
            cell.rightText.text = [HQDefaultTool getOffice_build];
        }else if (indexPath.section==2&&indexPath.row==0){
            if ([[HQDefaultTool getAge] isEqualToString:@""]) {
                cell.rightText.placeholder = [HQDefaultTool getAges_hint];
            }else{
                cell.rightText.text = [HQDefaultTool getAge];
            }
        }else if (indexPath.section==2&&indexPath.row==1){
            if ([[HQDefaultTool getConstellation] isEqualToString:@""]) {
                cell.rightText.placeholder = [HQDefaultTool getConstellation_hint];
            }else{
                cell.rightText.text = [HQDefaultTool getConstellation];
            }
           
        }else if (indexPath.section==2&&indexPath.row==2){
            if ([[HQDefaultTool getHometown] isEqualToString:@""]) {
                cell.rightText.placeholder = [HQDefaultTool getHometown_hint];
            }else{
                cell.rightText.text = [HQDefaultTool getHometown];
            }
          
        }
        return cell;
    }
    
    
    
}
- (void)sexBtnClick:(UIButton *)button{
    [self.popoverListView dismiss];
    if (button.tag==1001) {
        HttpUserEdit *userEdit = [HttpUserEdit sharedInstance];
        [userEdit loadUserEditWithIndex:button.tag content:@"男"];
    }else{
        HttpUserEdit *userEdit = [HttpUserEdit sharedInstance];
        [userEdit loadUserEditWithIndex:button.tag content:@"女"];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0&&indexPath.row == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
            [sheet showInView:self.view.window];

    }else if (indexPath.section==0&&indexPath.row==1) {
        FDInputViewController *input = [[FDInputViewController alloc] init];
        input.navtitle = @"我的昵称";
        input.attribute = @"输入你的昵称，字数不超过10个字";
        input.placehorder = @"我的昵称";
        input.content = [HQDefaultTool getNickName];
        input.index = 1;
        input.NumberCounts = 10;
        [self presentViewController:input animated:YES completion:nil];
 
    }else if (indexPath.section==0&&indexPath.row==3) {
        FDInputMyDescViewController *input = [[FDInputMyDescViewController alloc] init];
        input.navtitle = @"个人描述";
        input.placehorder = @"关于你自己的描述";
        input.content = [HQDefaultTool getSelf_desc];
        input.NumberCounts = 50;
        input.submitStr = @"确定";
        [self presentViewController:input animated:YES completion:nil];
        
    }
    else if (indexPath.section==0&&indexPath.row==2){
        /* 性别 **/
        CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 20.0f;
        CGFloat yHeight = 180.0f;
        CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
        UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        poplistview.listView.scrollEnabled = FALSE;
        poplistview.isTouchOverlayView = YES;
        [poplistview show];
        self.popoverListView = poplistview;
        self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
        FDSexView *payResult = [[[NSBundle mainBundle] loadNibNamed:@"FDSexView" owner:nil options:nil]lastObject];
        [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
        payResult.frame = self.popoverListView.bounds;
        payResult.manBtn.tag = 1001;
        payResult.womanBtn.tag = 1002;
        [payResult.manBtn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payResult.womanBtn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [poplistview addSubview:payResult];
        
    }else if (indexPath.section==1&&indexPath.row==0){//职业
        FDInfoSecontion1Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        HttpUserIndustryCategory *category = [HttpUserIndustryCategory sharedInstance];
        [category loadUserIndustryCategoryWithViewController:self];
        
        
    }else if (indexPath.section==1&&indexPath.row==1){
        FDInputViewController *input = [[FDInputViewController alloc] init];
        input.navtitle = @"我的公司";
        input.attribute = @"输入你所在的公司，字数不超过20个字";
        input.placehorder = @"我的公司";
        input.NumberCounts = 20;
        input.content = [HQDefaultTool getCompany];
        input.index = 2;
        [self presentViewController:input animated:YES completion:nil];
        
    }else if (indexPath.section==1&&indexPath.row==2){
        FDInputViewController *input = [[FDInputViewController alloc] init];
        input.navtitle = @"我的写字楼";
        input.attribute = @"输入你所在的写字楼，字数不超过20个字";
        input.placehorder = @"我的写字楼";
        input.content = [HQDefaultTool getOffice_build];
        input.NumberCounts = 20;
        input.index = 3;
        [self presentViewController:input animated:YES completion:nil];
        
    }else if (indexPath.section==2&&indexPath.row==1){

        self.actionSheet.alpha = 0.5;
        FDConstellationView *constellation = [[FDConstellationView alloc] init];
        if (IPHONE4||IPHONE5) {
            constellation.frame = CGRectMake(10,([UIScreen mainScreen].bounds.size.height-360)/2-64, [UIScreen mainScreen].bounds.size.width-20, 460);
        }else{
            constellation.frame = CGRectMake(20,([UIScreen mainScreen].bounds.size.height-360)/2-64, [UIScreen mainScreen].bounds.size.width-40, 460);
        }
        
        constellation.layer.cornerRadius = 5;
        constellation.layer.masksToBounds = YES;
        constellation.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:constellation];
        self.constellation  = constellation;
        
    }else if (indexPath.section==2&&indexPath.row==0){//年龄
        CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 20.0f;
        CGFloat yHeight = 250.0f;
        CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
        UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        poplistview.listView.scrollEnabled = FALSE;
        poplistview.isTouchOverlayView = YES;
        [poplistview show];
        self.popoverListView = poplistview;
        self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
        FDAgeView *payResult = [[[NSBundle mainBundle] loadNibNamed:@"FDAgeView" owner:nil options:nil]lastObject];
        [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
        payResult.frame = self.popoverListView.bounds;
        payResult.before60.tag = 10001;
        payResult.after60.tag = 10002;
        payResult.after70.tag = 10003;
        payResult.after80.tag = 10004;
        payResult.after85.tag = 10005;
        payResult.after90.tag = 10006;
        payResult.after95.tag = 10007;
        [payResult.before60 addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payResult.after60 addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payResult.after70 addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payResult.after80 addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payResult.after85 addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payResult.after90 addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payResult.after95 addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [poplistview addSubview:payResult];
        
    }else if (indexPath.section==2&&indexPath.row==2){
        self.actionSheet.alpha = 0.5;
        [[UIApplication sharedApplication].keyWindow addSubview:self.addressBgView];
    }
    
}
- (void)ageBtnClick:(UIButton *)button{
    [self.popoverListView dismiss];
    HttpUserEdit *userEdit = [HttpUserEdit sharedInstance];
    [userEdit loadUserEditWithIndex:button.tag content:button.titleLabel.text];
    
}
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,40,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,40,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,40,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,40,0,0)];
    }
}

- (void)coverClickIndex:(NSInteger)index title:(NSString *)star{

    self.actionSheet.alpha = 0;
    self.index = index;

    if (self.constellation) {
        [self.constellation removeFromSuperview];
    }
    if (self.addressBgView) {
        [self.addressView removeFromSuperview];
        [self.addressBgView removeFromSuperview];
        self.addressBgView= nil;
        self.addressView= nil;
    }
    HttpUserEdit *edit = [HttpUserEdit sharedInstance];
    [edit loadUserEditWithIndex:21 content:star];
    

}
- (void)coverClick{
    self.actionSheet.alpha = 0;
    if (self.constellation) {
        [self.constellation removeFromSuperview];
    }
    if (self.addressBgView) {
        [self.addressView removeFromSuperview];
        [self.addressBgView removeFromSuperview];
        self.addressBgView= nil;
        self.addressView= nil;
    }

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
                photoPicker = [[PhotoPickerViewController alloc] initWithDelegate:self IsCamera:YES IsEdit:YES];
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
                photoPicker = [[PhotoPickerViewController alloc]initWithDelegate:self IsCamera:NO IsEdit:YES];
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
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    FDInfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    photoPicker = nil;
    cell.headImage.image=image;
    [self upLoadClick];
}

-(void) PhotoPickerCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    photoPicker = nil;
}

#pragma mark - 图片上传
- (void)upLoadClick {
    
    HttpUserEdit *tool = [HttpUserEdit sharedInstance];
    [tool loadUpLoadClick:self];
}


@end
