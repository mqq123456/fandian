//
//  HttpTopicSearch.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpTopicSearch.h"
#import "ApiTopicSearch.h"
#import "ReqTopicSearchModel.h"
#import "RespTopicSearchModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "FDTopics.h"
#import "FDTopicsFrame.h"
#import "HMLoadMoreFooter.h"
#import "FDTopicsViewController.h"
#import "FDTopicsTool.h"
@implementation HttpTopicSearch
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

- (void)topicSearchWithLat:(NSString *)latString lng:(NSString *)lngString  topic_class_id:(NSString *)topic_class_id  viewController:(FDTopicsViewController *)controller{
    
    ReqTopicSearchModel*reqModel =[[ReqTopicSearchModel alloc]init];
    self.page = 1;
    reqModel.lat = latString;
    reqModel.lng = lngString;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = self.page;
    reqModel.class_id = topic_class_id;

    ApiTopicSearch *request=[[ApiTopicSearch alloc]init];
//    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [FDLoadingGifHUD showLoadingGifHUD];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
      //  [SVProgressHUD dismiss];
        RespTopicSearchModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            if (paseData.topic!=nil&&paseData.topic.count!=0) {//如果数组不为空
                
                [controller.datyArray removeAllObjects];
                FDTopicsTool *tool = [FDTopicsTool sharedInstance];
                [tool saveStatuses:paseData.topic];
                
                
                NSArray *newFrames = [self stausFramesWithStatuses:paseData.topic];
                [controller.datyArray addObjectsFromArray:newFrames];
                
                
            }else{
                
            }
            if (paseData.topic.count<20) {
                controller.tableView.footer.hidden = YES;
            }else{
                controller.tableView.footer.hidden = NO;
            }
            
            if (paseData.topic.count==0) {
                [controller.footer removeFromSuperview];
                controller.tableView.tableFooterView = nil;
                [controller.datyArray removeAllObjects];
            }else{
                if (paseData.topic.count<20) {
                    if (controller.footer==nil) {
                        HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
                        controller.tableView.tableFooterView = footer;
                        footer.frame = CGRectMake(0, 0, ScreenW, 60);
                        footer.userInteractionEnabled = NO;
                        footer.statusLabel.text = @"没有更多话题";
                        controller.footer = footer;
                    }else{
                        controller.footer.userInteractionEnabled = NO;
                        controller.footer.statusLabel.text = @"没有更多话题";
                    }
                    controller.footer.hidden  = NO;
                    
                }else{
                    if (controller.footer==nil) {
                        HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
                        controller.tableView.tableFooterView = footer;
                        footer.frame = CGRectMake(0, 0, ScreenW, 60);
                        [footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
                        footer.statusLabel.text = @"点击查看更多";
                        controller.footer = footer;
                    }else{
                        controller.footer.userInteractionEnabled = YES;
                        [controller.footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
                        controller.footer.statusLabel.text = @"点击查看更多";
                    }
                    controller.footer.hidden  = NO;
                }
            }
            
          
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page = 0;
        }
         [controller.tableView reloadData];
        [controller reloadDataNULL:@"附近暂无话题 敬请期待" imageName:@"bow_ico_fjwcthht"];
        if (controller.adsArray.count>0) {
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-230;
        }
        else{
            
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-300;
        }

       
        controller.topic_list_load_success = YES;
        if (controller.im_list_load_success==YES) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] isEqualToString:@"1"]) {
                [SVProgressHUD dismiss];
            }
        }
//        [SVProgressHUD dismiss];
        [FDLoadingGifHUD dismiss];
    } failure:^(NSError *error) {
        controller.topic_list_load_success = YES;
        if (controller.im_list_load_success==YES) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] isEqualToString:@"1"]) {
//                [SVProgressHUD dismiss];
                [FDLoadingGifHUD dismiss];
            }
        }
        self.page = 0;
        MQQLog(@"error=%@",[error description]);
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
         if (controller.adsArray.count>0) {
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-230;
        }
         else{
             
             controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-300;
         }
//        [SVProgressHUD dismiss];
        [FDLoadingGifHUD dismiss];
    }];
    

}

