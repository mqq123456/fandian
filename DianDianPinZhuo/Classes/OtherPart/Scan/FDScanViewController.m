//
//  FDScanViewController.m
//  PinZhuoMerchant
//
//  Created by user on 15/10/14.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDScanViewController.h"

#import "HQDefaultTool.h"
#import "HQHttpTool.h"
#import "SVProgressHUD.h"
#import "FDUserDetailViewController.h"
#import "HttpImUserDetail.h"
#import "HQConst.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FDScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView*_line;
    int i;
}


@end

@implementation FDScanViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫一扫";
    
    [self createView];
    
}


-(void)createView{
    
    
    //qrcode_scan_bg_Green_iphone5@2x.png  qrcode_scan_bg_Green@2x.png
    UIImage*image;
    if (IPHONE4) {
        image= [UIImage imageNamed:@"qrcode_scan_bg_Green_4.png"];
    }else{
        image= [UIImage imageNamed:@"qrcode_scan_bg_Green"];
    }
    
    float capWidth=image.size.width/2;
    float capHeight=image.size.height/2;
    
    image=[image stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight];
    UIImageView* bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    //bgImageView.contentMode=UIViewContentModeTop;
    bgImageView.clipsToBounds=YES;
    bgImageView.image=image;
    bgImageView.userInteractionEnabled=YES;
    [self.view addSubview:bgImageView];
    
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-220)/2, [UIScreen mainScreen].bounds.size.height/5.4, 220, 2)];
    if (IPHONE4) {
        _line.frame = CGRectMake((WIDTH-220)/2, [UIScreen mainScreen].bounds.size.height/13, 220, 2);
    }
    _line.image = [UIImage imageNamed:@"qrcode_scan_light_green.png"];
    [bgImageView addSubview:_line];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.session stopRunning];
    [self.preview removeFromSuperlayer];
    self.device=nil;
    self.input=nil;
    self.output=nil;
    self.session=nil;
    self.preview=nil;
    i=0;
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    AVCaptureConnection *outputConnection = [_output connectionWithMediaType:AVMediaTypeVideo];
    
    outputConnection.videoOrientation = [QRUtil videoOrientationFromCurrentDeviceOrientation];
    
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResize;
    _preview.frame =[QRUtil screenBounds];
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    _preview.connection.videoOrientation = [QRUtil videoOrientationFromCurrentDeviceOrientation];
    
    [_session startRunning];
    
    i=0;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.session stopRunning];
    [self.preview removeFromSuperlayer];
    self.device=nil;
    self.input=nil;
    self.output=nil;
    self.session=nil;
    self.preview=nil;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];

}

#pragma mark - 线的动画
-(void)animation
{
    
    [UIView animateWithDuration:2 animations:^{
        if (IPHONE4) {
            _line.frame = CGRectMake((WIDTH-220)/2, [UIScreen mainScreen].bounds.size.height/2-20, 220, 2);
        }else if (IPHONE5){
            _line.frame = CGRectMake((WIDTH-220)/2, [UIScreen mainScreen].bounds.size.height/2, 220, 2);
        }else if (IPhone6){
            _line.frame = CGRectMake((WIDTH-220)/2, [UIScreen mainScreen].bounds.size.height/2+5, 220, 2);
        }else if (IPhone6Plus){
            _line.frame = CGRectMake((WIDTH-220)/2, [UIScreen mainScreen].bounds.size.height/2+13, 220, 2);
        }
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            if (IPHONE4) {
                _line.frame = CGRectMake((WIDTH-220)/2, [UIScreen mainScreen].bounds.size.height/13, 220, 2);
            }else{
                _line.frame = CGRectMake((WIDTH-220)/2, [UIScreen mainScreen].bounds.size.height/5.4, 220, 2);
            }
            
        }];
        
    }];
    
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //NSString *stringValue;
    
    if (metadataObjects.count>0)
    {
        
        [_session stopRunning];
        
        if (i==0) {
            AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];

            NSString *kid = [metadataObject stringValue];
//            NSLog(@"===============%@",kid);
            
            HttpImUserDetail *detail = [HttpImUserDetail sharedInstance];
            [detail loadImUserDetailWithKid:kid viewController:self];
            
        }
        
    }
}
- (void)doneBtnClick{
    i=0;
    [_session startRunning];
    [self.popoverListView dismiss];
}

@end
