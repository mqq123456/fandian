//
//  FDTicketShareView.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
@interface FDTicketShareView : UIView<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *topText;

+(instancetype)ticketShareView:(NSString *)Weixin_invite_url andTitle:(NSString *)Weixin_invite_title andContent:(NSString *)Weixin_invite_content;
@property (copy, nonatomic)NSString *contText;
@property (copy, nonatomic)NSString *title;
@property (copy, nonatomic)NSString *umURL;
@end
