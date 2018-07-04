//
//  EaseSigalChatCell.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IConversationModel.h"
#import "IModelCell.h"
#import "EaseImageView.h"

static CGFloat EaseSigalChatCellMinHeight = 90;

@interface EaseSigalChatCell : UITableViewCell<IModelCell>

@property (strong, nonatomic) EaseImageView *avatarView;

@property (strong, nonatomic) UILabel *detailLabel;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UILabel *titleLabel;

//@property (strong, nonatomic) UILabel *creat_timeLabel;

@property (strong, nonatomic) UILabel *badgeView;

@property (strong, nonatomic) id<IConversationModel> model;

@property (nonatomic) BOOL showAvatar;//default is "YES"

@property (nonatomic) UIFont *titleLabelFont UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *titleLabelColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIFont *detailLabelFont UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *detailLabelColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIFont *timeLabelFont UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *timeLabelColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIFont *creat_timeLabelFont UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *creat_timeLabelColor UI_APPEARANCE_SELECTOR;

@end
