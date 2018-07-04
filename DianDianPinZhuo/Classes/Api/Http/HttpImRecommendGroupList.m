//
//  HttpImRecommendGroupList.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpImRecommendGroupList.h"
#import "ApiParseImRecommendGroupList.h"
#import "ReqImRecommendGroupList.h"
#import "RespImRecommendGroupList.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "NotJoinGroupModel.h"
#import "FDNotJoinGroupsFrame.h"
#import "ActiveUserModel.h"

#import "FDNotJoinGroupsViewController.h"
@implementation HttpImRecommendGroupList
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

- (void)loadRecommendGroupListWithController:(FDNotJoinGroupsViewController *)controller{
    
    [controller.activity startAnimating];
    ReqImRecommendGroupList *reqModel =[[ReqImRecommendGroupList alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.lat = [HQDefaultTool getLat];
    reqModel.lng = [HQDefaultTool getLng];
    ApiParseImRecommendGroupList *request=[[ApiParseImRecommendGroupList alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImRecommendGroupList *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            [controller.datyArray removeAllObjects];
            [controller.datyArray addObjectsFromArray:[self stausFramesWithStatuses:paseData.groups]];
            
            [controller.tableView reloadData];
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [controller.activity stopAnimating];
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        [controller.activity stopAnimating];
    }];

}
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (NotJoinGroupModel *status in statuses) {
        FDNotJoinGroupsFrame *f = [[FDNotJoinGroupsFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}


@end
