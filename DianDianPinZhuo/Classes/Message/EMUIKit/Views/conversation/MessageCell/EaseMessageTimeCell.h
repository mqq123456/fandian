//
//  EaseMessageTimeCell.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTimeLabel.h"

@interface EaseMessageTimeCell : UITableViewCell
@property (strong, nonatomic) UIView *title_bgView;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UILabel *titleLabel;

@property (nonatomic) UIFont *titleLabelFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:12]

@property (nonatomic) UIColor *titleLabelColor UI_APPEARANCE_SELECTOR; //default [UIColor grayColor]

+ (NSString *)cellIdentifier;

@end
