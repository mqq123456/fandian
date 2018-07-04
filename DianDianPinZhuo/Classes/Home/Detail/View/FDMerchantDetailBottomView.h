//
//  FDMerchantDetailBottomView.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/2/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDMerchantDetailBottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UILabel *yiyou;
@property (weak, nonatomic) IBOutlet UILabel *price_desc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *price_top;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *dikouquanyidi;
@property (weak, nonatomic) IBOutlet UILabel *dikou_price;
@property (weak, nonatomic) IBOutlet UILabel *dikou_yuan;
+(instancetype)detailBottomView;
@end
