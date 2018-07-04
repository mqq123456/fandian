//
//  FDTopicDetailUserHeadView.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDHeadImageView.h"
@class MemberModel;

@interface FDTopicDetailUserHeadView : UIView
@property (nonatomic, strong) MemberModel *photo;
@property (nonatomic, weak) FDHeadImageView *imageView;
@property (nonatomic, weak) UILabel *userName;
@property (nonatomic, weak) UILabel *last_people;
@end
