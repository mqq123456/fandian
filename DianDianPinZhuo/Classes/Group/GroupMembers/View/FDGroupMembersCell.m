//
//  FDGroupMembersCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDGroupMembersCell.h"
#import "UIView+Extension.h"
#import "HQConst.h"
#import "FDGroupMembersFrame.h"
#import "GroupMembersModel.h"
#import "UIImageView+WebCache.h"
#import "FDUtils.h"
#import "FDHeadImageView.h"
#import "FDUserDetailViewController.h"
@interface FDGroupMembersCell ()

@property (nonatomic, weak) FDHeadImageView *icon;
/**	用户名 */
@property (nonatomic, weak) UILabel *user_name;
/**	用户属性 */
@property (nonatomic, weak) UILabel *user_detail;
/** 已有人数 */
@property (nonatomic, weak) UILabel *address;
/** 距离 */
@property (nonatomic, weak) UIImageView *address_image;

@property (nonatomic, weak) UIButton *sex_age;



@end

@implementation FDGroupMembersCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FDGroupMembersCell";
    FDGroupMembersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FDGroupMembersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化动态
        [self setupOriginal];
    }
    return self;
}
/**
 * 初始化动态
 */
- (void)setupOriginal
{
    
    /** 用户头像 */
    FDHeadImageView *icon = [[FDHeadImageView alloc] init];
    icon.layer.cornerRadius = FDTopicUsersIconWH/2;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    icon.userInteractionEnabled = NO;
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    
    /** 发话题人 */
    UILabel *user_name = [[UILabel alloc] init];
    user_name.textColor = [FDUtils colorWithHexString:@"#222222"];
    user_name.font = user_name_font;
    [self.contentView addSubview:user_name];
    self.user_name = user_name;
    

    /** 用户详情 */
    UILabel *user_detail = [[UILabel alloc] init];
    user_detail.textColor = [FDUtils colorWithHexString:@"#666666"];
    user_detail.font = user_detail_font;
    [self.contentView addSubview:user_detail];
    self.user_detail = user_detail;
    

    
    /** 餐厅距离 */
    UILabel *address = [[UILabel alloc] init];
    address.font = address_font;
    address.textColor = [FDUtils colorWithHexString:@"#999999"];
    [self.contentView addSubview:address];
    self.address = address;
    
    /** 距离图  */
    UIImageView *address_image = [[UIImageView alloc] init];
    address_image.image = [UIImage imageNamed:@"baw_icon_dingweixiao_nor"];
    address_image.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:address_image];
    self.address_image = address_image;
    

    
    /** 年龄和性别标签 */
    UIButton * sex_age = [UIButton buttonWithType:UIButtonTypeCustom];
    sex_age.layer.cornerRadius = 2;
    sex_age.clipsToBounds = YES;
    [sex_age setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sex_age.userInteractionEnabled = NO;
    sex_age.titleLabel.font = sex_age_font;
    [self.contentView addSubview:sex_age];
    sex_age.titleEdgeInsets = UIEdgeInsetsMake(0, 1.5, 0, 0);
    sex_age.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 1.5);
    self.sex_age  = sex_age;
 
    
}

- (void)setStatusFrame:(FDGroupMembersFrame *)statusFrame
{
    _statusFrame = statusFrame;
    _statusFrame.status = statusFrame.status;
    [self setupFrame];
    
    
    GroupMembersModel *statusM = statusFrame.status;
    
    /** 图片 */
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.icon.image = image;
//    }];
    if ([statusM.icon hasPrefix:@"http://image.fundot.com.cn/"]) {
        NSString *img;
        if (IPhone6Plus) {//76*3
            img = [NSString stringWithFormat:@"%@@228w",statusM.icon];
        }else{
            img = [NSString stringWithFormat:@"%@@152w",statusM.icon];
        }
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }else{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }

    self.icon.kid = statusM.kid;
    /** 描述文字 */
    self.user_name.text = statusM.nick_name;
    
    /** 餐厅名称 */
    if (statusM.occupation&&statusM.company&&![statusM.occupation isEqualToString:@""]&&![statusM.company isEqualToString:@""]) {
        self.user_detail.text = [NSString stringWithFormat:@"%@ - %@",statusM.company,statusM.occupation];
    }else{
        self.user_detail.text = [NSString stringWithFormat:@"%@%@",statusM.company,statusM.occupation];
    }
    if ([statusM.sex intValue]==1) {//男
        self.sex_age.backgroundColor = [FDUtils colorWithHexString:@"#4bcde4"];
        [self.sex_age setImage:[UIImage imageNamed:@"bow_ico_nanxingtubiao_nor"] forState:UIControlStateNormal];
    }else if ([statusM.sex intValue]==2){
        self.sex_age.backgroundColor = [FDUtils colorWithHexString:@"#f86581"];
        [self.sex_age setImage:[UIImage imageNamed:@"bow_ico_nvxingtubiao_nor"] forState:UIControlStateNormal];
        
    }else{
        self.sex_age.backgroundColor = [FDUtils colorWithHexString:@"#4bcde4"];
        [self.sex_age setImage:[UIImage new] forState:UIControlStateNormal];
    }
    
    if (statusM.age&&![statusM.age isEqualToString:@""]) {
        [self.sex_age setTitle:statusM.age forState:UIControlStateNormal];
        
    }else{
        [self.sex_age setTitle:@"" forState:UIControlStateNormal];
    }
    
    self.address.text = statusM.office_build;
}

- (void)setupFrame{
    self.icon.frame = self.statusFrame.iconF;
    self.address.frame = self.statusFrame.addressF;
    self.address_image.frame = self.statusFrame.address_imageF;
    self.user_name.frame = self.statusFrame.user_nameF;
    self.user_detail.frame = self.statusFrame.user_detailF;
    self.sex_age.frame = self.statusFrame.sex_ageF;
}
- (void)user_headTapClick:(UITapGestureRecognizer *)tap{
    FDHeadImageView *imageView = (FDHeadImageView *)tap.view;
    FDUserDetailViewController *user  = [[FDUserDetailViewController alloc] init];
    user.kid = imageView.kid;
    [self.nav pushViewController:user animated:YES];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
