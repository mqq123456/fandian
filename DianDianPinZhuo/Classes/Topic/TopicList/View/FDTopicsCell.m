//
//  FDTopicsCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicsCell.h"
#import "UIView+Extension.h"
#import "HQConst.h"
#import "FDTopicsFrame.h"
#import "FDTopics.h"
#import "UIImageView+WebCache.h"
#import "HWStatusPhotosView.h"
#import "FDUtils.h"
#import "FDHeadImageView.h"
#import "FDUserDetailViewController.h"
#import "MemberModel.h"
@interface FDTopicsCell ()

/** 已有人数 */
@property (nonatomic, weak) UILabel *yiyou;
/** 已有人数 */
@property (nonatomic, weak) UILabel *yiyou_people;
/** 人报名 */
@property (nonatomic, weak) UILabel *people_baomimg;
/** 剩余 */
@property (nonatomic, weak) UILabel *remaining;
/** 剩余人数 */
@property (nonatomic, weak) UILabel *remaining_people;
/** 个空位 */
@property (nonatomic, weak) UILabel *people_kongwei;
/** 已产生 */
@property (nonatomic, weak) UILabel *chan_sheng;
/** 讨论人数 */
@property (nonatomic, weak) UILabel *comment_people;
/** 条讨论 */
@property (nonatomic, weak) UILabel *tiao_pinglun;

/** point1 */
@property (nonatomic, weak) UILabel *point1;
/** point2 */
@property (nonatomic, weak) UILabel *point2;
/**	用户头像 */
@property (nonatomic, weak) FDHeadImageView *icon;
/** 正文 */
@property (nonatomic, weak) UIView *content_view;
/**	用户名 */
@property (nonatomic, weak) UILabel *user_name;
/**	用户属性 */
@property (nonatomic, weak) UILabel *user_detail;
/**	免费 */
@property (nonatomic, weak) UIImageView *free;
/** 标题 */
@property (nonatomic, weak) UILabel *title;
/** 距离 */
@property (nonatomic, weak) UILabel *distance;
/** 距离 */
@property (nonatomic, weak) UIImageView *distance_image;
/** 时间图 */
@property (nonatomic, weak) UIImageView *time_image;
/** 时间 */
@property (nonatomic, weak) UILabel *time;

/** 分割线 */
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIView *line1;


/** 跟随他 */
@property (nonatomic, weak) UIButton *follow_she;

@property (nonatomic, weak) UIButton *sex_age;
/**
 *  四个头像
 */
@property (nonatomic, weak) FDHeadImageView *user_head1;
@property (nonatomic, weak) FDHeadImageView *user_head2;
@property (nonatomic, weak) FDHeadImageView *user_head3;
@property (nonatomic, weak) FDHeadImageView *user_head4;
/** 底部view */
@property (nonatomic, weak) UIView *gap_view;

@property (nonatomic, weak) UILabel *end_tips;
@property (nonatomic, weak) UIView *left_line;
@property (nonatomic, weak) UIView *right_line;
@end

@implementation FDTopicsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FDTopicsCell";
    FDTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FDTopicsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
- (void)layoutSubviews{
    [super layoutSubviews];

}
/**
 * 初始化动态
 */
