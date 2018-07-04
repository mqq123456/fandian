//
//  FDPersonalCenterCell.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDPersonalCenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *now_btn;
@property (weak, nonatomic) IBOutlet UIImageView *identify;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *now_btn_whith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *now_btn_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLeftContain;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconCenter;

@end
