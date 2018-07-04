//
//  FDCouponsCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/24.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDCouponsCell.h"
#import "HQConst.h"
@implementation FDCouponsCell

- (void)awakeFromNib {
    // Initialization code
    if (IPhone6) {
        self.titleLeft.constant = 130;
    }else if(IPhone6Plus){
        self.titleLeft.constant = 110;
    }else{
        self.titleLeft.constant = 100;
    }
    if (IPhone6Plus) {
        self.yuanBotton.constant = -6;
    }else{
        self.yuanBotton.constant = -5;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
