//
//  HttpImGroupId.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpImGroupId.h"
#import "ApiParseImGroupId.h"
#import "ReqImGroupIdModel.h"
#import "RespImGroupIdModel.h"
#import "RequestModel.h"
#import "ChatViewController.h"
#import "SVProgressHUD.h"
#import "HQHttpTool.h"
#import "FDGroupDetailTool.h"
#import "HQConst.h"
#import "RootGroupTableViewController.h"
@implementation HttpImGroupId
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

- (void)imGroupIdWithOrder_no:(NSString *)order_no table_id:(NSString *)table_id viewController:(RootGroupTableViewController *)viewController button:(UIButton *)btn{
    
    ReqImGroupIdModel *reqModel =[[ReqImGroupIdModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.order_no = order_no;
    reqModel.table_id = table_id;
    
    ApiParseImGroupId *request=[[ApiParseImGroupId alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImGroupIdModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if ([paseData.group_id intValue]==0) {
                [SVProgressHUD showImage:nil status:@" 没有可用讨论组 "];
                btn.enabled = YES;
            }else{
                btn.enabled = YES;
                
                
                //                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",paseData.group_id],@"group_id",[HQDefaultTool getKid],@"kid", nil];
                //                    [[FDGroupDetailTool sharedInstance] addGroupJoined:dic group_idString:[NSString stringWithFormat:@"%@",paseData.group_id]];
                
                
                ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:paseData.group_id conversationType:eConversationTypeGroupChat];
                [chatController addTitleViewWithTitle:paseData.group_name];
                //                chatController.title = paseData.group_name;

                [viewController.navigationController pushViewController:chatController animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:JoinInOrOutGroup object:nil];
            }
            
        }else{
            btn.enabled = YES;
            [SVProgressHUD showImage:nil status:paseData.desc];
            
        }
        
    } failure:^(NSError *error) {
        btn.enabled = YES;
        MQQLog(@"error -----%@------",error);
    }];
    
}
@end
