//
//  FDScanViewController.h
//  PinZhuoMerchant
//
//  Created by user on 15/10/14.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPopoverListView.h"
#import <AVFoundation/AVFoundation.h>
#import "QRUtil.h"

@interface FDScanViewController : UIViewController
@property (nonatomic ,weak) UIPopoverListView *popoverListView;
@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;
- (void)doneBtnClick;
@end
