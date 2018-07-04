//
//  FDCouponsCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/24.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDCouponsCell : UITableViewCell
///背景
@property (weak, nonatomic) IBOutlet UIView *bgView;
///顶部图片
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
///商家名字
@property (weak, nonatomic) IBOutlet UILabel *coupon_name;
///优惠价格
@property (weak, nonatomic) IBOutlet UILabel *discount_price;
///优惠券三个字
@property (weak, nonatomic) IBOutlet UILabel *label1;
///有效期
@property (weak, nonatomic) IBOutlet UILabel *label2;
///限定时间内用餐
@property (weak, nonatomic) IBOutlet UILabel *label3;
///限定餐厅内使用
@property (weak, nonatomic) IBOutlet UILabel *label4;
///未定1
@property (weak, nonatomic) IBOutlet UILabel *label5;
///未定2
@property (weak, nonatomic) IBOutlet UILabel *yuan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yuanBotton;

@end
