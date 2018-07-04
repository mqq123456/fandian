//
//  FDCommentCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDCommentCell.h"
#import "HQConst.h"
#import "FDCommentFrame.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Urldecode.h"
#import "LDXScore.h"
#import "HWStatusPhotosView.h"
@interface FDCommentCell ()


/** 昵称 */
@property (nonatomic, weak) UILabel *nick_name;
@property (nonatomic, weak) UIImageView *jiantou;
/** 星级 */
@property (nonatomic, weak) LDXScore *star;
/** 时间 */
@property (nonatomic, weak) UILabel *time;
/** 内容view */
@property (nonatomic, weak) UIView *content_view;
/** 内容 */
@property (nonatomic, weak) UILabel *content;
/** 底部view */
@property (nonatomic, weak) UIView *gap_view;
@property (nonatomic, weak) UILabel *reply;

@property (nonatomic, weak) HWStatusPhotosView *image;


@end

@implementation FDCommentCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FDCommentCell";
    FDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FDCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    gap_view.backgroundColor = FDColor(233, 233, 233, 1);
    [self.contentView addSubview:gap_view];
    self.gap_view = gap_view;
    
    
    UIImageView *jiantou = [[UIImageView alloc] init];
    jiantou.image = [UIImage imageNamed:@"bow_bg_pjbj"];
    
//    jiantou.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:jiantou];
    self.jiantou = jiantou;
    

    UILabel *nick_name = [[UILabel alloc] init];
    nick_name.textColor = FDColor(102, 102, 102, 1);
    nick_name.font = nick_nameFont;
    [self.contentView addSubview:nick_name];
    self.nick_name = nick_name;
  
    /** 头像 */
    FDHeadImageView *icon = [[FDHeadImageView alloc] init];
    icon.layer.cornerRadius = 42/2;
    icon.userInteractionEnabled = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    /** 头像 */
    HWStatusPhotosView *image = [[HWStatusPhotosView alloc] init];
    [self.contentView addSubview:image];
    self.image = image;
    

    UILabel *time = [[UILabel alloc] init];
    time.font = time_font;
    time.textAlignment= NSTextAlignmentLeft;
    time.textColor = FDColor(153, 153, 153, 1);
    [self.contentView addSubview:time];
    self.time = time;
    
    LDXScore *star = [[LDXScore alloc] init];
    [self.contentView addSubview:star];
    star.normalImg = [UIImage imageNamed:@"star_nor"];
    star.highlightImg = [UIImage imageNamed:@"star_sel"];
    self.star = star;
    
    UILabel *reply = [[UILabel alloc] init];
    reply.font = content_Font;
    reply.textAlignment= NSTextAlignmentLeft;
    reply.numberOfLines = 0;
    reply.textColor = FDColor(51, 51, 51, 1);
    [self.contentView addSubview:reply];
    self.reply = reply;
    
    
    UIView *content_view = [[UIView alloc] init];
 
    content_view.backgroundColor = FDColor(246, 246, 246, 1);
    [self.contentView addSubview:content_view];
    self.content_view = content_view;
    
    /** 已有 */
    UILabel *content = [[UILabel alloc] init];
    content.font = content_Font;
    content.numberOfLines = 0;
    content.textColor = FDColor(102, 102, 102, 1);
    [content_view addSubview:content];
    self.content = content;
    
    
    
    
    
}

- (void)setStatusFrame:(FDCommentFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupFrame];
    
    CommentModel *statusM = statusFrame.status;
    
    /** 图片 */
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.icon.image = image;
//    }];
    if ([statusM.icon hasPrefix:@"http://image.fundot.com.cn/"]) {
        NSString *img;
        if (IPhone6Plus) {//42*3
            img = [NSString stringWithFormat:@"%@@144w",statusM.icon];
        }else{
            img = [NSString stringWithFormat:@"%@@96w",statusM.icon];
        }
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }else{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }

    /** 配图 */
    if (statusM.imgs.count>0) {
        self.image.photos = statusM.imgs;
        self.image.hidden = NO;
    } else {
        self.image.hidden = YES;
    }
    /** 描述文字 */
    self.nick_name.text = statusM.nick_name;
    
    self.icon.kid = statusM.kid;

    /** 餐厅名称 */
    self.time.text = statusM.create_time;
    /** 特色 */
    self.star.show_star = [statusM.star intValue];
    
    NSString *decodedString = [statusM.content stringByDecodingURLFormat];
    /** 距离 */
#warning 注意
    //reply是标题
    self.reply.text =decodedString;
    /**
     *  商家回复
     */
    self.content.text = statusM.service_response;

    
}
- (void)setupFrame{
    self.gap_view.frame = _statusFrame.gap_viewF;
    self.icon.frame = _statusFrame.iconF;
    self.nick_name.frame = _statusFrame.nick_nameF;
    self.time.frame = _statusFrame.timeF;
    self.jiantou.frame = _statusFrame.jiantouF;
    self.star.frame = _statusFrame.starF;
    self.reply.frame = _statusFrame.replyF;
    self.content.frame = _statusFrame.contentF;
    self.content_view.frame = _statusFrame.content_viewF;
    self.image.frame = _statusFrame.imageF;
    
        
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
