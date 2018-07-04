//
//  BBLaunchAdMonitor.m
//  Search
//
//  Created by iXcoder on 15/4/22.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import "BBLaunchAdMonitor.h"
#import "HQConst.h"
@import UIKit.UIScreen;
@import UIKit.UIImage;
@import UIKit.UIImageView;
@import UIKit.UIButton;
@import UIKit.UILabel;
@import UIKit.UIColor;
@import UIKit.UIFont;
@import QuartzCore.CALayer;

typedef NS_ENUM(NSInteger, BBLaunchAdProcess) {
    BBLaunchAdProcessFailed = -1,
    BBLaunchAdProcessNone ,
    BBLaunchAdProcessLoading ,
    BBLaunchAdProcessSuccess
};

NSString *BBLaunchAdDetailDisplayNotification = @"BBShowLaunchAdDetailNotification";

static BBLaunchAdMonitor *monitor = nil;

@interface BBLaunchAdMonitor()<NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
    
}

//@property (nonatomic, assign) BOOL imgLoaded;
@property (nonatomic, assign) BBLaunchAdProcess process;

@property (nonatomic, strong) NSMutableData *imgData;
@property (nonatomic, strong) NSURLConnection *conn;

@property (nonatomic, strong) NSMutableDictionary *detailParam;

@end


@implementation BBLaunchAdMonitor

+ (void)showAdAtPath:(NSString *)path onView:(UIView *)container timeInterval:(NSTimeInterval)interval detailParameters:(NSDictionary *)param
{
    if (![self validatePath:path]) {
        return ;
    }
    
    [[self defaultMonitor] loadImageAtPath:path];
    while ((monitor.process != BBLaunchAdProcessFailed) && (monitor.process != BBLaunchAdProcessSuccess) ) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
    }
    [monitor.detailParam removeAllObjects];
    [monitor.detailParam addEntriesFromDictionary:param];
    if (monitor.process == BBLaunchAdProcessFailed) {
        return ;
    }
    [self showImageOnView:container forTime:interval param:param];
}

+ (instancetype)defaultMonitor
{
    @synchronized (self) {
        if (!monitor) {
            monitor = [[BBLaunchAdMonitor alloc] init];
            monitor.detailParam = [NSMutableDictionary dictionary];
        }
        return monitor;
    }
}

+ (BOOL)validatePath:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:path];
    return url != nil;
}

+ (void)showImageOnView:(UIView *)container forTime:(NSTimeInterval)time param:(NSDictionary *)param
{
    CGRect f = [UIScreen mainScreen].bounds;
//    NSLog(@"screen size:%@", NSStringFromCGRect(f));
    UIView *v = [[UIView alloc] initWithFrame:f];
    v.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:f];
    iv.image = [UIImage imageWithData:monitor.imgData];
    monitor.conn = nil;
    [monitor.imgData setLength:0];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = YES;
    [v addSubview:iv];
    
    [container addSubview:v];
    [container bringSubviewToFront:v];
    
    UIButton *showDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   
    showDetailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    showDetailBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    [showDetailBtn addTarget:self action:@selector(showAdDetail:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:showDetailBtn];
    if (param) {
        showDetailBtn.enabled = NO;
    }else{
        showDetailBtn.enabled = YES;
    }
   
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        v.userInteractionEnabled = NO;
        [UIView animateWithDuration:.25
                         animations:^{
                             v.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             [v removeFromSuperview];
                             [[NSNotificationCenter defaultCenter] postNotificationName:HomeAds object:nil];
                         }];
    });
}

+ (void)showAdDetail:(id)sender
{
    UIView *sup = [(UIButton *)sender superview];
    sup.userInteractionEnabled = NO;
    [UIView animateWithDuration:.25
                     animations:^{
                         sup.alpha = 0.0f;
                         [[NSNotificationCenter defaultCenter] postNotificationName:BBLaunchAdDetailDisplayNotification
                                                                             object:monitor.detailParam];
                         [monitor.detailParam removeAllObjects];
                     }
                     completion:^(BOOL finished) {
                         [sup removeFromSuperview];
                         
                     }];
    
}

- (void)loadImageAtPath:(NSString *)path
{
    NSURL *URL = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    request = [NSURLRequest requestWithURL:URL cachePolicy:0 timeoutInterval:10.];
    self.conn = [NSURLConnection connectionWithRequest:request delegate:self];
    if (self.conn) {
        self.process = BBLaunchAdProcessLoading;
        [self.conn start];
    }
}

#pragma mark - NSURLConnectionDataDelegate method
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    if (resp.statusCode != 200) {
//        self.imgLoaded = YES;
        self.process = BBLaunchAdProcessFailed;
        return ;
    }
    self.imgData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imgData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    self.imgLoaded = YES;
    self.process = BBLaunchAdProcessSuccess;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    NSLog(@"图片数据获取失败");
//    self.imgLoaded = YES;
    self.process = BBLaunchAdProcessFailed;
}

@end

