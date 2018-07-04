//
//  QRUtil.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/10/9.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRUtil.h"
#import "HQConst.h"

@implementation QRUtil


+ (CGRect)screenBounds {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenRect;
    if (![screen respondsToSelector:@selector(fixedCoordinateSpace)] && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
//        screenRect = CGRectMake(screen.bounds.origin.x, screen.bounds.origin.y, screen.bounds.size.height, screen.bounds.size.width);
        screenRect = CGRectMake(0, 0, screen.bounds.size.height, screen.bounds.size.width);
    } else {
        screenRect = screen.bounds;
    }
    
    return screenRect;
    
}

+ (AVCaptureVideoOrientation) videoOrientationFromCurrentDeviceOrientation {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        //MQQLog(@"UIInterfaceOrientationPortrait");
        return AVCaptureVideoOrientationPortrait;
        
    } else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        //MQQLog(@"AVCaptureVideoOrientationLandscapeLeft");
        return AVCaptureVideoOrientationLandscapeLeft;
        
    } else if (orientation == UIInterfaceOrientationLandscapeRight){
        //MQQLog(@"UIInterfaceOrientationLandscapeRight");
        return AVCaptureVideoOrientationLandscapeRight;
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        //MQQLog(@"UIInterfaceOrientationPortraitUpsideDown");
        return AVCaptureVideoOrientationPortraitUpsideDown;
    }
    
    return AVCaptureVideoOrientationPortrait;
}
@end
