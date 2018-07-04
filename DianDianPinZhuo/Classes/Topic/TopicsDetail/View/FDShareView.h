//
//  FDShareView.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"



@interface FDShareView : UIView<UMSocialUIDelegate>
+(instancetype)shareView;
@property (copy, nonatomic)NSString *contText;
@property (copy, nonatomic)NSString *title;
@property (copy, nonatomic)NSString *umURL;
@property (copy, nonatomic)NSString *topic_id;

///群组分享文案，如“XXX预订了洱语的四人套餐”
@property (copy, nonatomic)NSString *group_share_title;
///群组分享动作，如“立即查看”
@property (copy, nonatomic)NSString *group_share_hint;


@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *circleFriendBtn;
@property (weak, nonatomic) IBOutlet UIButton *fandianGroup;

@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (assign, nonatomic) id delegate;
/**
 *  
 * 1.第一次进
 
 * 2。分享的抵扣券
 
 * 3.免费餐劵，1元餐劵
 
 * 4.饭票页分享
 
 * 5.话题详情分享
 
 * 6.一元餐券html5分享
 
 * 7.餐厅详情分享
 
 * 8.评论详情分享
 
 */
@property (copy, nonatomic) NSString * type;

- (IBAction)weChatClick:(id)sender;
- (IBAction)weChatBtncircleFriendClick:(id)sender;
- (IBAction)cancleClick:(id)sender;
- (IBAction)fandianGroupBtnClick:(id)sender;



@end
