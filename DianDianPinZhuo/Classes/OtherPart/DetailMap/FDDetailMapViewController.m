//
//  FDDetailMapViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FDDetailMapViewController.h"
#import "FDMapMerchantView.h"
@interface FDDetailMapViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation FDDetailMapViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self addTitleViewWithTitle:self.name];
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate=self;
    [self.view addSubview:_mapView];
    //是否能够缩放和滚动
    _mapView.scrollEnabled=YES;
    _mapView.rotateEnabled = NO;
    _mapView.zoomEnabled=YES;
    self.mapView.showsUserLocation=YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake([self.lat doubleValue], [self.lng doubleValue]);
    MKCoordinateSpan spen=MKCoordinateSpanMake(0.01, 0.01);
    _mapView.region=MKCoordinateRegionMake(coordinate, spen);
    [self.view addSubview:_mapView];
    //添加地图标记
    MKPointAnnotation *annotation=[[MKPointAnnotation alloc]init];
    annotation.coordinate=coordinate;
    //弹出选择位置
//    annotation.title = self.name;
//    annotation.subtitle = self.address;

    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    location.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height-50, 30, 30);
    [location setBackgroundImage:[UIImage imageNamed:@"bow_ico_fandianbiaoji"] forState:UIControlStateNormal];
    [location addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:location];
    
    self.urlScheme = @"DianDianPinZhuo://";
    self.appName = @"DianDianPinZhuo";
    self.coordinate = coordinate;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导航" style:UIBarButtonItemStylePlain target:self action:@selector(navClick)];
    
    
    FDMapMerchantView *merchant_detail = [[[NSBundle mainBundle]loadNibNamed:@"FDMapMerchantView" owner:nil options:nil]lastObject];
    merchant_detail.merchant_name.text = self.name;
    merchant_detail.address.text = self.address;
    [self.view addSubview:merchant_detail];
    
    
    
    
    
    
    
    
    
    
    
}

#pragma mark - locationClick
- (void)locationClick{
    if (self.mapView.userTrackingMode != MKUserTrackingModeFollowWithHeading)
    {
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    }
}

#pragma mark -
- (void)navClick{
    __block NSString *urlScheme = self.urlScheme;
    __block NSString *appName = self.appName;
    __block CLLocationCoordinate2D coordinate = self.coordinate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //这个判断其实是不需要的
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            MQQLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            MQQLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            MQQLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
