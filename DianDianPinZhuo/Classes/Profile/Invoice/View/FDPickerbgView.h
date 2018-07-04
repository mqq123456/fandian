//
//  FDPickerbgView.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDPickerbgView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *myPicker;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;

+(instancetype)fdPickerbgView;

@end
