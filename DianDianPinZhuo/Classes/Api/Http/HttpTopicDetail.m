//
//  HttpTopicDetail.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpTopicDetail.h"
#import "ApiPaseTopicDetail.h"
#import "ReqTopicDetailModel.h"
#import "RespBaseTopicDetailModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "FDTopics.h"
#import "MemberModel.h"
#import "HQHttpTool.h"
#import "TopicCommentModel.h"
#import "FDTopicCommentFrame.h"
#import "FDGuideView.h"
#import "FDSubjectDetailViewController.h"
#import "FDUsersFrame.h"
@implementation HttpTopicDetail
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

- (void)loadWithTopic_id:(NSString *)topic_id controller:(FDSubjectDetailViewController *)controller{
    ReqTopicDetailModel*reqModel =[[ReqTopicDetailModel alloc]init];

    reqModel.kid = [HQDefaultTool getKid];
    reqModel.topic_id = topic_id;
    if (controller.latString) {
        reqModel.lat = controller.latString;
    }else{
        reqModel.lat = [HQDefaultTool getLat];
    }
    if (controller.lngString) {
        reqModel.lng = controller.lngString;
    }else{
        reqModel.lng = [HQDefaultTool getLng];
    }
    
    
    ApiPaseTopicDetail *request=[[ApiPaseTopicDetail alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespBaseTopicDetailModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            controller.commentArray = [NSMutableArray arrayWithArray:[self stausFramesWithStatuses:paseData.comments]];
            controller.model = paseData.topic;
            
            ///通知话题列表页刷新某条数据
            NSMutableArray *array =[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%@",paseData.order_seat],[NSString stringWithFormat:@"%@",paseData.left_seat],[NSString stringWithFormat:@"%d",paseData.topic.comment_num], nil] ;
            [[NSNotificationCenter defaultCenter] postNotificationName:refreshCell object:array];
            FDUsersFrame *frame = [[FDUsersFrame alloc] init];
            frame.status = paseData.members;
            frame.joinPeople = paseData.topic.people;
            if ([paseData.left_seat intValue]==0) {
                frame.left_seat = YES;
            }else{
                frame.left_seat = NO;
            }
            
            controller.usersFrame = frame;
            controller.meal_date = paseData.meal_date;
            controller.meal_id = paseData.meal_id;
            controller.kdate = paseData.meal_date;
            controller.merchant = paseData.merchant;
            controller.kdate_desc = paseData.kdate_desc;
            controller.seats = paseData.seats;
            controller.meal_time = paseData.meal_time;
            controller.left_seat = paseData.left_seat;
            controller.order_seat = paseData.order_seat;
            controller.is_order = paseData.is_order;
            controller.latString = paseData.merchant.lat;
            controller.lngString = paseData.merchant.lng;
            controller.local_lat = paseData.merchant.lat;
            controller.local_lng = paseData.merchant.lng;
            controller.menu_id= paseData.menu_id;
            
            if (controller.is_from_push) {
                [controller.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:controller.commentArray.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            [controller.tableView reloadData];
            if ([controller.is_order intValue]==1) {
                controller.endImageView.hidden = NO;
            }
            
            NSUserDefaults *userDefaut = [NSUserDefaults standardUserDefaults];
            if ([userDefaut objectForKey:@"FDGuideView"]) {
                
            }
            else{
                FDGuideView *guideView = [[[NSBundle mainBundle] loadNibNamed:@"FDGuideView" owner:nil options:nil]lastObject];
                [guideView.people_icon sd_setImageWithURL:[NSURL URLWithString:controller.model.person_img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    guideView.people_icon.image = image;
                }];
                [controller.navigationController.view addSubview:guideView];
                [userDefaut setObject:@"FDGuideView" forKey:@"FDGuideView"];
                [userDefaut synchronize];
                controller.guideView = guideView;
            }

            
            
        }else{//加载失败
                [SVProgressHUD showImage:nil status:paseData.desc];

        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];

    }];
}
- (void)commentBackAndLoadWithTopic_id:(NSString *)topic_id controller:(FDSubjectDetailViewController *)controller{
    
    ReqTopicDetailModel*reqModel =[[ReqTopicDetailModel alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.topic_id = topic_id;
    if (controller.latString) {
        reqModel.lat = controller.latString;
    }else{
        reqModel.lat = [HQDefaultTool getLat];
    }
    if (controller.lngString) {
        reqModel.lng = controller.lngString;
    }else{
        reqModel.lng = [HQDefaultTool getLng];
    }

    ApiPaseTopicDetail *request=[[ApiPaseTopicDetail alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespBaseTopicDetailModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            controller.commentArray = [NSMutableArray arrayWithArray:[self stausFramesWithStatuses:paseData.comments]];
            controller.model = paseData.topic;
            ///通知话题列表页刷新某条数据
            NSMutableArray *array =[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%@",paseData.order_seat],[NSString stringWithFormat:@"%@",paseData.left_seat],[NSString stringWithFormat:@"%d",paseData.topic.comment_num], nil] ;
            [[NSNotificationCenter defaultCenter] postNotificationName:refreshCell object:array];
            controller.meal_date = paseData.meal_date;
            controller.meal_id = paseData.meal_id;
            controller.kdate = paseData.meal_date;
            controller.kdate_desc = paseData.kdate_desc;
            controller.merchant = paseData.merchant;
            controller.seats = paseData.seats;
            controller.meal_time = paseData.meal_time;
            controller.left_seat = paseData.left_seat;
            controller.order_seat = paseData.order_seat;
            controller.is_order = paseData.is_order;
            controller.menu_id= paseData.menu_id;
            FDUsersFrame *frame = [[FDUsersFrame alloc] init];

            
            frame.status = paseData.members;
            frame.joinPeople = paseData.topic.people;
            
            if ([paseData.left_seat intValue]==0) {
                frame.left_seat = YES;
            }else{
                frame.left_seat = NO;
            }
            controller.usersFrame = frame;
            [controller.tableView reloadData];
            
            [controller.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:controller.commentArray.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [SVProgressHUD showImage:nil status:@"回复成功!"];
            });
           
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
}
- (void)commentDeleteBackAndLoadWithTopic_id:(NSString *)topic_id controller:(FDSubjectDetailViewController *)controller{
    
    ReqTopicDetailModel*reqModel =[[ReqTopicDetailModel alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.topic_id = topic_id;
    if (controller.latString) {
        reqModel.lat = controller.latString;
    }else{
        reqModel.lat = [HQDefaultTool getLat];
    }
    if (controller.lngString) {
        reqModel.lng = controller.lngString;
    }else{
        reqModel.lng = [HQDefaultTool getLng];
    }

    
    ApiPaseTopicDetail *request=[[ApiPaseTopicDetail alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespBaseTopicDetailModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            controller.commentArray = [NSMutableArray arrayWithArray:[self stausFramesWithStatuses:paseData.comments]];
            controller.model = paseData.topic;
            ///通知话题列表页刷新某条数据
            NSMutableArray *array =[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%@",paseData.order_seat],[NSString stringWithFormat:@"%@",paseData.left_seat],[NSString stringWithFormat:@"%d",paseData.topic.comment_num], nil] ;
            [[NSNotificationCenter defaultCenter] postNotificationName:refreshCell object:array];
            FDUsersFrame *frame = [[FDUsersFrame alloc] init];
            frame.status = paseData.members;
            frame.joinPeople = paseData.topic.people;
            if ([paseData.left_seat intValue]==0) {
                frame.left_seat = YES;
            }else{
                frame.left_seat = NO;
            }
            controller.usersFrame = frame;
            controller.meal_date = paseData.meal_date;
            controller.meal_id = paseData.meal_id;
            controller.kdate = paseData.meal_date;
            controller.kdate_desc = paseData.kdate_desc;
            controller.merchant = paseData.merchant;
            controller.seats = paseData.seats;
            controller.meal_time = paseData.meal_time;
            controller.left_seat = paseData.left_seat;
            controller.order_seat = paseData.order_seat;
            controller.is_order = paseData.is_order;
            controller.menu_id= paseData.menu_id;
            [controller.tableView reloadData];
            
//            [controller.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:controller.commentArray.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showImage:nil status:@"已删除"];
            });
            
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
}

- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (TopicCommentModel *status in statuses) {
        FDTopicCommentFrame *f = [[FDTopicCommentFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

@end
