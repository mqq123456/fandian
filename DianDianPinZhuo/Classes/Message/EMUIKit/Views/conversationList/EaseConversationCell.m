//
//  EaseConversationCell.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseConversationCell.h"

#import "EMConversation.h"
#import "UIImageView+EMWebCache.h"
#import "UIView+Extension.h"
CGFloat const EaseConversationCellPadding = 13.5;

@interface EaseConversationCell()

@property (nonatomic) NSLayoutConstraint *titleWithAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *titleWithoutAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *detailWithAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *detailWithoutAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *creat_timeWithAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *creat_timeWithoutAvatarLeftConstraint;


@property (nonatomic) NSLayoutConstraint *bageViewWithAvatarRightConstraint;

@property (nonatomic) NSLayoutConstraint *bageViewWithoutAvatarRightConstraint;

@end

@implementation EaseConversationCell

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseConversationCell *cell = [self appearance];
    cell.titleLabelColor = [UIColor blackColor];
    cell.titleLabelFont = [UIFont systemFontOfSize:16];
    cell.detailLabelColor = [UIColor lightGrayColor];
    cell.detailLabelFont = [UIFont systemFontOfSize:15];
    cell.timeLabelColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    cell.timeLabelFont = [UIFont systemFontOfSize:13];
    
    cell.creat_timeLabelColor = [UIColor grayColor];
    cell.creat_timeLabelFont = [UIFont systemFontOfSize:12];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showAvatar = YES;
        [self _setupSubview];
    }
    
    return self;
}

#pragma mark - private layout subviews

- (void)_setupSubview
{
    _avatarView = [[EaseImageView alloc] init];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    _avatarView.layer.cornerRadius= 26.5;
    _avatarView.layer.masksToBounds = YES;
    [self.contentView addSubview:_avatarView];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timeLabel.font = _timeLabelFont;
    _timeLabel.textColor = _timeLabelColor;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_timeLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.numberOfLines = 1;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = _titleLabelFont;
    _titleLabel.textColor = _titleLabelColor;
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = _detailLabelFont;
    _detailLabel.textColor = _detailLabelColor;
    [self.contentView addSubview:_detailLabel];
    
    _creat_timeLabel = [[UILabel alloc] init];
    _creat_timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _creat_timeLabel.backgroundColor = [UIColor clearColor];
    _creat_timeLabel.font = _creat_timeLabelFont;
    _creat_timeLabel.textColor = _creat_timeLabelColor;
    [self.contentView addSubview:_creat_timeLabel];
    
    
    _badgeView = [[UILabel alloc] init];
    _badgeView.translatesAutoresizingMaskIntoConstraints = NO;
    _badgeView.textAlignment = NSTextAlignmentCenter;
    _badgeView.textColor = [UIColor whiteColor];
    _badgeView.backgroundColor = [UIColor redColor];
    _badgeView.font = [UIFont systemFontOfSize:10];
    _badgeView.hidden = NO;
    _badgeView.layer.cornerRadius = 18 / 2;
    _badgeView.clipsToBounds = YES;
    [self.contentView addSubview:_badgeView];
    
    [self _setupAvatarViewConstraints];
    [self _setupTimeLabelConstraints];
    [self _setupTitleLabelConstraints];
    [self _setupDetailLabelConstraints];
    [self _setupCreat_timeLabelConstraints];
    [self _setupBadgeViewConstraint];
    
}

#pragma mark - Setup Constraints

- (void)_setupAvatarViewConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseConversationCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EaseConversationCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseConversationCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
}

- (void)_setupTimeLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseConversationCellPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:80.0f];
    [self addConstraint:constraint];

}

- (void)_setupTitleLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:15]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:-EaseConversationCellPadding]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseConversationCellPadding]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-90]];
    self.titleWithAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseConversationCellPadding];
    self.titleWithoutAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseConversationCellPadding];
    [self addConstraint:self.titleWithAvatarLeftConstraint];
}

- (void)_setupDetailLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-14]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-44]];
    
    self.detailWithAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseConversationCellPadding];
    self.detailWithoutAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseConversationCellPadding];
    [self addConstraint:self.detailWithAvatarLeftConstraint];
}
- (void)_setupCreat_timeLabelConstraints{
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.creat_timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.creat_timeLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.creat_timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseConversationCellPadding]];
    
    self.creat_timeWithAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.creat_timeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseConversationCellPadding];
    self.creat_timeWithoutAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.creat_timeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseConversationCellPadding];
    
    [self addConstraint:self.creat_timeWithAvatarLeftConstraint];
}
#pragma mark - setter

