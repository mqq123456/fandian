//
//  FDTopicCommentCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicCommentCell.h"
#import "HQConst.h"
#import "FDTopicCommentFrame.h"
#import "TopicCommentModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Urldecode.h"
#import "FDUtils.h"

@interface FDTopicCommentCell ()


/** 昵称 */
@property (nonatomic, weak) UILabel *nick_name;
@property (nonatomic, weak) UIImageView *jiantou;

/** 时间 */
@property (nonatomic, weak) UILabel *time;
/** 内容view */

/** 内容 */
@property (nonatomic, weak) UILabel *content;
/** 底部view */
@property (nonatomic, weak) UIView *gap_view;
@end

@implementation FDTopicCommentCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FDTopicCommentCell";
    FDTopicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FDTopicCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化动态
        self.backgroundColor = FDColor(233.0, 233.0, 233.0, 1);
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
    gap_view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:gap_view];
    self.gap_view = gap_view;
    
    /** 头像 */
    FDHeadImageView *icon = [[FDHeadImageView alloc] init];
    icon.layer.cornerRadius = 46/2;
    icon.userInteractionEnabled = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    
    UILabel *nick_name = [[UILabel alloc] init];
    nick_name.textColor = FDColor(34, 34, 34, 1);
    nick_name.font = nick_nameFont;
    [self.contentView addSubview:nick_name];
    self.nick_name = nick_name;
    
  
    
//    UIImageView *jiantou = [[UIImageView alloc] init];
//    jiantou.image = [UIImage imageNamed:@"bow_bg_pjbj"];
//
//    jiantou.contentMode = UIViewContentModeScaleAspectFill;
//    [self.contentView addSubview:jiantou];
//    self.jiantou = jiantou;
//    
    
    UILabel *time = [[UILabel alloc] init];
    time.font = time_font;
    time.textAlignment= NSTextAlignmentLeft;
    time.textColor = FDColor(153, 153, 153, 1);
    [self.contentView addSubview:time];
    self.time = time;
    

    
//    UIView *content_view = [[UIView alloc] init];
//    content_view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-10, 0.5);
//    content_view.userInteractionEnabled = YES;
//    content_view.backgroundColor = FDColor(242, 242, 242, 1);
//
//    
//    [self.contentView addSubview:content_view];
//    self.content_view = content_view;
    
    /** 已有 */
    UILabel *content = [[UILabel alloc] init];
    content.font = content_Font;
    content.numberOfLines = 0;
    content.textColor = [FDUtils colorWithHexString:@"#666666"];

    [self.contentView addSubview:content];
    self.content = content;

    
}

- (void)setStatusFrame:(FDTopicCommentFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupFrame];
    
    TopicCommentModel *statusM = statusFrame.status;
    
    /** 图片 */
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.icon.image = image;
//    }];
    
    if ([statusM.img hasPrefix:@"http://image.fundot.com.cn/"]) {
        NSString *img;
        if (IPhone6Plus) {//48*3
            img = [NSString stringWithFormat:@"%@@144w",statusM.img];
        }else{
            img = [NSString stringWithFormat:@"%@@96w",statusM.img];
        }
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }else{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }
    
    self.icon.kid = statusM.kid;
    /** 描述文字 */
    self.nick_name.text = statusM.nickname;
    
    /** 餐厅名称 */
    self.time.text = statusM.time_desc;
    
    NSString *decodedString = [statusM.content stringByDecodingURLFormat];
    NSString *content;
    /** 距离 */
    if (![statusM.reply_kid isEqualToString:@""]&&![statusM.reply_nickname isEqualToString:@""]) {

        content  = [NSString stringWithFormat:@"回复%@：%@",statusM.reply_nickname,decodedString];
        NSMutableDictionary *heightLightDict=[NSMutableDictionary dictionary];
        heightLightDict[NSFontAttributeName]=[UIFont systemFontOfSize:14];
        heightLightDict[NSForegroundColorAttributeName]=[FDUtils colorWithHexString:@"#222222"];
        NSMutableAttributedString *attributeTitle=[[NSMutableAttributedString alloc] initWithString:content attributes:heightLightDict];
        
        NSRange firshRange=[content rangeOfString:statusM.reply_nickname];
        [attributeTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:firshRange];
        [attributeTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:firshRange];
        [self.content setAttributedText:attributeTitle];
    }else{

        self.content.text = decodedString;
    }

}
- (void)setupFrame{
    
    self.gap_view.frame = _statusFrame.gap_viewF;
    self.icon.frame = _statusFrame.iconF;
    self.nick_name.frame = _statusFrame.nick_nameF;
    self.time.frame = _statusFrame.timeF;
    self.content.frame = _statusFrame.contentF;
    self.jiantou.frame = _statusFrame.jiantouF;
    self.content_view.frame = _statusFrame.content_viewF;

    
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
