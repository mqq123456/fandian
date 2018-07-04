//
//  FDNotJoinGroupsCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDNotJoinGroupsCell.h"
#import "FDHeadImageView.h"
#import "UIView+Extension.h"
#import "HQConst.h"
#import "FDNotJoinGroupsFrame.h"
#import "UIImageView+WebCache.h"
#import "FDUtils.h"
#import "FDUserDetailViewController.h"
#import "NotJoinGroupModel.h"
#import "ActiveUserModel.h"

@interface FDNotJoinGroupsCell ()



@property (nonatomic, weak) FDHeadImageView *icon;
/** 正文 */
@property (nonatomic, weak) UIView *content_view;
/**	用户名 */
@property (nonatomic, weak) UILabel *user_name;
/**	用户属性 */
@property (nonatomic, weak) UILabel *user_detail;
/** 已有人数 */
@property (nonatomic, weak) UILabel *active;
/** 标题 */
@property (nonatomic, weak) UILabel *title;
/** 分割线 */
@property (nonatomic, weak) UIView *line1;
/** 跟随他 */
@property (nonatomic, weak) UIButton *follow_she;

/**
 *  四个头像
 */
@property (nonatomic, weak) FDHeadImageView *user_head1;
@property (nonatomic, weak) FDHeadImageView *user_head2;
@property (nonatomic, weak) FDHeadImageView *user_head3;
@property (nonatomic, weak) FDHeadImageView *user_head4;
/** 底部view */
@property (nonatomic, weak) UIView *gap_view;


@end
@implementation FDNotJoinGroupsCell



+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FDNotJoinGroupsCell";
    FDNotJoinGroupsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FDNotJoinGroupsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    /** 顶部view */
    UIView *gap_view = [[UIView alloc] init];
    gap_view.backgroundColor = Background_Color;
    [self.contentView addSubview:gap_view];
    self.gap_view = gap_view;
    
    /** 用户头像 */
    FDHeadImageView *icon = [[FDHeadImageView alloc] init];
    icon.layer.cornerRadius = 3;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
