//
//  FDGameView.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/29.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDGameView : UIView
- (IBAction)know_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;
+(instancetype)shareFdGameView;
@end