- (void)setupOriginal
{
    
    /** 顶部view */
    UIView *gap_view = [[UIView alloc] init];
    gap_view.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:0.8];
    [self.contentView addSubview:gap_view];
    self.gap_view = gap_view;
    
    /** 用户头像 */
    FDHeadImageView *icon = [[FDHeadImageView alloc] init];
    icon.layer.cornerRadius = 52/2;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    [icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    
    /** 发话题人 */
    UILabel *user_name = [[UILabel alloc] init];
    user_name.textColor = FDColor(51, 51, 51, 1);
    user_name.font = user_name_font;
    [self.contentView addSubview:user_name];
    self.user_name = user_name;
    
    /** 免费图  */
    UIImageView *free = [[UIImageView alloc] init];
    free.image = [UIImage imageNamed:@"bow_ico_mfbq"];
    free.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:free];
    self.free = free;
    
    /** 用户详情 */
    UILabel *user_detail = [[UILabel alloc] init];
    user_detail.textColor = FDColor(102, 102, 102, 1);
    user_detail.font = user_detail_font;
    [self.contentView addSubview:user_detail];
    self.user_detail = user_detail;
    
    /** 内容部分 */
    UIView *content_view = [[UIView alloc] init];
    content_view.backgroundColor = [FDUtils colorWithHexString:@"#f8f8fb"];
    content_view.layer.cornerRadius = 1;
    content_view.clipsToBounds = YES;
    [self.contentView addSubview:content_view];
    self.content_view = content_view;
    
    /** 标题 */
    UILabel *title = [[UILabel alloc] init];
    title.font = title_font;
    title.numberOfLines = 0;
    title.textColor = FDColor(51, 51, 51, 1);
    [self.contentView addSubview:title];
    self.title = title;
    
    /** 餐厅距离 */
    UILabel *distance = [[UILabel alloc] init];
    distance.font = user_detail_font;
    distance.textColor = FDColor(102, 102, 102, 1);
    [content_view addSubview:distance];
    self.distance = distance;
    
    /** 距离图  */
    UIImageView *distance_image = [[UIImageView alloc] init];
    distance_image.image = [UIImage imageNamed:@"baw_icon_dingweixiao_nor"];
    distance_image.contentMode = UIViewContentModeScaleAspectFill;
    [content_view addSubview:distance_image];
    self.distance_image = distance_image;
    
    /** 时间图  */
    UIImageView *time_image = [[UIImageView alloc] init];
    time_image.image = [UIImage imageNamed:@"baw_icon_shijianxiao_nor"];
    time_image.contentMode = UIViewContentModeScaleAspectFill;
    [content_view addSubview:time_image];
    self.time_image = time_image;
    
    /** 已有 */
    UILabel *time = [[UILabel alloc] init];
    time.font = user_detail_font;
    time.textColor = FDColor(102, 102, 102, 1);
    [content_view addSubview:time];
    self.time = time;
    
    /** 图片 */
    //    HWStatusPhotosView *image = [[HWStatusPhotosView alloc] init];
    //    [content_view addSubview:image];
    //    self.image = image;
    
    
    UIImageView *image = [[UIImageView alloc] init];
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.layer.cornerRadius = 1;
    image.layer.masksToBounds = YES;
    [self.contentView addSubview:image];
    self.image = image;
    
