//
//  FDMerchantDetailFooterView.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/29.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDMerchantDetailFooterView.h"

@interface FDMerchantDetailFooterView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_lineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_lineH;

@end

@implementation FDMerchantDetailFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib {
    // Initialization code
    self.left_lineH.constant = 0.5;
    self.right_lineH.constant = 0.5;
}


@end
