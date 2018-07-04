//
//  FDMerchantDetail_Menu_Cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDMerchantDetailController.h"
@interface FDMerchantDetail_Menu_Cell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView categoryArray:(NSArray *)categoryArray menuArray:(NSArray *)menuArray hasTC:(BOOL)hasTC is_introduction:(BOOL)is_introduction;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
///左边已订满
@property (weak, nonatomic) IBOutlet UIImageView *booked1;
///右边已订满
@property (weak, nonatomic) IBOutlet UIImageView *booked2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftbtnCenterY;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;

@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UILabel *left_tao_desc;

@property (weak, nonatomic) IBOutlet UILabel *right_tao_desc;

@property (weak, nonatomic) IBOutlet UILabel *left_price;

@property (weak, nonatomic) IBOutlet UILabel *right_price;

@property (weak, nonatomic) IBOutlet UILabel *suggest1;

@property (weak, nonatomic) IBOutlet UILabel *suggest2;

@property (weak, nonatomic) IBOutlet UIButton *select_tip_Btn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *select_tips_H;
@property (weak, nonatomic) IBOutlet UILabel *tuijian_people;


@end