- (void)setShowAvatar:(BOOL)showAvatar
{
    if (_showAvatar != showAvatar) {
        _showAvatar = showAvatar;
        self.avatarView.hidden = !showAvatar;
        if (_showAvatar) {
            [self removeConstraint:self.titleWithoutAvatarLeftConstraint];
            [self removeConstraint:self.detailWithoutAvatarLeftConstraint];
            [self removeConstraint:self.creat_timeWithoutAvatarLeftConstraint];
            [self addConstraint:self.titleWithAvatarLeftConstraint];
            [self addConstraint:self.detailWithAvatarLeftConstraint];
            [self addConstraint:self.creat_timeWithAvatarLeftConstraint];
        }
        else{
            [self removeConstraint:self.titleWithAvatarLeftConstraint];
            [self removeConstraint:self.detailWithAvatarLeftConstraint];
            
            [self removeConstraint:self.creat_timeWithAvatarLeftConstraint];
            
            [self addConstraint:self.titleWithoutAvatarLeftConstraint];
            [self addConstraint:self.detailWithoutAvatarLeftConstraint];
            [self addConstraint:self.creat_timeWithoutAvatarLeftConstraint];
        }
    }
}

- (void)_setupBadgeViewConstraint
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.detailLabel attribute:NSLayoutAttributeHeight multiplier:0.7 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.badgeView attribute:NSLayoutAttributeHeight multiplier:1.36 constant:0]];

}
- (void)setModel:(id<IConversationModel>)model
{
    _model = model;
    
    if ([_model.title length] > 0) {
        self.titleLabel.text = _model.title;
    }
    else{
        self.titleLabel.text = _model.conversation.chatter;
    }
    
    if (self.showAvatar) {
        if ([_model.avatarURLPath length] > 0){
            
            if ([model.avatarURLPath hasPrefix:@"http://image.fundot.com.cn/"]) {
                NSString *img;
                if ([UIScreen mainScreen].bounds.size.height == 736) {//52*3
                    img = [NSString stringWithFormat:@"%@@156w",model.avatarURLPath];
                }else{
                    img = [NSString stringWithFormat:@"%@@104w",model.avatarURLPath];
                }
                
                [self.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:img] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
                    self.avatarView.image = image;
                }];
            }else{
                [self.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatarURLPath] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
                    self.avatarView.image = image;
                }];
            }

//            [self.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:_model.avatarURLPath] placeholderImage:_model.avatarImage completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
//                self.avatarView.imageView.image = image;
//            }];
        } else {
            if (_model.avatarImage) {
                self.avatarView.image = _model.avatarImage;
            }
        }
#warning 修改头像
        //self.avatarView.image = [UIImage imageNamed:@"placeholder"];
    }
    
    if (_model.conversation.unreadMessagesCount == 0) {
        _avatarView.showBadge = NO;
        _badgeView.hidden = YES;
    }
    else{
        _avatarView.showBadge = NO;
        _badgeView.hidden = NO;
//        _avatarView.badge = _model.conversation.unreadMessagesCount;

        if (_model.conversation.unreadMessagesCount>99) {
           _badgeView.text = @"99+";
        }else{
           _badgeView.text = [NSString stringWithFormat:@"%zd",_model.conversation.unreadMessagesCount];
        }
        
    }
    //_creat_timeLabel.text = _model.conversation.ext[@"creat_time"];
    _creat_timeLabel.text = @"";
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabelFont = titleLabelFont;
    _titleLabel.font = _titleLabelFont;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    _titleLabelColor = titleLabelColor;
    _titleLabel.textColor = _titleLabelColor;
}

- (void)setDetailLabelFont:(UIFont *)detailLabelFont
{
    _detailLabelFont = detailLabelFont;
    _detailLabel.font = _detailLabelFont;
}

- (void)setDetailLabelColor:(UIColor *)detailLabelColor
{
    _detailLabelColor = detailLabelColor;
    _detailLabel.textColor = _detailLabelColor;
}

- (void)setTimeLabelFont:(UIFont *)timeLabelFont
{
    _timeLabelFont = timeLabelFont;
    _timeLabel.font = _timeLabelFont;
}

- (void)setTimeLabelColor:(UIColor *)timeLabelColor
{
    _timeLabelColor = timeLabelColor;
    _timeLabel.textColor = _timeLabelColor;
}
- (void)setCreat_timeLabelColor:(UIColor *)creat_timeLabelColor{
    _creat_timeLabelColor = creat_timeLabelColor;
    _creat_timeLabel.textColor = _creat_timeLabelColor;
}
- (void)setCreat_timeLabelFont:(UIFont *)creat_timeLabelFont
{
    _creat_timeLabelFont = creat_timeLabelFont;
    _creat_timeLabel.font = _creat_timeLabelFont;
}

#pragma mark - class method

+ (NSString *)cellIdentifierWithModel:(id)model
{
    return @"EaseConversationCell";
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return EaseConversationCellMinHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (_avatarView.badge) {
        _avatarView.badgeBackgroudColor = [UIColor clearColor];
        _badgeView.backgroundColor =[UIColor redColor];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (_avatarView.badge) {
        _avatarView.badgeBackgroudColor = [UIColor clearColor];
        _badgeView.backgroundColor =[UIColor redColor];
    }
}

@end
