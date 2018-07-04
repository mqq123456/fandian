//
//  FDLoginViewController.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDLoginViewController.h"
#import "NSString+Verification.h"
#import "FDCouponsViewController.h"
#import "FDWebViewController.h"
#import "EaseMob.h"
#import "HttpGetCode.h"
#import "HttpUserLogin.h"
#import "FDLoginWeiXinView.h"
#import "FDBindingViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "AFNetworking.h"
#import "HttpUserWeixinCheck.h"
#import "SVProgressHUD.h"
#import "HttpUserInfo.h"
#import "HttpUserUpdateDevice.h"
@interface FDLoginViewController ()<UITextFieldDelegate,EMChatManagerLoginDelegate>{
    NSInteger secondsCountDown;
    NSTimer * countDownTimer;
    BOOL hasStoped;
    
}

@property (weak, nonatomic) UIButton *getBtn;
///倒数的label
@property(nonatomic,strong)UIButton *numbtn;



@end

@implementation FDLoginViewController
- (void)initContentView{
    /** 方便验证 */
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    //topLabel.text = @"为了方便你使用饭点，请验证手机号";
    topLabel.backgroundColor = FDColor(233, 233, 233, 1);
    topLabel.textColor = [UIColor darkGrayColor];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:topLabel];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 100)];
    [self.view addSubview:content];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 16, 20)];
    image1.image = [UIImage imageNamed:@"verification_ico_phone"];
    image1.centerY = 50/2;
    [content addSubview:image1];
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 16, 20)];
    image2.image = [UIImage imageNamed:@"verification_ico_vcode"];
    image2.centerY = 75;
    [content addSubview:image2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 49.75, [UIScreen mainScreen].bounds.size.width-30, 0.5)];
    line.backgroundColor = Background_Color;
    [content addSubview:line];
    
    
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, [UIScreen mainScreen].bounds.size.width-160, 50)];
    phone.borderStyle = UITextBorderStyleNone;
    phone.keyboardType = UIKeyboardTypeNumberPad;
    phone.placeholder = @"手机号";
    phone.textColor = FDColor(51, 51, 51, 1);
    phone.font = [UIFont systemFontOfSize:15];
    [content addSubview:phone];
    self.phone = phone;
    self.phone.delegate = self;
    
    UITextField *vcode = [[UITextField alloc] initWithFrame:CGRectMake(40, 50, [UIScreen mainScreen].bounds.size.width-50, 49)];
    vcode.borderStyle = UITextBorderStyleNone;
    vcode.placeholder = @"验证码";
    vcode.keyboardType = UIKeyboardTypeNumberPad;
    vcode.textColor = FDColor(51, 51, 51, 1);
    vcode.font = [UIFont systemFontOfSize:15];
    [content addSubview:vcode];
    self.vcode = vcode;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, 99.5, [UIScreen mainScreen].bounds.size.width-30, 0.5)];
    line1.backgroundColor = Background_Color;
    [content addSubview:line1];
    
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-75, 20, 60, 21);
    button.layer.cornerRadius = 10.5;
    button.clipsToBounds = YES;
    button.backgroundColor = FDColor(204, 204, 204, 1);
    [button setTitle:@"验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(vcodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:button];
    self.getBtn = button;
    
    
    UIButton *goBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    goBtn.frame = CGRectMake(25, 170, [UIScreen mainScreen].bounds.size.width-50 , 44);
    goBtn.layer.cornerRadius = 3;
    goBtn.clipsToBounds = YES;
    goBtn.backgroundColor = FDColor(248, 48, 48, 1);
    [goBtn setTitle:@"登录" forState:UIControlStateNormal];
    goBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBtn];
    
    UILabel *label1= [[UILabel alloc] initWithFrame:CGRectMake(25, 240, [UIScreen mainScreen].bounds.size.width-50, 21)];
    label1.text = @"点击登录，即表示你同意";
    label1.textColor = FDColor(102, 102, 102, 1);
    label1.font = [UIFont systemFontOfSize:14];
    [label1 sizeToFit];
    [self.view addSubview:label1];
    self.label1 = label1;
    UILabel *label2= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 240, [UIScreen mainScreen].bounds.size.width-50, 21)];
    label2.text = @"《饭点使用协议》";
    label2.textColor = FDColor(248, 48, 48, 1);
    label2.font = [UIFont systemFontOfSize:14];
    [label2 sizeToFit];
    [self.view addSubview:label2];
    self.label2 = label2;
    
    UIButton *protocalBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    protocalBtn.frame = CGRectMake(25, 240, [UIScreen mainScreen].bounds.size.width-50 , 30);
    protocalBtn.backgroundColor = [UIColor clearColor];
    protocalBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [protocalBtn addTarget:self action:@selector(protocolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocalBtn];
    
    
    [self.phone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.vcode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    [self.getBtn addSubview:self.numLabel];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindingPhone:) name:@"bindingPhone" object:nil];
    [self addTitleViewWithTitle:@"登录"];
    
    [self setNav];

    [self initContentView];
    
    [self addWeiXinView];
    
    
}
- (void)addWeiXinView{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        FDLoginWeiXinView *weixin = [[[NSBundle mainBundle] loadNibNamed:@"FDLoginWeiXinView" owner:nil options:nil]lastObject];
        [weixin.weixinBtn addTarget:self action:@selector(weixinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weixin];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIButton *)numLabel{
    
    if (!_numbtn) {
        _numbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 21)];
        
        [_numbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _numbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _numbtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _numbtn.userInteractionEnabled = NO;
    }
    return _numbtn;
    
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.translucent =NO;
    ///登陆页流量
    [MobClick event:@"pv_login"];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if (![[defaults objectForKey:@"timeInternal"] isEqualToString:@""]&& [defaults objectForKey:@"timeInternal"]) {
        NSString *selectInterval=[defaults objectForKey:@"timeInternal"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        
        //时间转时间戳的方法:当前时间的时间戳
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
        
        double cha = (long)([timeSp doubleValue]-[selectInterval doubleValue]);
        
        if (cha <60 && cha>0) {
            hasStoped = NO;
            secondsCountDown=60-cha;
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            [self.getBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            [self.numbtn setTitle:[NSString stringWithFormat:@"%d",60-(int)cha] forState:UIControlStateNormal];
            self.phone.text = [defaults objectForKey:@"phoneNumber"];
        }else{
            hasStoped = YES;
            secondsCountDown=60;
        }
        
        
    }else{
        hasStoped = YES;
        secondsCountDown=60;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [countDownTimer invalidate];
}

#pragma mark - Nav
- (void)setNav{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back3"] style:UIBarButtonItemStylePlain target:self action:@selector(cancleBtnClick)];
    backButton.imageInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    self.navigationItem.leftBarButtonItem= backButton;

}

#pragma mark - 输入框发生变化
- (void)textFieldDidChange:(UITextField *) TextField{
    if(TextField == self.phone){
        
        if (self.phone.text.length == 11) {
            self.getBtn.backgroundColor = [FDUtils colorWithHexString:@"#f0355c"];
            if (secondsCountDown != 60) {
                self.getBtn.enabled = NO;
            }else{
                self.getBtn.enabled = YES;
            }
        }else{
            self.getBtn.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            self.getBtn.enabled = NO;
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length==1) {
        return YES;
    }
    if (textField.text.length>=11) {
        return NO;
    }else{
        return YES;
    }
}
#pragma  mark - private
- (void)saveLastLoginUsername
{
    NSString *username = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
        [ud synchronize];
    }
}

- (NSString*)lastLoginUsername
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
    if (username && username.length > 0) {
        return username;
    }
    return nil;
}

#pragma mark - 登录
- (void)loginClick:(id)sender {
    if (self.phone.text.length==0) {
        [SVProgressHUD showImage:nil status:@" 请输入手机号 "];
        return;
    }else if(!(self.phone.text.length ==11)) {
        [SVProgressHUD showImage:nil status:@" 请输入正确的手机号 "];
        return;
    }else if (self.vcode.text.length==0){
        [SVProgressHUD showImage:nil status:@" 请输入验证码 "];
        return;
    }else if (![self.vcode.text isVcode]){
        [SVProgressHUD showImage:nil status:@" 请输入正确的验证码 "];
        return;
    }
    else{
        ///点击登录
        [MobClick event:@"click_login"];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *unionid = [defaults objectForKey:@"weixin_account"];
        if (!unionid) {
            unionid = @"";
        }
            HttpUserLogin *tool = [HttpUserLogin sharedInstance];
            [tool loadLoginClick:nil weixin_account:self.openid Controller:self];
    }
    
}
#pragma mark - 获取验证码

- (void)vcodeClick:(id)sender {
    
    ///点击获取验证码
    [MobClick event:@"click_captcha"];
    
    if([self validatePhone:self.phone.text]){
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        
        //        时间转时间戳的方法:当前时间的时间戳
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
        
        //MQQog(@"保存的时间戳:%@",timeSp); //时间戳的值
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:timeSp forKey:@"timeInternal"];
        [defaults setObject:self.phone.text forKey:@"phoneNumber"];
        [defaults synchronize];
        
        
        secondsCountDown=60;
        
        [self.getBtn setTitle:@"" forState:UIControlStateNormal];
        
        self.getBtn.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        
        [self.numbtn setTitle:[NSString stringWithFormat:@"%zd",secondsCountDown] forState:UIControlStateNormal];
        
        
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        self.getBtn.enabled=NO;
        
        HttpGetCode *getCode = [HttpGetCode sharedInstance];
        [getCode getCode:self.phone.text];
        
    }else{
        
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号"];
        
    }
    
    
}

#pragma mark - 倒计时
-(void)timeFireMethod{
    secondsCountDown--;
    [self.numbtn setTitle:[NSString stringWithFormat:@"%zd",secondsCountDown] forState:UIControlStateNormal];
    if (secondsCountDown<0) {
        secondsCountDown = 60;
        [countDownTimer invalidate];
        self.getBtn.enabled=YES;
        [self.getBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.getBtn.backgroundColor = [FDUtils colorWithHexString:@"#f0355c"];
        [self.numbtn setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)cancleBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 服务协议
- (void)protocolBtnClick:(id)sender {
    FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
    webView.url = [HQDefaultTool agreement_url];
    webView.titleString = @"服务协议";
    [self.navigationController pushViewController:webView animated:YES];
    
}
#pragma mark - 手机号验证
- (BOOL)validatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"1[0-9]{10}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{


}
- (void)weixinBtnClick{
    
    [self sendAuthRequest];
}
-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

- (void)bindingPhone:(NSNotification *)infoNoi{
    [SVProgressHUD showWithStatus:@"微信授权中..."];
    NSString*url=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx248654a2abf7326d",@"d4624c36b6795d1d99dcf0547af5443d",infoNoi.userInfo[@"code"]];
    AFHTTPRequestOperationManager *rom=[AFHTTPRequestOperationManager manager];

    [rom GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MQQLog(@"responseObject--%@",responseObject);

        [self refreshToken:responseObject[@"refresh_token"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"微信授权失败"];
        MQQLog(@"失败:%@",error);
    }];
    
    
    

}


- (void)refreshToken:(NSString *)refresh_token{

    NSString*url=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",@"wx248654a2abf7326d",refresh_token];
    AFHTTPRequestOperationManager *rom=[AFHTTPRequestOperationManager manager];
    //设置返回数据类型
//    rom.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/json",@"text/html",@"application/json", nil];
    [rom GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MQQLog(@"refresh_token--%@",responseObject);
        self.access_token = responseObject[@"access_token"];
        self.openid = responseObject[@"openid"];
        [self getWeiXinUserInfo];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"微信授权失败"];
        MQQLog(@"失败:%@",error);
    }];
    
}
- (void)getWeiXinUserInfo{
     NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",self.access_token,self.openid];
    AFHTTPRequestOperationManager *rom=[AFHTTPRequestOperationManager manager];
    //设置返回数据类型
    //    rom.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/json",@"text/html",@"application/json", nil];
    [rom GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.weixin_nickname = responseObject[@"nickname"];
        self.weixin_head = responseObject[@"headimgurl"];
        
        HttpUserWeixinCheck *tool = [HttpUserWeixinCheck sharedInstance];
        [tool weixinCheckWithController:self];
        
        MQQLog(@"refresh_token--%@",responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"微信授权失败"];
        MQQLog(@"失败:%@",error);
    }];

}
- (void)weixinCheck:(NSString *)kid{

    if ([kid isEqualToString:@""]) {
        FDBindingViewController *vc= [[FDBindingViewController alloc]init];

        vc.access_token = self.access_token;
        vc.openid = self.openid;
        vc.weixin_head = self.weixin_head;
        vc.weixin_nickname = self.weixin_nickname;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        HttpUserInfo *userInfo = [HttpUserInfo sharedInstance];
        [userInfo loadWithLoginViewController:self kid:kid];
        HttpUserUpdateDevice *userUpdate = [HttpUserUpdateDevice sharedInstance];
        [userUpdate loadUserUpdateDeviceWithKid:kid];
        
    }

}


@end
