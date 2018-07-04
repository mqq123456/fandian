//
//  ZJSliderView.h
//  MyDamai
//
//  Created by mac on 14-10-18.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSliderView : UIView


@property (nonatomic) float labelWidth;
@property (nonatomic,assign) BOOL left;

//执行执行此方法之前必须要设定ZJSliderView的frame
-(void)setViews:(NSArray *)views names:(NSArray *)names;
@end
