//
//  HttpImUserDetail.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/7.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpImUserDetail.h"
#import "ApiParseImUserDetail.h"
#import "ReqImUserDetailModel.h"
#import "RespImUserDetailModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "FDUserDetailViewController.h"
#import "HQHttpTool.h"
#import "PayResultView.h"
#import "FDScanViewController.h"
@implementation HttpImUserDetail
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

- (void)loadImUserDetailWithKid:(NSString *)kid viewController:(FDScanViewController *)controller{
    ReqImUserDetailModel *reqModel =[[ReqImUserDetailModel alloc]init];
    reqModel.kid = kid;
    
    ApiParseImUserDetail *request=[[ApiParseImUserDetail alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImUserDetailModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            FDUserDetailViewController *userDetail = [[FDUserDetailViewController alloc] init];
            userDetail.kid = kid;
            [controller.navigationController pushViewController:userDetail animated:YES];
            NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:controller.navigationController.viewControllers];
            
            if ([[navigationarray objectAtIndex:2] isKindOfClass:[controller class]]){
                [navigationarray removeObjectAtIndex:2];
                controller.navigationController.viewControllers = navigationarray;
            }

        }else{

            [controller.session stopRunning];
            [controller.popoverListView dismiss];
            //i=1;
            CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 40.0f;
            CGFloat yHeight = 200.0f;
            CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
            UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
            poplistview.listView.scrollEnabled = FALSE;
            poplistview.isTouchOverlayView = NO;
            [poplistview show];
            controller.popoverListView = poplistview;
            controller.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
            PayResultView *payResult = [[[NSBundle mainBundle] loadNibNamed:@"PayResultView" owner:nil options:nil]lastObject];
            payResult.frame = controller.popoverListView.bounds;
            payResult.title.text = @"扫描失败";
            [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
            payResult.detail.text = paseData.desc;
            [payResult.doneBtn addTarget:controller action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [poplistview addSubview:payResult];
            

        }
     
    } failure:^(NSError *error) {
        
        MQQLog(@"=======%@======",[error description]);
        [SVProgressHUD dismiss];
        [controller.session stopRunning];
        [controller.popoverListView dismiss];
//        i=1;
        CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 40.0f;
        CGFloat yHeight = 200.0f;
        CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
        UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
        poplistview.listView.scrollEnabled = FALSE;
        poplistview.isTouchOverlayView = NO;
        [poplistview show];
        controller.popoverListView = poplistview;
        controller.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
        PayResultView *payResult = [[[NSBundle mainBundle] loadNibNamed:@"PayResultView" owner:nil options:nil]lastObject];
        payResult.frame = controller.popoverListView.bounds;
        [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
        payResult.title.text = @"扫描失败";
        payResult.detail.text = @"联网失败，请检查网络";
        [payResult.doneBtn addTarget:controller action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [poplistview addSubview:payResult];
        
    }];

}

@end
