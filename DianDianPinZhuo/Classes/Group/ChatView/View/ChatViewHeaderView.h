//
//  ChatViewHeaderView.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDHeadImageView.h"
@interface ChatViewHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *totalPeople;

@property (weak, nonatomic) IBOutlet FDHeadImageView *head1;
@property (weak, nonatomic) IBOutlet FDHeadImageView *head2;
@property (weak, nonatomic) IBOutlet FDHeadImageView *head3;
@property (weak, nonatomic) IBOutlet FDHeadImageView *head4;

@end