//    [icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    
    /** 发话题人 */
    UILabel *user_name = [[UILabel alloc] init];
    user_name.textColor = [FDUtils colorWithHexString:@"#222222"];
    user_name.font = name_font;
    [self.contentView addSubview:user_name];
    self.user_name = user_name;
   
    /** 用户详情 */
    UILabel *user_detail = [[UILabel alloc] init];
    user_detail.textColor = FDColor(102, 102, 102, 1);
    user_detail.font = user_detail_font;
    [self.contentView addSubview:user_detail];
    self.user_detail = user_detail;
    
    /** 内容部分 */
    UIView *content_view = [[UIView alloc] init];
    content_view.backgroundColor = [FDUtils colorWithHexString:@"#f8f8fb"];
    content_view.layer.cornerRadius = 3;
    content_view.clipsToBounds = YES;
    [self.contentView addSubview:content_view];
    self.content_view = content_view;
    
    /** 标题 */
    UILabel *title = [[UILabel alloc] init];
    title.font = titlefont;
    title.numberOfLines = 0;
    title.textColor = [FDUtils colorWithHexString:@"#666666"];
    [content_view addSubview:title];
    self.title = title;
    
    /** 标题 */
    UILabel *active = [[UILabel alloc] init];
    active.font = active_font;
    active.numberOfLines = 0;
    active.textColor = [FDUtils colorWithHexString:@"#222222"];
    [self.contentView addSubview:active];
    self.active = active;
    
   
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
    
    
    /** 加入话题用户头像 */
    FDHeadImageView *user_head1 = [[FDHeadImageView alloc] init];
    user_head1.layer.cornerRadius = TopicUsersIconWH/2;
    user_head1.layer.masksToBounds = YES;
    user_head1.contentMode = UIViewContentModeScaleAspectFill;
    user_head1.clipsToBounds = YES;
    [self.contentView addSubview:user_head1];
    [user_head1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    self.user_head1 = user_head1;
    
    FDHeadImageView *user_head2 = [[FDHeadImageView alloc] init];
    user_head2.layer.cornerRadius = TopicUsersIconWH/2;
    user_head2.layer.masksToBounds = YES;
    user_head2.contentMode = UIViewContentModeScaleAspectFill;
    user_head2.clipsToBounds = YES;
    [self.contentView addSubview:user_head2];
    [user_head2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    self.user_head2 = user_head2;
    
    FDHeadImageView *user_head3 = [[FDHeadImageView alloc] init];
    user_head3.layer.cornerRadius = TopicUsersIconWH/2;
    user_head3.layer.masksToBounds = YES;
    user_head3.contentMode = UIViewContentModeScaleAspectFill;
    user_head3.clipsToBounds = YES;
    [self.contentView addSubview:user_head3];
    [user_head3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    self.user_head3 = user_head3;
    
    FDHeadImageView *user_head4 = [[FDHeadImageView alloc] init];
    user_head4.layer.cornerRadius = TopicUsersIconWH/2;
    user_head4.layer.masksToBounds = YES;
    user_head4.contentMode = UIViewContentModeScaleAspectFill;
    user_head4.clipsToBounds = YES;
    [user_head4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
    [self.contentView addSubview:user_head4];
    
    self.user_head4 = user_head4;
    
    /** 分割线 */
    UIView *line1 = [[UIView alloc] init];
    
    line1.backgroundColor = [FDUtils colorWithHexString:@"#d9d9d9"];
    [self.contentView addSubview:line1];
    self.line1 = line1;
    
    
    
    
}

- (void)setStatusFrame:(FDNotJoinGroupsFrame *)statusFrame
{
    _statusFrame = statusFrame;
    _statusFrame.status = statusFrame.status;
    NotJoinGroupModel *statusM = statusFrame.status;
    [self setupFrame];
    
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.icon.image = image;
//    }];
    if ([statusM.icon hasPrefix:@"http://image.fundot.com.cn/"]) {
        NSString *img;
        if (IPhone6Plus) {//52*3
            img = [NSString stringWithFormat:@"%@@156w",statusM.icon];
        }else{
            img = [NSString stringWithFormat:@"%@@104w",statusM.icon];
        }
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }else{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }

    self.user_name.text = statusM.name;
    self.user_detail.text = [NSString stringWithFormat:@"本群共%@人",statusM.members_count];
    self.title.text = statusM.notice;
    [self.follow_she setTitle:@"加入群组" forState:UIControlStateNormal];
    self.active.text = @"本群活跃";
    
    if (statusM.active_users.count == 0) {
        self.user_head1.hidden = YES;
        self.user_head2.hidden = YES;
        self.user_head3.hidden = YES;
        self.user_head4.hidden = YES;
        
    }
    
    if (statusM.active_users.count>=1) {
        ActiveUserModel *model = statusM.active_users[0];
//        [self.user_head1 sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.user_head1.image = image;
//        }];
        if ([model.head hasPrefix:@"http://image.fundot.com.cn/"]) {
            NSString *img;
            if (IPhone6Plus) {//48*3
                img = [NSString stringWithFormat:@"%@@144w",model.head];
            }else{
                img = [NSString stringWithFormat:@"%@@96w",model.head];
            }
            
            [self.user_head1 sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head1.image = image;
            }];
        }else{
            [self.user_head1 sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head1.image = image;
            }];
        }

        _user_head1.kid = model.kid;
        [_user_head1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
        self.user_head1.hidden = NO;
        self.user_head2.hidden = YES;
        self.user_head3.hidden = YES;
        self.user_head4.hidden = YES;
        
        
    }
    if (statusM.active_users.count>=2) {
        ActiveUserModel *model = statusM.active_users[1];
//        [self.user_head2 sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.user_head2.image = image;
//        }];
        if ([model.head hasPrefix:@"http://image.fundot.com.cn/"]) {
            NSString *img;
            if (IPhone6Plus) {//48*3
                img = [NSString stringWithFormat:@"%@@144w",model.head];
            }else{
                img = [NSString stringWithFormat:@"%@@96w",model.head];
            }
            
            [self.user_head2 sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head2.image = image;
            }];
        }else{
            [self.user_head2 sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head2.image = image;
            }];
        }

        _user_head2.kid= model.kid;
        [_user_head2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
        self.user_head1.hidden = NO;
        self.user_head2.hidden = NO;
        self.user_head3.hidden = YES;
        self.user_head4.hidden = YES;
    }
    if (statusM.active_users.count>=3) {
        ActiveUserModel *model = statusM.active_users[2];
//        [self.user_head3 sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.user_head3.image = image;
//        }];
        if ([model.head hasPrefix:@"http://image.fundot.com.cn/"]) {
            NSString *img;
            if (IPhone6Plus) {//48*3
                img = [NSString stringWithFormat:@"%@@144w",model.head];
            }else{
                img = [NSString stringWithFormat:@"%@@96w",model.head];
            }
            
            [self.user_head3 sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head3.image = image;
            }];
        }else{
            [self.user_head3 sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head3.image = image;
            }];
        }
        _user_head3.kid= model.kid;
        [_user_head3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
        self.user_head1.hidden = NO;
        self.user_head2.hidden = NO;
        self.user_head3.hidden = NO;
        self.user_head4.hidden = YES;
    }
    if (statusM.active_users.count>=4) {
        ActiveUserModel *model = statusM.active_users[3];
//        [self.user_head4 sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.user_head4.image = image;
//        }];
        if ([model.head hasPrefix:@"http://image.fundot.com.cn/"]) {
            NSString *img;
            if (IPhone6Plus) {//48*3
                img = [NSString stringWithFormat:@"%@@144w",model.head];
            }else{
                img = [NSString stringWithFormat:@"%@@96w",model.head];
            }
            
            [self.user_head4 sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head4.image = image;
            }];
        }else{
            [self.user_head4 sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.user_head4.image = image;
            }];
        }
        _user_head4.kid= model.kid;
        [_user_head4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(user_headTapClick:)]];
        self.user_head1.hidden = NO;
        self.user_head2.hidden = NO;
        self.user_head3.hidden = NO;
        self.user_head4.hidden = NO;
    }

    
}
- (void)setupFrame{
    self.icon.frame = self.statusFrame.iconF;
    self.content_view.frame = self.statusFrame.content_viewF;
    self.user_name.frame = self.statusFrame.user_nameF;
    self.user_detail.frame = self.statusFrame.user_detailF;
    self.title.frame = self.statusFrame.titleF;
    self.follow_she.frame = self.statusFrame.follow_sheF;
    self.gap_view.frame = self.statusFrame.gap_viewF;
    self.line1.frame = self.statusFrame.line1F;
    self.active.frame = self.statusFrame.activeF;
    self.user_head1.frame = self.statusFrame.user_head1F;
    self.user_head2.frame = self.statusFrame.user_head2F;
    self.user_head3.frame = self.statusFrame.user_head3F;
    self.user_head4.frame = self.statusFrame.user_head4F;
    
    
    
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
