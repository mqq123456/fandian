//
//  FDMerchantDetailBottonView.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDMerchantDetailBottonView : UIView
@property (nonatomic ,copy) NSString *price_str;
@property (nonatomic ,copy) NSString *yuding_people_str;
@property (nonatomic ,copy) NSString *kongwei_people_str;
@property (nonatomic ,strong)UIButton *orderBtn;
@end
