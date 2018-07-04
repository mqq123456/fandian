//
//  FDOrderBottomView.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/26.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDOrderBottomView.h"


@implementation FDOrderBottomView
+(instancetype)fdOrderBottomView{

    return [[NSBundle mainBundle]loadNibNamed:@"FDOrderBottomView" owner:nil options:nil][0];
}
- (void)confirmViewPrice:(NSString *)price discountPrice:(NSString *)discount{
    
    self.price.text = price;
    
    self.diccount_prie.text = [NSString stringWithFormat:@"(已优惠%@元)",discount];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height- 60-64, [UIScreen mainScreen].bounds.size.width, 60);
    [self layoutIfNeeded];
}
@end
