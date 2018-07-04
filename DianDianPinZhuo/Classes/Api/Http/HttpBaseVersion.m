//
//  HttpBaseVersion.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpBaseVersion.h"
#import "ApiParseBaseVersion.h"
#import "RequestModel.h"
#import "ReqBaseVersionModel.h"
#import "RespBaseVersionModel.h"
#import "VersionModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "UIPopoverListView.h"
#import "PayFail.h"
#import "FDHomeViewController.h"
@implementation HttpBaseVersion
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

- (void)getVersionWithContoller:(FDHomeViewController *)viewController{
    ReqBaseVersionModel *reqModel=[[ReqBaseVersionModel alloc]init];
    reqModel.cver = APP_VERSION;
    reqModel.platform = @"0";
    ApiParseBaseVersion *request=[[ApiParseBaseVersion alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespBaseVersionModel *paseData = [request parseData:json];

        if ([paseData.code isEqualToString:@"1"]) {//更新版本
            if ([paseData.is_new intValue]==1) {//更新版本
                
                CGRect  tipsRect = [[NSString stringWithFormat:@"%@",paseData.tips] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
                
                
                [HQDefaultTool setVerUrl:paseData.url];
                [viewController.popoverListView dismiss];
                CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 40.0f;
                CGFloat yHeight = 180+tipsRect.size.height;
                CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
                [viewController.popoverListView dismiss];
                UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
                poplistview.listView.scrollEnabled = FALSE;
                poplistview.isTouchOverlayView = YES;
                [poplistview show];
                viewController.popoverListView = poplistview;
                viewController.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
                PayFail *payResult = [[[NSBundle mainBundle] loadNibNamed:@"PayFail" owner:nil options:nil]lastObject];
                payResult.frame = viewController.popoverListView.bounds;
                payResult.title.text = paseData.title;
                payResult.detail.text =paseData.tips;
                payResult.detail.textAlignment = NSTextAlignmentLeft;
                [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
                payResult.detail.textAlignment = NSTextAlignmentLeft;
                [payResult.doneBtn setTitle:@"立刻更新" forState:UIControlStateNormal];
                [payResult.cancleBtn setTitle:@"下次再说" forState:UIControlStateNormal];
                [payResult.doneBtn addTarget:viewController action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [payResult.cancleBtn addTarget:viewController action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [poplistview addSubview:payResult];


            }
            
        }

        
    } failure:^(NSError *error) {
        MQQLog(@"--%@",[error description]);
    }];
    
}
@end
