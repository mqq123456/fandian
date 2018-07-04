//
//  FDQrCodeViewController.m
//  扫一扫
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDQrCodeViewController.h"
#import "UIImage+MDQRCode.h"
#import "QRCodeGenerator.h"
#import "UIImageView+WebCache.h"
@interface FDQrCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headW;
@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *hometown;

@end

@implementation FDQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:[FDUtils addNavBarView]];
    
    self.title = @"我的二维码";
    if (IPHONE4||IPHONE5) {
        self.headW.constant = 55;
        self.head.layer.cornerRadius = 55/2;
    }
    [self.head sd_setImageWithURL:[NSURL URLWithString:[HQDefaultTool getHead]] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.head.image = image;
    }];
    self.qrCodeImageView.image = [QRCodeGenerator qrImageForString:[HQDefaultTool getKid] imageSize:self.qrCodeImageView.frame.size.width];
    
    NSString *nickNime = [HQDefaultTool getNickName];
    self.userName.text = nickNime;
    if (nickNime.length>8) {
        if (IPHONE4||IPHONE5) {
            self.userName.text = [NSString stringWithFormat:@"%@...",[nickNime substringToIndex:8]];
        }
    }
    if ([HQDefaultTool getOccupation]&&[[HQDefaultTool getOccupation]isEqualToString:@""]) {
        self.hometown.text = [HQDefaultTool getOccupation_default];
    }else{
        self.hometown.text = [NSString stringWithFormat:@"%@-%@",[HQDefaultTool getIndustry],[HQDefaultTool getOccupation]];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
