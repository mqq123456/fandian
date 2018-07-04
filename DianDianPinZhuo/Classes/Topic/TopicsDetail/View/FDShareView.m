//
//  FDShareView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDShareView.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "HQDefaultTool.h"
#import "ConversationListController.h"


@implementation FDShareView

+(instancetype)shareView{
    static FDShareView *share=nil;
    if(share==nil)
    {
        share=[[NSBundle mainBundle]loadNibNamed:@"FDShareView" owner:nil options:nil][0];
    }

    return share;
    
}
- (void)awakeFromNib {
    // Initialization code
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleClick:)]];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
}
- (IBAction)weChatClick:(id)sender {
    [self removeFromSuperview];
    NSString *contText = self.contText;;
    NSString *title = self.title;
    NSString *umURL = self.umURL;
    NSString *imageStr;
    if ([self.type integerValue]==2) {
        imageStr = @"redbag";
    }else{
    
        imageStr = @"share_image";
    }
    
    [UMSocialWechatHandler setWXAppId:@"wx248654a2abf7326d" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:umURL];
    [[UMSocialControllerService defaultControllerService] setShareText:contText shareImage:[UIImage imageNamed:imageStr] socialUIDelegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title =title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = umURL;
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(nil,[UMSocialControllerService defaultControllerService],YES);
}

- (IBAction)weChatBtncircleFriendClick:(id)sender {
    [self removeFromSuperview];

    NSString *title = self.title;
    NSString *umURL = self.umURL;
    NSString *imageStr;
    if ([self.type integerValue]==2) {
        imageStr = @"redbag";
    }else{
        
        imageStr = @"share_image";
    }
    [UMSocialWechatHandler setWXAppId:@"wx248654a2abf7326d" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:umURL];
    [[UMSocialControllerService defaultControllerService] setShareText:title shareImage:[UIImage imageNamed:imageStr] socialUIDelegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title =title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = umURL;
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline].snsClickHandler(nil,[UMSocialControllerService defaultControllerService],YES);
}

- (IBAction)cancleClick:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)fandianGroupBtnClick:(id)sender {
    [self removeFromSuperview];
    ConversationListController *list = [[ConversationListController alloc] init];
    list.share = YES;
    list.type = self.type;
    if ([self.type integerValue]==1) {//第一次进
        
    }else if ([self.type integerValue]==2){//分享的抵扣券
        list.share_title = self.title;
    }else if ([self.type integerValue]==3){//免费餐劵，1元餐劵
        list.share_title = self.title;
    }else if ([self.type integerValue]==4){//饭票页分享
        list.share_title = self.group_share_title;
    }else if ([self.type integerValue]==5){//话题详情分享
        list.share_title = self.title;
    }else if ([self.type integerValue]==7){//餐厅详情分享
        list.share_title = self.group_share_title;
    }else if ([self.type integerValue]==8){//评论详情分享
        list.share_title = self.group_share_title;
    }
    list.share_hint = self.group_share_hint;
    list.share_url = self.umURL;
    if ([self.type integerValue]==5) {
        list.share_url = self.topic_id;
    }
    if ([self.type integerValue]==6) {
        list.share_title = self.title;
        list.share_hint = self.group_share_hint;
    }
    if ([self.type integerValue]==7||[self.type integerValue]==8) {
        list.share_url = self.topic_id;
    }
    UIViewController *vc = (UIViewController *)self.delegate;
    [vc.navigationController pushViewController:list animated:YES];
    
}

@end
