//
//  FDWebViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "FDMerchantDetailController.h"
#import "MerchantModel.h"
#import "FDSubjectDetailViewController.h"
#import "FDHomeViewController.h"
#import "FDTopics.h"
#import "FDOrderViewController.h"
#import "FDLoginViewController.h"
#import "FDCouponsViewController.h"
#import "FDSponsorTopicViewController.h"
#import "FDShareView.h"

@interface FDWebViewController ()<UIWebViewDelegate,FDLoginViewControllerDelegate>
{
    NSDictionary *dict;
    FDShareView *shareView;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) UIActivityIndicatorView *activity;

@property (weak, nonatomic) NSString *tit;
@property (nonatomic, weak) NSString *dec;
@end

@implementation FDWebViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self addTitleViewWithTitle:self.titleString];
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.color = [UIColor grayColor];
    activity.center =CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-32) ;
    [self.view addSubview:activity];
    self.activity = activity;
    [self.activity startAnimating];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    //@"http://weixin.fundot.com.cn/h5/yiyuan/clear_cookie.html";
    [self.webView loadRequest:request];
//    @"http://weixin.fundot.com.cn/h5/yiyuan/qiangdao.html"
    //http://weixin.fundot.com.cn/h5/yiyuan/qiangdao_no.html
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"untitled" ofType:@"html"];
//    NSURL* url = [NSURL fileURLWithPath:path];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//    [self.webView loadRequest:request];
    
    
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    /**
     *  分享
     */
    context[@"shareTitle"] = ^(NSDictionary *json) {
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            dict = [self dictionaryWithJsonString:[NSString stringWithFormat:@"%@",jsVal]];
        }
        self.tit = dict[@"tit"];
        self.dec = dict[@"dec"];
        
    };
    
    
}

