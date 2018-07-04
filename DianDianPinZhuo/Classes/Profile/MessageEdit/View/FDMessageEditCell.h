//
//  FDMessageEditCell.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDMessageEditCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeW;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *nowEnvluation;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
