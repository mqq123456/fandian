//
//  FDMyOrderCell.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDMyOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *state;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *merchant_name;
@property (weak, nonatomic) IBOutlet UILabel *people_price;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;


@end
