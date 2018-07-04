//
//  FDOrderBottomView.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/26.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDOrderBottomView : UIView

+(instancetype)fdOrderBottomView;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *diccount_prie;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;


- (void)confirmViewPrice:(NSString *)price discountPrice:(NSString *)discount;

@end