- (void)dismissWithIndex:(NSInteger)index{
    if (index==520) {
        FDCouponsViewController *coupons = [[FDCouponsViewController alloc] init];
        [self.navigationController pushViewController:coupons animated:YES];
    }
    if (index==1314) {
        FDOrderViewController *order = [[FDOrderViewController alloc] init];
        order.order_kind =[NSString stringWithFormat:@"%@",[dict objectForKey:@"order_kind"]];
        order.merchant_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"merchant_id"]];
        order.merchant_name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"merchant_name"]];
        order.icon = [NSString stringWithFormat:@"%@",[dict objectForKey:@"merchant_icon"]];
        order.kdate = [NSString stringWithFormat:@"%@",[dict objectForKey:@"kdate"]];
        order.kdate_desc = [NSString stringWithFormat:@"%@",[dict objectForKey:@"kdate_desc"]];
        order.meal_time = [NSString stringWithFormat:@"%@",[dict objectForKey:@"meal_time"]];
        order.price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
        order.people = [NSString stringWithFormat:@"%@",[dict objectForKey:@"people"]];
        order.meal_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"meal_id"]];
        order.menu_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"menu_id"]];
        order.people_desc = [NSString stringWithFormat:@"%@",[dict objectForKey:@"people_desc"]];
        order._paid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"paid"]];
        order.vacancy_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"vacancy_id"]];
        order.table_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"table_id"]];
        order.is_bz = [NSString stringWithFormat:@"%@",[dict objectForKey:@"is_bz"]];
        [self.navigationController pushViewController:order animated:YES];

    }
    if (index==114) {
        FDSponsorTopicViewController *makeTopic = [[FDSponsorTopicViewController alloc] init];
        [self.navigationController pushViewController:makeTopic animated:YES];
    }
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        [SVProgressHUD showImage:nil status:@"数据获取失败！"];
        return nil;
    }
    return dic;
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activity stopAnimating];
    
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __weak FDWebViewController *weakself = self;
    
   
    context[@"openMerchantDetail"] = ^(NSString *merchant_id) {
        
        FDMerchantDetailController *detail = [[FDMerchantDetailController alloc] init];
        
        detail.latString = [HQDefaultTool getLat];
        detail.lngString = [HQDefaultTool getLng];
        detail.local_lng = [HQDefaultTool getLng];
        detail.local_lat = [HQDefaultTool getLat];
        detail.local = @"1";
        
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            MerchantModel *model = [[MerchantModel alloc] init];
            model.merchant_id = [[NSString stringWithFormat:@"%@",jsVal] intValue];
            detail.model = model;
        }
        //
        [weakself.navigationController pushViewController:detail animated:YES];
        NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:weakself.navigationController.viewControllers];
        
        if ([[navigationarray objectAtIndex:navigationarray.count-2] isKindOfClass:[weakself class]]){
            [navigationarray removeObjectAtIndex:navigationarray.count-2];
            weakself.navigationController.viewControllers = navigationarray;
        }
        
    };
    context[@"openHuatiDetail"] = ^(NSString *topic_id) {
        
        FDSubjectDetailViewController *detail = [[FDSubjectDetailViewController alloc] init];
        
        detail.fromHtml5 = YES;
        detail.latString = [HQDefaultTool getLat];
        detail.lngString = [HQDefaultTool getLng];
        detail.local_lng = [HQDefaultTool getLng];
        detail.local_lat = [HQDefaultTool getLat];
        detail.local = 1;
        
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            FDTopics *model = [[FDTopics alloc] init];
            model.topic_id = [NSString stringWithFormat:@"%@",jsVal];
            detail.model = model;
        }
        [weakself.navigationController pushViewController:detail animated:YES];
        NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:weakself.navigationController.viewControllers];
        
        if ([[navigationarray objectAtIndex:navigationarray.count-2] isKindOfClass:[weakself class]]){
            [navigationarray removeObjectAtIndex:navigationarray.count-2];
            weakself.navigationController.viewControllers = navigationarray;
        }
    };
    context[@"openCantingList"] = ^() {
        [[NSNotificationCenter defaultCenter] postNotificationName:Html5PoPHome object:nil userInfo:@{@"index":@"0"}];
        [weakself.navigationController popToRootViewControllerAnimated:YES];
        
    };
    context[@"openHuatiList"] = ^() {
        [[NSNotificationCenter defaultCenter] postNotificationName:Html5PoPHome object:nil userInfo:@{@"index":@"1"}];
        [weakself.navigationController popToRootViewControllerAnimated:YES];
        
    };
    context[@"openHuatiDetail"] = ^(NSString *topic_id) {
        
        FDSubjectDetailViewController *detail = [[FDSubjectDetailViewController alloc] init];
        
        detail.fromHtml5 = YES;
        detail.latString = [HQDefaultTool getLat];
        detail.lngString = [HQDefaultTool getLng];
        detail.local_lng = [HQDefaultTool getLng];
        detail.local_lat = [HQDefaultTool getLat];
        detail.local = 1;
        
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            FDTopics *model = [[FDTopics alloc] init];
            model.topic_id = [NSString stringWithFormat:@"%@",jsVal];
            detail.model = model;
        }
        [weakself.navigationController pushViewController:detail animated:YES];
        NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:weakself.navigationController.viewControllers];
        
        if ([[navigationarray objectAtIndex:navigationarray.count-2] isKindOfClass:[weakself class]]){
            [navigationarray removeObjectAtIndex:navigationarray.count-2];
            weakself.navigationController.viewControllers = navigationarray;
        }
    };
    //一元抢购
    context[@"openZhifu"] = ^(NSString *topic_id) {
        
        
        
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            dict = [self dictionaryWithJsonString:[NSString stringWithFormat:@"%@",jsVal]];
        }
        //NSLog(@"======%@",dict);
        if (dict) {
            
            if ([[HQDefaultTool getKid] isEqualToString:@""]) {
                //如果没有登陆，要跳转到登录
                FDLoginViewController *login = [[FDLoginViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
                login.info_index = 1314;
                login.delegate = self;
                [weakself presentViewController:nav animated:YES completion:nil];
                return ;
            }else{
                [self dismissWithIndex:1314];
            }
            
            
        }
        
    };
    context[@"openYHQ"] = ^() {
        //NSLog(@"======================");
        [self.webView resignFirstResponder];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[HQDefaultTool getKid] isEqualToString:@""]) {
                //如果没有登陆，要跳转到登录
                
                FDLoginViewController *login = [[FDLoginViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
                login.info_index = 520;
                login.delegate = self;
                
                [weakself presentViewController:nav animated:YES completion:nil];
                return ;
            }
            FDCouponsViewController *coupons = [[FDCouponsViewController alloc] init];
            [weakself.navigationController pushViewController:coupons animated:YES];
            
        });
        
    };
    
    context[@"openFQHT"] = ^() {
 
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[HQDefaultTool getKid] isEqualToString:@""]) {
                //如果没有登陆，要跳转到登录
                
                FDLoginViewController *login = [[FDLoginViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
                login.info_index = 114;
                login.delegate = self;
                
                [weakself presentViewController:nav animated:YES completion:nil];
                return ;
            }
            FDSponsorTopicViewController *makeTopic = [[FDSponsorTopicViewController alloc] init];
            [weakself.navigationController pushViewController:makeTopic animated:YES];
            
        });
        
    };
    
    /**
     *  分享
     */
    context[@"shareTitle"] = ^(NSString *dec,NSString *tit) {
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            dict = [self dictionaryWithJsonString:[NSString stringWithFormat:@"%@",jsVal]];
        }
        self.tit = dict[@"tit"];
        self.dec = dict[@"dec"];
        shareView = [FDShareView shareView];
        shareView.type = @"6";
        shareView.delegate = self;
        shareView.umURL = self.url;
        shareView.title = self.tit;
        shareView.contText = self.dec;
        shareView.group_share_title = self.tit;
        shareView.group_share_hint = self.titleString;
        
        shareView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
        
    };
    
    NSString *alertJS=@"aa();"; //准备执行的js代码
    [context evaluateScript:alertJS];//通过oc方法调用js的alert
   
    

    
}
-(void)shareClick{
    if ([[HQDefaultTool getKid]isEqualToString:@""]) {
        //如果没有登陆，要跳转到登录
        FDLoginViewController *login = [[FDLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        return ;
    }
    [self.navigationController.view addSubview:shareView];
    
 
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activity startAnimating];
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    /**
     *  分享
     */
    context[@"shareTitle"] = ^(NSDictionary *json) {
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            dict = [self dictionaryWithJsonString:[NSString stringWithFormat:@"%@",jsVal]];
        }
        self.tit = dict[@"tit"];
        self.dec = dict[@"dec"];
        
    };
}
#pragma mark -
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //NSLog(@"======%@===",request);
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
