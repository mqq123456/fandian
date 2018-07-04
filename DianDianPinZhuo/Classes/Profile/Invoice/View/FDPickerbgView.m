//
//  FDPickerbgView.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDPickerbgView.h"

@implementation FDPickerbgView

+(instancetype)fdPickerbgView{
    
    return [[NSBundle mainBundle]loadNibNamed:@"FDPickerbgView" owner:nil options:nil][0];
}

@end
