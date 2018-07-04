//
//  FDInvitationViewController.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDInvitationViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
@interface FDInvitationViewController ()<UMSocialUIDelegate,UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic, weak) UIActivityIndicatorView *activity;
@end

@implementation FDInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:[FDUtils addNavBarView]];
    [self addTitleViewWithTitle:@"有奖邀请"];
    self.view.backgroundColor = Background_Color;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64)];
    webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:webView];
    
    self.webView = webView;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.color = [UIColor grayColor];
    activity.center =CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-32) ;
    [self.view addSubview:activity];
    self.activity = activity;
    [self.activity startAnimating];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[HQDefaultTool getApp_invite_url]]];
    [self.webView loadRequest:request];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"invated"];

    
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activity stopAnimating];
    webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64-50);
    UIButton *invoiteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-114, [UIScreen mainScreen].bounds.size.width, 50)];
    invoiteBtn.backgroundColor = FDButtonColor;
    [invoiteBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [invoiteBtn setTitle:@"邀请微信好友" forState:UIControlStateNormal];
    [self.view addSubview:invoiteBtn];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activity startAnimating];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)shareClick{
    /**
     *  点击分享给饭友
     */
    [MobClick event:@"click_share"];
    
    NSString *contText = [HQDefaultTool getWeixin_invite_content];
    NSString *title = [HQDefaultTool getWeixin_invite_title];
    NSString *umURL = [HQDefaultTool getWeixin_invite_url];
    
    [UMSocialWechatHandler setWXAppId:@"wx248654a2abf7326d" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:umURL];
    [[UMSocialControllerService defaultControllerService] setShareText:contText shareImage:[UIImage imageNamed:@"share_image"] socialUIDelegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title =title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = umURL;
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
