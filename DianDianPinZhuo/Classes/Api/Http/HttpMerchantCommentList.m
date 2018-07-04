//
//  HttpMerchantCommentList.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMerchantCommentList.h"
#import "MJRefresh.h"
#import "HQHttpTool.h"
#import "CommentModel.h"
#import "ApiParseMerchantCommentList.h"
#import "ReqMerchantCommentListModel.h"
#import "RespMerchantCommentListModel.h"
#import "RequestModel.h"
#import "Toast+UIView.h"
#import "FDCommentFrame.h"
#import "HQCommentViewController.h"

@interface HttpMerchantCommentList ()

@property (nonatomic ,assign) int page;

@end
@implementation HttpMerchantCommentList
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

- (void)commentListWithMerchant_id:(NSString *)merchant_id controller:(HQCommentViewController *)controller{
    _page = 1;
    ReqMerchantCommentListModel *reqModel=[[ReqMerchantCommentListModel alloc]init];
    reqModel.page = _page;
    reqModel.merchant_id = merchant_id;
    ApiParseMerchantCommentList *request=[[ApiParseMerchantCommentList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespMerchantCommentListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.comments.count==0||paseData.comments==nil) {
                [SVProgressHUD showImage:nil status:@"还没有评论呢！"];
                
            }else{
                [controller.dataArray removeAllObjects];
                 [controller.dataArray addObjectsFromArray:[self stausFramesWithStatuses:paseData.comments]];
                [controller.tableView reloadData];
            }
        }else{
            _page = 0;
        }
        if (paseData.comments.count<8) {
            controller.tableView.footer.hidden = YES;
        }else{
            controller.tableView.footer.hidden = NO;
        }
        
        [controller.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        _page = 0;
        [controller.tableView.header endRefreshing];
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];

}
- (void)loadMoreMerchantCommentListMerchant_id:(NSString *)merchant_id controller:(HQCommentViewController *)controller{
    _page += 1;
    ReqMerchantCommentListModel *reqModel=[[ReqMerchantCommentListModel alloc]init];
    reqModel.page = _page;
    reqModel.merchant_id = merchant_id;
    ApiParseMerchantCommentList *request=[[ApiParseMerchantCommentList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespMerchantCommentListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.comments.count==0||paseData.comments==nil) {
//                [SVProgressHUD showImage:nil status:@"没有更多评论了！"];
            }else{

                [controller.dataArray addObjectsFromArray:[self stausFramesWithStatuses:paseData.comments]];
                [controller.tableView reloadData];
            }
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            _page-=1;
        }
        if (paseData.comments.count<8) {
            controller.tableView.footer.hidden = YES;
//            [SVProgressHUD showImage:nil status:@"没有更多评论了！"];
            [controller.view makeToast:@"没有更多评论了！"];
        }else{
            controller.tableView.footer.hidden = NO;
        }
        [controller.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.footer endRefreshing];
        _page-=1;
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];

}
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (CommentModel *status in statuses) {
        FDCommentFrame *f = [[FDCommentFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}


@end
