//
//  FDOrderStateCell.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDOrderStateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *daishiyongBtn;
@property (weak, nonatomic) IBOutlet UIButton *daipingjiaBtn;
@property (weak, nonatomic) IBOutlet UIButton *yiwanchengBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UIButton *tuikuanBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderSumWith;
@property (weak, nonatomic) IBOutlet UIView *orderSum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;

@end
