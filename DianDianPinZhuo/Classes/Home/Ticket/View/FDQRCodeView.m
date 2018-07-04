//
//  FDQRCodeView.m
//  DianDianPinZhuo
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDQRCodeView.h"
#import "QRCodeGenerator.h"
#import "HQConst.h"
@implementation FDQRCodeView

- (void)awakeFromNib {
    
    //self.CodeImageView.image = [UIImage imageNamed:@"placeholder"];
    self.CodeImageView.image =[QRCodeGenerator qrImageForString:@"sesorhoprtnphnrpiehnpiretnhpirtnhpiruentpij" imageSize:self.CodeImageView.bounds.size.width];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    [self layoutIfNeeded];
}


@end