//    /** 分割线 */
//    UIView *line = [[UIView alloc] init];
//    
//    line.backgroundColor = [FDUtils colorWithHexString:@"#d9d9d9"];
//    [content_view addSubview:line];
//    self.line = line;
    
    /** 已有 */
    UILabel *yiyou = [[UILabel alloc] init];
    yiyou.font = bottonFont;
    yiyou.textColor = FDColor(153, 153, 153, 1);
    [self.contentView addSubview:yiyou];
    self.yiyou = yiyou;
    
    /** 已有人数 */
    UILabel *yiyou_people = [[UILabel alloc] init];
    yiyou_people.font = bottonFont;
    yiyou_people.textColor = FDColor(51, 51, 51, 1);
    [self.contentView addSubview:yiyou_people];
    self.yiyou_people = yiyou_people;
    
    /** 人预定 */
    UILabel *people_baomimg = [[UILabel alloc] init];
    people_baomimg.font = bottonFont;
    people_baomimg.textColor = FDColor(153, 153, 153, 1);
    [self.contentView addSubview:people_baomimg];
    self.people_baomimg = people_baomimg;
    
    /** 剩余 */
    UILabel *remaining = [[UILabel alloc] init];
    remaining.font = bottonFont;
    remaining.textColor = FDColor(153, 153, 153, 1);
    [self.contentView addSubview:remaining];
    self.remaining = remaining;
    
    /** 剩余人数 */
    UILabel *remaining_people = [[UILabel alloc] init];
    remaining_people.font = bottonFont;
    remaining_people.textAlignment = NSTextAlignmentCenter;
    remaining_people.textColor = FDColor(51, 51, 51, 1);
    [self.contentView addSubview:remaining_people];
    self.remaining_people = remaining_people;
    
    /** 个空位 */
    UILabel *people_kongwei = [[UILabel alloc] init];
    people_kongwei.font = bottonFont;
    people_kongwei.textColor = FDColor(153, 153, 153, 1);
    [self.contentView addSubview:people_kongwei];
    self.people_kongwei = people_kongwei;
    
    /** 单价 */
    UILabel *chan_sheng = [[UILabel alloc] init];
    chan_sheng.font = bottonFont;
    chan_sheng.textColor = FDColor(153, 153, 153, 1);
    [self.contentView addSubview:chan_sheng];
    self.chan_sheng = chan_sheng;
    
    /** 每人 */
    UILabel *point1 = [[UILabel alloc] init];
    point1.font = bottonFont;
    point1.textColor = FDColor(51, 51, 51, 1);
    point1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:point1];
    self.point1 = point1;
    
    
    /** 每人 */
    UILabel *point2 = [[UILabel alloc] init];
    point2.font = bottonFont;
    point2.textColor = FDColor(51, 51, 51, 1);
    point1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:point2];
    self.point2 = point2;
    
    /** 每人 */
    UILabel *comment_people = [[UILabel alloc] init];
    comment_people.font = bottonFont;
    comment_people.textColor = FDColor(51, 51, 51, 1);
    [self.contentView addSubview:comment_people];
    self.comment_people = comment_people;
    
    /** 每人 */
    UILabel *tiao_pinglun = [[UILabel alloc] init];
    tiao_pinglun.font = bottonFont;
    tiao_pinglun.textColor = FDColor(153, 153, 153, 1);
    [self.contentView addSubview:tiao_pinglun];
    self.tiao_pinglun = tiao_pinglun;
    
    /** 几人桌 */
    UIButton * follow_she = [UIButton buttonWithType:UIButtonTypeSystem];
    follow_she.backgroundColor = [FDUtils colorWithHexString:@"#f0355c"];
    follow_she.layer.cornerRadius = 10;
    follow_she.clipsToBounds = YES;
    [follow_she setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    follow_she.userInteractionEnabled = NO;
    follow_she.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:follow_she];
    self.follow_she  = follow_she;
    
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
    
    /** 加入话题用户头像 */
    FDHeadImageView *user_head1 = [[FDHeadImageView alloc] init];
    user_head1.layer.cornerRadius = FDTopicUsersIconWH/2;
    user_head1.layer.masksToBounds = YES;
    user_head1.contentMode = UIViewContentModeScaleAspectFill;
    user_head1.clipsToBounds = YES;
    [self.contentView addSubview:user_head1];
    self.user_head1 = user_head1;
    
    FDHeadImageView *user_head2 = [[FDHeadImageView alloc] init];
    user_head2.layer.cornerRadius = FDTopicUsersIconWH/2;
    user_head2.layer.masksToBounds = YES;
    user_head2.contentMode = UIViewContentModeScaleAspectFill;
    user_head2.clipsToBounds = YES;
    [self.contentView addSubview:user_head2];
    self.user_head2 = user_head2;
    
    FDHeadImageView *user_head3 = [[FDHeadImageView alloc] init];
    user_head3.layer.cornerRadius = FDTopicUsersIconWH/2;
    user_head3.layer.masksToBounds = YES;
    user_head3.contentMode = UIViewContentModeScaleAspectFill;
    user_head3.clipsToBounds = YES;
    [self.contentView addSubview:user_head3];
    self.user_head3 = user_head3;
    
    FDHeadImageView *user_head4 = [[FDHeadImageView alloc] init];
    user_head4.layer.cornerRadius = FDTopicUsersIconWH/2;
    user_head4.layer.masksToBounds = YES;
    user_head4.contentMode = UIViewContentModeScaleAspectFill;
    user_head4.clipsToBounds = YES;
    [self.contentView addSubview:user_head4];
    
    self.user_head4 = user_head4;
    
    /** 分割线 */
    UIView *line1 = [[UIView alloc] init];
    
    line1.backgroundColor = [FDUtils colorWithHexString:@"#CCCAD0"];
    [self.contentView addSubview:line1];
    self.line1 = line1;
    
    /** 每人 */
    UILabel *end_tips = [[UILabel alloc] init];
    end_tips.font = bottonFont;
    end_tips.textColor = FDColor(102, 102, 102, 1);
    end_tips.textAlignment = NSTextAlignmentCenter;
    end_tips.text = @"以下饭局已结束";
    [self.gap_view addSubview:end_tips];
    self.end_tips = end_tips;
    
    UIView *left_line = [[UIView alloc] init];
    left_line.backgroundColor = [FDUtils colorWithHexString:@"#CCCAD0"];
    [self.gap_view addSubview:left_line];
    self.left_line = left_line;
    
    UIView *right_line = [[UIView alloc] init];
    right_line.backgroundColor = [FDUtils colorWithHexString:@"#CCCAD0"];
    [self.gap_view addSubview:right_line];
    self.right_line = right_line;
    
    
    
}

