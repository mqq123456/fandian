//
//  FDTicketShareView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTicketShareView.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "HQDefaultTool.h"
#import "FDUtils.h"

@implementation FDTicketShareView
+(instancetype)ticketShareView:(NSString *)Weixin_invite_url andTitle:(NSString *)Weixin_invite_title andContent:(NSString *)Weixin_invite_content{
    static FDTicketShareView *share=nil;
    if(share==nil)
    {
        share=[[NSBundle mainBundle]loadNibNamed:@"FDTicketShareView" owner:nil options:nil][0];
    }
    share.umURL = Weixin_invite_url;
    share.title = Weixin_invite_title;
    share.contText = Weixin_invite_content;
    return share;
    
}

- (void)awakeFromNib {
    // Initialization code
//    [self.shareBtn addTarget:self action:@selector(weChatBtncircleFriendClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//   NSString * content  = self.topText.text;
//    NSMutableDictionary *heightLightDict=[NSMutableDictionary dictionary];
//    heightLightDict[NSFontAttributeName]=[UIFont systemFontOfSize:28];
//    heightLightDict[NSForegroundColorAttributeName]=[FDUtils colorWithHexString:@"#ee2e45"];
//    NSMutableAttributedString *attributeTitle=[[NSMutableAttributedString alloc] initWithString:content attributes:heightLightDict];
//    
//    NSRange firshRange1=[content rangeOfString:@"还有"];
//    NSRange firshRange2=[content rangeOfString:@"张一元饭票"];
//    [attributeTitle addAttribute:NSForegroundColorAttributeName value:[FDUtils colorWithHexString:@"#222222"] range:firshRange1];
//    [attributeTitle addAttribute:NSForegroundColorAttributeName value:[FDUtils colorWithHexString:@"#222222"] range:firshRange2];
//    [attributeTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:firshRange1];
//    [attributeTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:firshRange2];
//    [self.topText setAttributedText:attributeTitle];
}
//- (void)weChatBtncircleFriendClick:(UIButton *)sender{
//    [self removeFromSuperview];
//    NSString *contText = self.contText;;
//    NSString *title = self.title;
//    NSString *umURL = self.umURL;
//    
//    
//
//    [UMSocialWechatHandler setWXAppId:@"wx248654a2abf7326d" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:umURL];
//    [[UMSocialControllerService defaultControllerService] setShareText:contText shareImage:[UIImage imageNamed:@"share_image"] socialUIDelegate:self];
//    
//    [UMSocialData defaultData].extConfig.wechatSessionData.title =title;
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = umURL;
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(nil,[UMSocialControllerService defaultControllerService],YES);
//}

- (void)cancleClick:(UIButton *)sender {
    [self removeFromSuperview];

}
@end
