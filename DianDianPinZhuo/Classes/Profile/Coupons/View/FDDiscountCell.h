//
//  FDDiscountCell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/26.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDDiscountCell : UITableViewCell
///背景
@property (weak, nonatomic) IBOutlet UIView *bgView;
///顶部图片
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
///商家名字
@property (weak, nonatomic) IBOutlet UILabel *merchant_name;
///优惠价格
@property (weak, nonatomic) IBOutlet UILabel *discount_price;
///优惠券三个字
@property (weak, nonatomic) IBOutlet UILabel *discount_coupon;
///有效期
@property (weak, nonatomic) IBOutlet UILabel *beValidDate;
///限定时间内用餐
@property (weak, nonatomic) IBOutlet UILabel *limitTime;
///限定餐厅内使用
@property (weak, nonatomic) IBOutlet UILabel *limited_merchant;
///未定1
@property (weak, nonatomic) IBOutlet UILabel *undecided1;
///未定2
@property (weak, nonatomic) IBOutlet UILabel *undecided2;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
///右下角选中小标
@property (weak, nonatomic) IBOutlet UIButton *selectedView;
@end