- (void)setStatusFrame:(FDTopicsFrame *)statusFrame
{
    _statusFrame = statusFrame;
    _statusFrame.status = statusFrame.status;
    
    
    FDTopics *statusM = statusFrame.status;

//    [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.person_img] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.icon.image = image;
//    }];
    if ([statusM.person_img hasPrefix:@"http://image.fundot.com.cn/"]) {
        NSString *img;
        if (IPhone6Plus) {//52*3
            img = [NSString stringWithFormat:@"%@@156w",statusM.person_img];
        }else{
            img = [NSString stringWithFormat:@"%@@104w",statusM.person_img];
        }
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }else{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.person_img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }

    self.icon.kid = statusM.kid;
    /** 描述文字 */
    self.user_name.text = statusM.nickname;
    
    /** 餐厅名称 */
    
    if (statusM.occupation&&statusM.company&&![statusM.occupation isEqualToString:@""]&&![statusM.company isEqualToString:@""]) {
        self.user_detail.text = [NSString stringWithFormat:@"%@ - %@",statusM.company,statusM.occupation];
    }else{
        self.user_detail.text = [NSString stringWithFormat:@"%@%@",statusM.company,statusM.occupation];
    }
    if (statusM.is_free ==1) {//是否售完
        self.free.hidden = NO;
    }else{
        self.free.hidden = YES;
    }
    /** 特色 */
    

    self.title.text = statusM.content;
    
    if ([statusM.distance intValue]>1000) {
        self.distance.text = [NSString stringWithFormat:@"地点：%@ 距离你约%.1f公里",statusM.merchant_name,[statusM.distance floatValue]/1000];
    }else{
        self.distance.text =[NSString stringWithFormat:@"地点：%@ 距离你约%@米",statusM.merchant_name,statusM.distance];
    }
    
    self.time.text = [NSString stringWithFormat:@"时间：%@ %@",statusM.kdate_desc,statusM.meal_time];
    if (statusM.image) {
       
        [self.image sd_setImageWithURL:[NSURL URLWithString:statusM.image] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.image.image = image;
        }];
    }

    
    if (statusM.comment_num==0) {
        self.tiao_pinglun.text = @"";
        self.point2.text = @"";
        self.comment_people.text = @"";
    }else{
        self.tiao_pinglun.text = @"条讨论";
        self.point2.text = @"・";
        self.comment_people.text = [NSString stringWithFormat:@"%d",statusM.comment_num];
    }
    if (statusM.sheng_yu == 0) {
        self.remaining_people.text = @"";
        self.people_kongwei.text = @"人数已满";
    }else{
        self.remaining_people.text = [NSString stringWithFormat:@"%d",statusM.ordermeal_num];
        self.people_kongwei.text = @"人预订";
    }
    
    /** 几人桌 */
    if ([statusM.is_finished isEqualToString:@"1"]) {
        
        self.follow_she.backgroundColor = [FDUtils colorWithHexString:@"#bababa"];
    }else{
        self.follow_she.backgroundColor = [FDUtils colorWithHexString:@"#f0355c"];
        
    }
    if ([statusM.is_finished intValue]==1) {
        self.follow_she.hidden = NO;
    }else{
        self.follow_she.hidden = YES;
    }
    [self.follow_she setTitle:statusM.topic_keyword forState:UIControlStateNormal];
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
    
    if (statusM.users_img.count>=1) {
        MemberModel *model = statusM.users_img[0];
//        [self.user_head1 sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.user_head1.image = image;
//        }];
        if ([model.img hasPrefix:@"http://image.fundot.com.cn/"]) {
            NSString *img;
            if (IPhone6Plus) {//48*3
                img = [NSString stringWithFormat:@"%@@144w",model.img];
            }else{
                img = [NSString stringWithFormat:@"%@@96w",model.img];
            }
            
            [self.user_head1 sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head1.image = image;
            }];
        }else{
            [self.user_head1 sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head1.image = image;
            }];
        }

        _user_head1.kid= model.kid;
        [_user_head1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
        self.user_head1.hidden = NO;
        self.user_head2.hidden = YES;
        self.user_head3.hidden = YES;
        self.user_head4.hidden = YES;
    }
    if (statusM.users_img.count>=2) {
        MemberModel *model = statusM.users_img[1];
//        [self.user_head2 sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.user_head2.image = image;
//        }];
        if ([model.img hasPrefix:@"http://image.fundot.com.cn/"]) {
            NSString *img;
            if (IPhone6Plus) {//48*3
                img = [NSString stringWithFormat:@"%@@144w",model.img];
            }else{
                img = [NSString stringWithFormat:@"%@@96w",model.img];
            }
            
            [self.user_head2 sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head2.image = image;
            }];
        }else{
            [self.user_head2 sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head2.image = image;
            }];
        }

        _user_head2.kid= model.kid;
        self.user_head1.hidden = NO;
        self.user_head2.hidden = NO;
        self.user_head3.hidden = YES;
        self.user_head4.hidden = YES;
        [_user_head2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    }
    if (statusM.users_img.count>=3) {
        MemberModel *model = statusM.users_img[2];
//        [self.user_head3 sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.user_head3.image = image;
//        }];
        
        if ([model.img hasPrefix:@"http://image.fundot.com.cn/"]) {
            NSString *img;
            if (IPhone6Plus) {//48*3
                img = [NSString stringWithFormat:@"%@@144w",model.img];
            }else{
                img = [NSString stringWithFormat:@"%@@96w",model.img];
            }
            
            [self.user_head3 sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head3.image = image;
            }];
        }else{
            [self.user_head3 sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head3.image = image;
            }];
        }

        _user_head3.kid= model.kid;
        self.user_head1.hidden = NO;
        self.user_head2.hidden = NO;
        self.user_head3.hidden = NO;
        self.user_head4.hidden = YES;
        [_user_head3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    }
    if (statusM.users_img.count>=4) {
        MemberModel *model = statusM.users_img[3];
//        [self.user_head4 sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.user_head4.image = image;
//        }];
        if ([model.img hasPrefix:@"http://image.fundot.com.cn/"]) {
            NSString *img;
            if (IPhone6Plus) {//48*3
                img = [NSString stringWithFormat:@"%@@144w",model.img];
            }else{
                img = [NSString stringWithFormat:@"%@@96w",model.img];
            }
            
            [self.user_head4 sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head4.image = image;
            }];
        }else{
            [self.user_head4 sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head4.image = image;
            }];
        }
        _user_head4.kid= model.kid;
        self.user_head1.hidden = NO;
        self.user_head2.hidden = NO;
        self.user_head3.hidden = NO;
        self.user_head4.hidden = NO;
        [_user_head4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    }
    
    
    
    [self setupFrame];
    
}
- (void)setupFrame{
    self.icon.frame = self.statusFrame.iconF;
    self.content_view.frame = self.statusFrame.content_viewF;
    self.user_name.frame = self.statusFrame.user_nameF;
    self.user_detail.frame = self.statusFrame.user_detailF;
    self.free.frame = self.statusFrame.freeF;
    self.title.frame = self.statusFrame.titleF;
    self.distance.frame = self.statusFrame.distanceF;
    self.distance_image.frame = self.statusFrame.distance_imageF;
    self.time.frame = self.statusFrame.timeF;
    self.image.frame = self.statusFrame.imageF;
    self.line.frame = self.statusFrame.lineF;
    self.yiyou.frame = self.statusFrame.yiyouF;
    self.yiyou_people.frame = self.statusFrame.yiyou_peopleF;
    self.people_baomimg.frame = self.statusFrame.people_baomimgF;
    self.remaining.frame = self.statusFrame.remainingF;
    self.remaining_people.frame = self.statusFrame.remaining_peopleF;
    self.people_kongwei.frame = self.statusFrame.people_kongweiF;
    self.chan_sheng.frame = self.statusFrame.chan_shengF;
    self.comment_people.frame = self.statusFrame.comment_peopleF;
    self.tiao_pinglun.frame = self.statusFrame.tiao_pinglunF;
    self.follow_she.frame = self.statusFrame.follow_sheF;
    self.gap_view.frame = self.statusFrame.gap_viewF;
    self.point1.frame = self.statusFrame.point1F;
    self.point2.frame = self.statusFrame.point2F;
    self.line1.frame = self.statusFrame.line1F;
    
    self.sex_age.frame = self.statusFrame.sex_ageF;
    self.user_head1.frame = self.statusFrame.user_head1F;
    self.user_head2.frame = self.statusFrame.user_head2F;
    self.user_head3.frame = self.statusFrame.user_head3F;
    self.user_head4.frame = self.statusFrame.user_head4F;
    self.time_image.frame = self.statusFrame.time_imageF;
    
    self.end_tips.frame = self.statusFrame.end_tipsF;
    self.left_line.frame = self.statusFrame.left_lineF;
    self.right_line.frame = self.statusFrame.right_lineF;
    
}
- (void)user_headTapClick:(UITapGestureRecognizer *)tap{
    FDHeadImageView *imageView = (FDHeadImageView *)tap.view;
    FDUserDetailViewController *user  = [[FDUserDetailViewController alloc] init];
    user.kid = imageView.kid;
    [self.nav pushViewController:user animated:YES];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
