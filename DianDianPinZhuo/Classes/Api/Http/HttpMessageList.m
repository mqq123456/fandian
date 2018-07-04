//
//  HttpMessageList.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMessageList.h"
#import "ApiParseMessageList.h"
#import "ReqUserMessageListModel.h"
#import "RespUserMessageListModel.h"
#import "Toast+UIView.h"
#import "FDMessageViewController.h"
#import "FDMessageEditViewController.h"

@interface HttpMessageList ()

@end

@implementation HttpMessageList


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


/**
 *  第一次加载
 *
 */
- (void)loadFristController:(FDMessageViewController *)controller{
    [controller.activity startAnimating];
    ReqUserMessageListModel *reqModel=[[ReqUserMessageListModel alloc]init];
    reqModel.page = 1;
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseMessageList *request=[[ApiParseMessageList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserMessageListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.messages.count==0||paseData.messages==nil) {
                [controller.datyArray removeAllObjects];
                
                [controller reloadDataNULL:@"你还没有消息呢" imageName:@"null_message"];
            }else{
                [controller.datyArray removeAllObjects];
                controller.datyArray=paseData.messages;
                
                if (paseData.messages.count<8) {
                    controller.tableView.footer.hidden = YES;
                }else{
                    controller.tableView.footer.hidden = NO;
                }
            }
        }else{
            
            controller.page=0;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [controller.tableView reloadData];
        [controller.activity stopAnimating];
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.activity stopAnimating];
        controller.page=0;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
    
    
}
/**
 *  下拉刷新
 *
 */
- (void)MJRefreshTopController:(FDMessageViewController *)controller{
    ReqUserMessageListModel *reqModel=[[ReqUserMessageListModel alloc]init];
    reqModel.page = 1;
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseMessageList *request=[[ApiParseMessageList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserMessageListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.messages.count==0||paseData.messages==nil) {
                [controller.datyArray removeAllObjects];
            }else{
                [controller.datyArray removeAllObjects];
                controller.datyArray=paseData.messages;
                
            }
            [controller.tableView reloadData];
            [controller.tableView.header endRefreshing];
            [controller reloadDataNULL:@"你还没有消息呢" imageName:@"null_message"];
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            controller.page= 0;
            [controller.tableView.header endRefreshing];
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        controller.page= 0;
        [controller.tableView.header endRefreshing];
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
    
}

/**
 *  加载更多
 *
 */
- (void)MJRefreshMoreController:(FDMessageViewController *)controller{
    controller.page += 1;
    ReqUserMessageListModel *reqModel=[[ReqUserMessageListModel alloc]init];
    reqModel.page = controller.page;
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseMessageList *request=[[ApiParseMessageList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserMessageListModel *paseData=[request parseData:json];
        
        [controller.tableView.footer endRefreshing];
        
        if ([paseData.code isEqualToString:@"1"]) {
            
            
            if (paseData.messages.count==0||paseData.messages==nil) {
                //                [SVProgressHUD showImage:nil status:@"没有更多消息了"];
            }else{
                [controller.datyArray addObjectsFromArray:paseData.messages];
                
                [controller.tableView reloadData];
                
            }
            if (paseData.messages.count<8) {
                controller.tableView.footer.hidden = YES;
                //                [SVProgressHUD showImage:nil status:@"没有更多了！"];
                [controller.view makeToast:@"没有更多消息了！"];
                
            }else{
                controller.tableView.footer.hidden = NO;
            }
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            controller.page-=1;
        }
        
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.footer endRefreshing];
        controller.page-=1;
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];
    
    
    
}

/**
 *  消息编辑下拉
 *
 */
- (void)MJRefreshEditTopController:(FDMessageEditViewController *)controller{
    
}
/**
 *  消息编辑第一次
 *
 */
- (void)loadFristEditController:(FDMessageEditViewController *)controller deleteStr:(NSString *)delect{
    [controller.activity startAnimating];
    controller.page = 1;
    ReqUserMessageListModel *reqModel=[[ReqUserMessageListModel alloc]init];
    reqModel.page = controller.page;
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseMessageList *request=[[ApiParseMessageList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserMessageListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [controller.datyArray removeAllObjects];
            controller.datyArray=paseData.messages;
            if (paseData.messages.count==0||paseData.messages==nil) {
                [SVProgressHUD showImage:nil status:@" 没有消息啦 "];
                [controller.activity stopAnimating];
            }else{
                if (![delect isEqualToString:@""]) {
                    [SVProgressHUD showImage:nil status:@" 删除成功 "];
                }
            }
            if (paseData.messages.count<8) {
                controller.tableView.footer.hidden = YES;
            }else{
                controller.tableView.footer.hidden = NO;
            }
            [controller.tableView reloadData];
        }else{
            controller.page = 0;
        }
        
        [controller.activity stopAnimating];
        
        
    } failure:^(NSError *error) {
        controller.page = 0;
        MQQLog(@"%@",[error description]);
        [controller.activity stopAnimating];
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
    
    
}
/**
 *  消息编辑上拉
 *
 */
- (void)MJRefreshEditMoreController:(FDMessageEditViewController *)controller{
    
    controller.page += 1;
    ReqUserMessageListModel *reqModel=[[ReqUserMessageListModel alloc]init];
    reqModel.page = controller.page;
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseMessageList *request=[[ApiParseMessageList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserMessageListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [controller.datyArray addObjectsFromArray:paseData.messages];
            
            [controller.tableView reloadData];
            
            if (paseData.messages.count==0||paseData.messages==nil) {
                //                [SVProgressHUD showImage:nil status:@"没有更多消息了"];
            }
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            controller.page-=1;
        }
        if (paseData.messages.count<8) {
            controller.tableView.footer.hidden = YES;
            [controller.view makeToast:@"没有更多消息了！"];
        }else{
            controller.tableView.footer.hidden = NO;
        }
        [controller.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.footer endRefreshing];
        controller.page-=1;
        
    }];
    
    
}
@end