- (void)topicSearchTapWithLat:(NSString *)latString lng:(NSString *)lngString  topic_class_id:(NSString *)topic_class_id  viewController:(FDTopicsViewController *)controller{
    controller.footer.hidden = YES;
    ReqTopicSearchModel*reqModel =[[ReqTopicSearchModel alloc]init];
    self.page = 1;
    reqModel.lat = latString;
    reqModel.lng = lngString;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = self.page;
    reqModel.class_id = topic_class_id;
    ApiTopicSearch *request=[[ApiTopicSearch alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        [SVProgressHUD dismiss];
        RespTopicSearchModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            if (paseData.topic!=nil&&paseData.topic.count!=0) {//如果数组不为空
                
                [controller.datyArray removeAllObjects];
                
                
                
                NSArray *newFrames = [self stausFramesWithStatuses:paseData.topic];
                [controller.datyArray addObjectsFromArray:newFrames];
//
//                HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
//                controller.tableView.tableFooterView = footer;
//                footer.frame = CGRectMake(0, 0, ScreenW, 60);
//                [footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
//                controller.footer = footer;
//                
                
            }else{
                
            }
            if (paseData.topic.count==0) {
                [controller.footer removeFromSuperview];
                controller.tableView.tableFooterView = nil;
                [controller.datyArray removeAllObjects];
            }else{
                controller.footer.hidden = NO;
                if (paseData.topic.count<20) {
                    if (controller.footer==nil) {
                        HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
                        controller.tableView.tableFooterView = footer;
                        footer.frame = CGRectMake(0, 0, ScreenW, 60);
                        footer.userInteractionEnabled = NO;
                        footer.statusLabel.text = @"没有更多话题";
                        controller.footer = footer;
                    }else{
                        controller.footer.userInteractionEnabled = NO;
                        controller.footer.statusLabel.text = @"没有更多话题";
                    }
                    

                    
                }else{
                    if (controller.footer==nil) {
                        HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
                        controller.tableView.tableFooterView = footer;
                        footer.frame = CGRectMake(0, 0, ScreenW, 60);
                        [footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
                        footer.statusLabel.text = @"点击查看更多";
                        controller.footer = footer;
                    }else{
                        controller.footer.userInteractionEnabled = YES;
                        [controller.footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
                        controller.footer.statusLabel.text = @"点击查看更多";
                    }
                }
            }
            
        }else{//加载失败
            controller.footer.hidden = NO;
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page = 0;
        }
        [controller.tableView reloadData];
        [controller reloadDataNULL:@"附近暂无话题 敬请期待" imageName:@"bow_ico_fjwcthht"];
         if (controller.adsArray.count>0) {
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-230;
         }else{
         
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-300;
         }
        
        //[SVProgressHUD dismiss];
        
        [controller.tableView reloadData];
    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
//        controller.footer.hidden = NO;
        self.page = 0;
        MQQLog(@"error=%@",[error description]);
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
         if (controller.adsArray.count>0) {
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-230;
        }
         else{
             
             controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-300;
         }

//        [SVProgressHUD dismiss];
        
        
    }];
    
    
}

- (void)MJRefreshTopTopicSearchWithLat:(NSString *)latString lng:(NSString *)lngString  topic_class_id:(NSString *)topic_class_id viewController:(FDTopicsViewController *)controller{
    ReqTopicSearchModel*reqModel =[[ReqTopicSearchModel alloc]init];
    self.page = 1;
    reqModel.lat = latString;
    reqModel.lng = lngString;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = self.page;
    reqModel.class_id = topic_class_id;
    ApiTopicSearch *request=[[ApiTopicSearch alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        [SVProgressHUD dismiss];
        RespTopicSearchModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            if (paseData.topic!=nil&&paseData.topic.count!=0) {//如果数组不为空
                
                [controller.datyArray removeAllObjects];
                FDTopicsTool *tool = [FDTopicsTool sharedInstance];
                [tool saveStatuses:paseData.topic];
                
                
                NSArray *newFrames = [self stausFramesWithStatuses:paseData.topic];
                [controller.datyArray addObjectsFromArray:newFrames];
                
            }else{
                
            }
            if (paseData.topic.count==0) {
                [controller.footer removeFromSuperview];
                controller.tableView.tableFooterView = nil;
                [controller.datyArray removeAllObjects];
            }else{
                if (paseData.topic.count<20) {
                    if (controller.footer==nil) {
                        HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
                        controller.tableView.tableFooterView = footer;
                        footer.frame = CGRectMake(0, 0, ScreenW, 60);
                        footer.userInteractionEnabled = NO;
                        footer.statusLabel.text = @"没有更多话题";
                        controller.footer = footer;
                    }else{
                        controller.footer.userInteractionEnabled = NO;
                        controller.footer.statusLabel.text = @"没有更多话题";
                    }
                    controller.footer.hidden  = NO;
                    
                }else{
                    if (controller.footer==nil) {
                        HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
                        controller.tableView.tableFooterView = footer;
                        footer.frame = CGRectMake(0, 0, ScreenW, 60);
                        [footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
                        footer.statusLabel.text = @"点击查看更多";
                        controller.footer = footer;
                    }else{
                        controller.footer.userInteractionEnabled = YES;
                        [controller.footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
                        controller.footer.statusLabel.text = @"点击查看更多";
                    }
                    controller.footer.hidden  = NO;
                }
            }

        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page = 0;
        }
       [controller.tableView reloadData];
        [controller reloadDataNULL:@"附近暂无话题 敬请期待" imageName:@"bow_ico_fjwcthht"];
         if (controller.adsArray.count>0) {
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-230;
        }
         else{
             
             controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-300;
         }
        
        [controller.tableView.header endRefreshing];
    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
        self.page = 0;
        MQQLog(@"error=%@",[error description]);
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
         if (controller.adsArray.count>0) {
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-230;
        }
         else{
             
             controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-300;
         }

        [controller.tableView.header endRefreshing];
    }];
    
    

}

- (void)MJRefreshMoreTopicSearchWithLat:(NSString *)latString lng:(NSString *)lngString  topic_class_id:(NSString *)topic_class_id  viewController:(FDTopicsViewController *)controller{
    ReqTopicSearchModel*reqModel =[[ReqTopicSearchModel alloc]init];
    self.page+= 1;
    reqModel.lat = latString;
    reqModel.lng = lngString;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = self.page;
    reqModel.class_id = topic_class_id;
    ApiTopicSearch *request=[[ApiTopicSearch alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        [SVProgressHUD dismiss];
        RespTopicSearchModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            if (paseData.topic!=nil&&paseData.topic.count!=0) {//如果数组不为空
                
//                [controller.datyArray removeAllObjects];
                
                NSArray *newFrames = [self stausFramesWithStatuses:paseData.topic];
                [controller.datyArray addObjectsFromArray:newFrames];

            }else{
                
            }
            
            if (paseData.topic.count<20||((int)paseData.topic.count)==0) {
                if (controller.footer==nil) {
                    HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
                    controller.tableView.tableFooterView = footer;
                    footer.frame = CGRectMake(0, 0, ScreenW, 60);
                    footer.userInteractionEnabled = NO;
                    footer.statusLabel.text = @"没有更多话题";
                    controller.footer = footer;
                }else{
                    controller.footer.userInteractionEnabled = NO;
                    controller.footer.statusLabel.text = @"没有更多话题";
                }
                
            }else{
                if (controller.footer==nil) {
                    HMLoadMoreFooter *footer = [HMLoadMoreFooter footer];
                    controller.tableView.tableFooterView = footer;
                    footer.frame = CGRectMake(0, 0, ScreenW, 60);
                    [footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
                    footer.statusLabel.text = @"点击查看更多";
                    controller.footer = footer;
                }else{
                    controller.footer.userInteractionEnabled = YES;
                    [controller.footer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:controller action:@selector(MJRefreshMore)]];
                    controller.footer.statusLabel.text = @"点击查看更多";
                }
            }
           


        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page-=1;
        }
        [controller.footer endRefreshing];
       [controller.tableView reloadData];
        [controller reloadDataNULL:@"附近暂无话题 敬请期待" imageName:@"bow_ico_fjwcthht"];
         if (controller.adsArray.count>0) {
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-230;
        }
         else{
             
             controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-300;
         }
        
        [controller.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
        [controller.footer endRefreshing];
        self.page-=1;
        MQQLog(@"error=%@",[error description]);
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
         if (controller.adsArray.count>0) {
            controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-230;
        }
         else{
             
             controller.nullView.imgCenterYGap = controller.tableView.contentSize.height-300;
         }

        [controller.tableView.footer endRefreshing];
    }];
    

}
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (FDTopics *status in statuses) {
        FDTopicsFrame *f = [[FDTopicsFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

@end
