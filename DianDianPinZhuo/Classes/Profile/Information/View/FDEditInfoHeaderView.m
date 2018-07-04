//
//  FDEditInfoHeaderView.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/31.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDEditInfoHeaderView.h"
#import "HQConst.h"
@implementation FDEditInfoHeaderView

+(instancetype)editInfoHeaderView{
    return [[NSBundle mainBundle] loadNibNamed:@"FDEditInfoHeaderView" owner:nil options:nil][0];

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    self.xingzuoX.constant = -[UIScreen mainScreen].bounds.size.width*1.08*13/44;
    self.xingzuoBottom.constant = [UIScreen mainScreen].bounds.size.width*1.07*20/44;
    self.ageX.constant = -[UIScreen mainScreen].bounds.size.width*1.058*2.5/11;
    self.ageBottom.constant = [UIScreen mainScreen].bounds.size.width*1.058*10/44;
    self.provinceX.constant = [UIScreen mainScreen].bounds.size.width*1.058*3.3/11;
    self.privinceBottom.constant = [UIScreen mainScreen].bounds.size.width*1.058*6.5/44;
    
    if (IPHONE5||IPHONE4) {
        self.peopleH.constant = 26;
    }
    if (IPhone6) {
        self.peopleH.constant = 33;
    }
    [self layoutIfNeeded];
    
    
}
@end
