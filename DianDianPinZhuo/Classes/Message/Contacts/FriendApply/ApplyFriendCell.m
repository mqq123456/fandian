/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "ApplyFriendCell.h"
#import "FDUtils.h"
@implementation ApplyFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 15, 50, 50)];
        _headerImageView.clipsToBounds = YES;
        _headerImageView.layer.cornerRadius = 25.0;
        [self.contentView addSubview:_headerImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:19];
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];;
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_contentLabel];
        
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 95, 0, 76,30)];
        [_addButton setBackgroundColor:[UIColor redColor]];
        [_addButton setTitle:NSLocalizedString(@"accept", @"Accept") forState:UIControlStateNormal];
        _addButton.layer.cornerRadius = 5;
        _addButton.clipsToBounds = YES;
        _addButton.backgroundColor = [UIColor redColor];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [_addButton addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
        _addButton.enabled = NO;
        [self.contentView addSubview:_addButton];
        
//        _refuseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, 0, 50, 30)];
//        [_refuseButton setBackgroundColor:[UIColor colorWithRed:87 / 255.0 green:186 / 255.0 blue:205 / 255.0 alpha:1.0]];
//        [_refuseButton setTitle:NSLocalizedString(@"reject", @"Reject") forState:UIControlStateNormal];
//        _refuseButton.clipsToBounds = YES;
//        [_refuseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _refuseButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [_refuseButton addTarget:self action:@selector(refuseFriend) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_refuseButton];
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 /255.0 blue:0 / 255.0 alpha:0.15];
        [self.contentView addSubview:_bottomLineView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _addButton.frame = CGRectMake(self.contentView.frame.size.width -95, (self.contentView.frame.size.height - 30) / 2, 76, 30);
//    _refuseButton.frame = CGRectMake(self.contentView.frame.size.width - 120, (self.contentView.frame.size.height - 30) / 2, 50, 30);
    _bottomLineView.frame = CGRectMake(0, self.contentView.frame.size.height - 1, self.contentView.frame.size.width, 1);
    if (_contentLabel.text.length > 0) {
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 12, 20, self.contentView.frame.size.width-195, 20);
        _contentLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame)+4, _titleLabel.frame.size.width, self.contentView.frame.size.height - 20 - _titleLabel.frame.size.height-20);
    }
    else{
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 12, 20, self.contentView.frame.size.width - 115 - (CGRectGetMaxX(_headerImageView.frame) + 12), self.contentView.frame.size.height - 20);
        _contentLabel.frame = CGRectZero;
    }
}

- (void)addFriend
{
    if(_delegate && [_delegate respondsToSelector:@selector(applyCellAddFriendAtIndexPath:)])
    {
        [_delegate applyCellAddFriendAtIndexPath:self.indexPath];
    }
}

- (void)refuseFriend
{
    if(_delegate && [_delegate respondsToSelector:@selector(applyCellRefuseFriendAtIndexPath:)])
    {
        [_delegate applyCellRefuseFriendAtIndexPath:self.indexPath];
    }
}

+ (CGFloat)heightWithContent:(NSString *)content
{
    if (!content || content.length == 0) {
        return 80;
    }
    else{
        NSArray *messageArray = [content componentsSeparatedByString:@":;"];
        CGSize size = [messageArray[0] sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 194, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
        return size.height > 20 ? (size.height + 60) : 80;
    }
}

@end
