//
//  HttpBaseAds.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpBaseAds.h"
#import "ApiParseBaseAds.h"
#import "ReqBaseAds.h"
#import "RespBaseAds.h"
#import "RequestModel.h"
#import <UIKit/UIKit.h>
#import "HQConst.h"
#import "HQMD5Tool.h"
#import "HQHttpTool.h"
#import "AdView.h"
#import "AdsHomeModel.h"
#import "FDWebViewController.h"
#import "FDUUidManager.h"
#import "HttpUserAdNotify.h"

#import "FDHomeViewController.h"
#import "AdsHomeModel.h"
#import "FDCouponsViewController.h"
#import "FDLoginViewController.h"
#import "FDWebViewController.h"
#import "FDCouponsViewController.h"

@implementation HttpBaseAds

#pragma mark -  获取单例对象
static id _instace;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}


- (void)loadBaseAdsWithViewController:(FDHomeViewController *)viewController {
    
    ReqBaseAds *reqModel =[[ReqBaseAds alloc]init];
    if ([FDUUidManager sharedManager].imei==nil) {
        [FDUUidManager sharedManager].imei=[HQMD5Tool md5:[HQDefaultTool getUuid]];
        [[FDUUidManager sharedManager] saveUserinfo];
        
    }
    
    reqModel.imei=[FDUUidManager sharedManager].imei;
    
    
    ApiParseBaseAds *request=[[ApiParseBaseAds alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespBaseAds *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            

            viewController.adsArray = paseData.ads;
            
            if (paseData.ads.count>0) {
                /**
                 *  首页广告流量
                 */
                [MobClick event:@"pv_advertisement"];

                    if ([viewController.navigationController.topViewController isKindOfClass:[FDHomeViewController class]]) {
                        [viewController.navigationController.view addSubview:viewController.adView];
                    }

                
                CGFloat left;
                if (IPhone6Plus) {
                    left = 50;
                }else{
                    
                    left = 30;
                }
                
                if (paseData.ads.count<=1) {
                    UIImageView *imageView = [[UIImageView alloc] init];
                    imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - left*2, ([UIScreen mainScreen].bounds.size.width - left*2)*376/300);
                    [viewController.adView.adImageView addSubview:imageView];
                    if (paseData.ads.count==0) {
                        imageView.image = [UIImage imageNamed:@"ad_image"];
                    }else{
                        AdsHomeModel *model = paseData.ads[0];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"ad_image"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            imageView.image = image;
                        }];
                    }
                    imageView.userInteractionEnabled = YES;
                    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:viewController action:@selector(adViewClick)]];
                    
                }else{
                    
                    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
                    
                    for (AdsHomeModel *model in paseData.ads) {
                        [imageArray addObject:model.img];
                    }
                    
                    AdView *adview = [AdView adScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - left*2, ([UIScreen mainScreen].bounds.size.width - left*2)*376/300) imageLinkURL:imageArray placeHoderImageName:@"ad_image" pageControlShowStyle:UIPageControlShowStyleCenter];
                    
                    adview.pageControl.currentPageIndicatorTintColor = FDColor(244, 174, 53, 1);
                    adview.pageControl.pageIndicatorTintColor = FDColor(153, 153, 153, 1);
                    
                    adview.callBack = ^(NSInteger index,NSString * imageURL)
                    {
                        [viewController.adView removeFromSuperview];
                        /**
                         *  首页广告点击
                         */
                        [MobClick event:@"click_advertisement"];
                        AdsHomeModel *model = paseData.ads[index];
                        if ([model.url isEqualToString:@""]) {
                            return;
                        }
                        if ([model.url isEqualToString:@"coupon"]) {
                            if (![[HQDefaultTool getKid] isEqualToString:@""]) {
                                FDCouponsViewController *coupons = [[FDCouponsViewController alloc] init];
                                [viewController.navigationController pushViewController:coupons animated:YES];
                            }else{
                                FDLoginViewController *verification = [[FDLoginViewController alloc] init];
                                verification.isFirst = YES;
                                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
                                [viewController presentViewController:nav animated:YES completion:nil];
                                
                            }
                            
                        }else if([model.url isEqualToString:@"login"]){
                            if (![[HQDefaultTool getKid] isEqualToString:@""]) {
                                return;
                            }
                            
                            FDLoginViewController *verification = [[FDLoginViewController alloc] init];
                            
                            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verification];
                            [viewController presentViewController:nav animated:YES completion:nil];
                            
                        }else{
                            
                            FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
                            
                            webView.url = model.url;
                            webView.titleString = model.title;
                            [viewController.navigationController pushViewController:webView animated:YES];
                        }
                        
                        if (![[HQDefaultTool getKid] isEqualToString:@""]) {
                            HttpUserAdNotify *adNotify = [HttpUserAdNotify sharedInstance];
                            if (model.ads_id) {
                                [adNotify loadUserAdNotifyWithAd_id:model.ads_id];
                            }
                            
                            
                        }

                        
                    };
                    
                    
                    [viewController.adView.adImageView addSubview:adview];
                    
                    
                    
                    
                }
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
        MQQLog(@"error -----%@------",error);
    }];
    
    
    
}



@end
