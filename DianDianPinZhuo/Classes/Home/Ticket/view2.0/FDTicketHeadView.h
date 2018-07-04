//
//  FDTicketHeadView.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTicketHeadView : UIView


@property (weak, nonatomic) IBOutlet UILabel *detailStr;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftIconView;

+(instancetype)selfTicketHeadView;
@end
