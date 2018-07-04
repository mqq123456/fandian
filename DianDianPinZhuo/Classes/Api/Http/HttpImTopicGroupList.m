//
//  HttpImTopicGroupList.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpImTopicGroupList.h"
#import "FDTopicsViewController.h"
#import "ApiParseImTopicGroupList.h"
#import "ReqImTopicGroupList.h"
#import "RespImTopicGroupList.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "NotJoinGroupModel.h"
#import "ActiveUserModel.h"
#import "FDNotJoinGroupsFrame.h"

@implementation HttpImTopicGroupList
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
 *  第一次加载群组数据
 */
- (void)loadFristImGroupListWithController:(FDTopicsViewController *)controller{

    ReqImTopicGroupList *reqModel =[[ReqImTopicGroupList alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.lat = controller.latString;
    reqModel.lng = controller.lngString;
    ApiParseImTopicGroupList *request=[[ApiParseImTopicGroupList alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImTopicGroupList *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            controller.im_list_load_success = YES;
            if ([paseData.state intValue]==1&&paseData.groups.count>0) {//已加入的群
                [controller.groupArray removeAllObjects];
                [controller.groupArray_desc removeAllObjects];
                [controller.groupArray_desc addObjectsFromArray: paseData.groups];
                [controller getGroupInfo];
            }else{//
                if (paseData.groups &&paseData.groups.count!=0) {
                    
                    [controller.groupArray removeAllObjects];
                    [controller.groupArray addObjectsFromArray:[self stausFramesWithStatuses:paseData.groups]];
                    /**
                     *  如果话题列表加载完了。群组列表也加载完了，且上次打开的是找饭友界面
                     */
                    if (controller.topic_list_load_success&&controller.im_list_load_success) {
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        //显示第0页
                        if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] isEqualToString:@"1"]){
                            //[SVProgressHUD dismiss];
                        }
                        
                    }
                }else{
                    /**
                     *  如果话题列表加载完了。群组列表也加载完了，且上次打开的是找饭友界面
                     */
                    if (controller.topic_list_load_success&&controller.im_list_load_success) {
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        //显示第0页
                        if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] isEqualToString:@"1"]){
                            //[SVProgressHUD dismiss];
                        }
                        
                    }
                }
            }
            
        }else{//加载失败
            [controller.groupArray removeAllObjects];
            /**
             *  如果话题列表加载完了。群组列表也加载完了，且上次打开的是找饭友界面
             */
            if (controller.topic_list_load_success&&controller.im_list_load_success) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                //显示第0页
                if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] isEqualToString:@"1"]){
                    //[SVProgressHUD dismiss];
                    [SVProgressHUD showImage:nil status:paseData.desc];
                }
                
            }
        }
        [controller.tableView reloadData];
    } failure:^(NSError *error) {
        [controller.tableView reloadData];
        controller.im_list_load_success = YES;
        
        /**
         *  如果话题列表加载完了。群组列表也加载完了，且上次打开的是找饭友界面
         */
        if (controller.topic_list_load_success&&controller.im_list_load_success) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //显示第0页
            if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] isEqualToString:@"1"]){
                //[SVProgressHUD dismiss];
                [SVProgressHUD showImage:nil status:@"网络连接失败！"];
            }
            
        }
    }];
    
}


- (void)loadImGroupListWithController:(FDTopicsViewController *)controller{
    
    
    ReqImTopicGroupList *reqModel =[[ReqImTopicGroupList alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.lat = controller.latString;
    reqModel.lng = controller.lngString;
    ApiParseImTopicGroupList *request=[[ApiParseImTopicGroupList alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImTopicGroupList *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            if ([paseData.state intValue]==1&&paseData.groups.count>0) {//已加入的群
                [controller.groupArray removeAllObjects];
                [controller.groupArray_desc removeAllObjects];
                [controller.groupArray_desc addObjectsFromArray: paseData.groups];
                [controller getGroupInfo];
            }else{//
                if (paseData.groups &&paseData.groups.count!=0) {
                    
                    [controller.groupArray removeAllObjects];
                    [controller.groupArray addObjectsFromArray:[self stausFramesWithStatuses:paseData.groups]];
                    
                }else{
                    [controller.groupArray removeAllObjects];
                    [controller.groupArray_desc removeAllObjects];
                }
            }
            
        }else{//加载失败
            [controller.groupArray removeAllObjects];
            [controller.groupArray_desc removeAllObjects];
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [controller.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        [controller.groupArray removeAllObjects];
        [controller.groupArray_desc removeAllObjects];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [controller.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }];
    
}
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (NotJoinGroupModel *status in statuses) {
        status.gap_hiden = YES;
        FDNotJoinGroupsFrame *f = [[FDNotJoinGroupsFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}
@end
