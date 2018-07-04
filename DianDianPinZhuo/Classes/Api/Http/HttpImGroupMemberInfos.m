//
//  HttpImGroupMemberInfos.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpImGroupMemberInfos.h"
#import "ApiParseImGroupMemberInfos.h"
#import "FDGroupMemberViewController.h"
#import "ReqImGroupMemberInfos.h"
#import "RespImGroupMemberInfos.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "GroupMembersModel.h"
#import "FDGroupMembersFrame.h"
#import "ChatViewController.h"
#import "UIImageView+WebCache.h"
#import "ChatViewHeaderView.h"
#import "Toast+UIView.h"
@interface HttpImGroupMemberInfos ()

@property (nonatomic ,assign) int page;


@end

@implementation HttpImGroupMemberInfos
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

- (void)loadChatViewImGroupMemberInfoWithController:(ChatViewController *)controller group_id:(NSString *)group_id{
    ReqImGroupMemberInfos *reqModel =[[ReqImGroupMemberInfos alloc]init];
    reqModel.page = @"1";
    reqModel.group_id = group_id;
    
    ApiParseImGroupMemberInfos *request=[[ApiParseImGroupMemberInfos alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImGroupMemberInfos *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            if (paseData.members.count==1) {
                controller.headView.head1.hidden = YES;
                controller.headView.head2.hidden = YES;
                controller.headView.head3.hidden = YES;
                controller.headView.head4.hidden = YES;
                
                GroupMembersModel *model = paseData.members[0];
                [controller.headView.head1 sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head1.image = image;
                    controller.headView.head1.hidden = NO;
                    
                    
                }];
            }
            if (paseData.members.count==2) {
                controller.headView.head1.hidden = YES;
                controller.headView.head2.hidden = YES;
                controller.headView.head3.hidden = YES;
                controller.headView.head4.hidden = YES;
                
                GroupMembersModel *model0 = paseData.members[0];
                [controller.headView.head2 sd_setImageWithURL:[NSURL URLWithString:model0.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head2.image = image;
                    controller.headView.head2.hidden = NO;
                }];
                
                GroupMembersModel *model1 = paseData.members[1];
                [controller.headView.head1 sd_setImageWithURL:[NSURL URLWithString:model1.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head1.image = image;
                    controller.headView.head1.hidden = NO;
                }];
                
                
                
            }
            if (paseData.members.count==3) {
                
                controller.headView.head1.hidden = YES;
                controller.headView.head2.hidden = YES;
                controller.headView.head3.hidden = YES;
                controller.headView.head4.hidden = YES;
                
                GroupMembersModel *model0 = paseData.members[0];
                [controller.headView.head3 sd_setImageWithURL:[NSURL URLWithString:model0.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head3.image = image;
                    controller.headView.head3.hidden = NO;
                }];
                
                GroupMembersModel *model1 = paseData.members[1];
                [controller.headView.head2 sd_setImageWithURL:[NSURL URLWithString:model1.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head2.image = image;
                    controller.headView.head2.hidden = NO;
                }];
                
                GroupMembersModel *model2 = paseData.members[2];
                [controller.headView.head1 sd_setImageWithURL:[NSURL URLWithString:model2.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head1.image = image;
                    controller.headView.head1.hidden = NO;
                }];
                
                
                
            }
            if (paseData.members.count>=4) {
                
                controller.headView.head1.hidden = YES;
                controller.headView.head2.hidden = YES;
                controller.headView.head3.hidden = YES;
                controller.headView.head4.hidden = YES;
                
                GroupMembersModel *model0 = paseData.members[0];
                [controller.headView.head4 sd_setImageWithURL:[NSURL URLWithString:model0.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head4.image = image;
                    controller.headView.head4.hidden = NO;
                }];
                
                
                
                GroupMembersModel *model1 = paseData.members[1];
                [controller.headView.head3 sd_setImageWithURL:[NSURL URLWithString:model1.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head3.image = image;
                    controller.headView.head3.hidden = NO;
                }];
                
                GroupMembersModel *model2 = paseData.members[2];
                [controller.headView.head2 sd_setImageWithURL:[NSURL URLWithString:model2.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head2.image = image;
                    controller.headView.head2.hidden = NO;
                }];
                
                GroupMembersModel *model3 = paseData.members[3];
                [controller.headView.head1 sd_setImageWithURL:[NSURL URLWithString:model3.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    controller.headView.head1.image = image;
                    controller.headView.head1.hidden = NO;
                }];
                
                
            }
            controller.headView.totalPeople.text = [NSString stringWithFormat:@"共%zd人",[paseData.members_count integerValue]];
            controller.notice = paseData.notice;
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
    
}
- (void)loadImGroupMemberInfoWithController:(FDGroupMemberViewController *)controller{
    _page = 1;
    [controller.activity startAnimating];
    ReqImGroupMemberInfos *reqModel =[[ReqImGroupMemberInfos alloc]init];
    reqModel.page = [NSString stringWithFormat:@"%d",_page];
    reqModel.group_id = controller.group_id;
    
    ApiParseImGroupMemberInfos *request=[[ApiParseImGroupMemberInfos alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImGroupMemberInfos *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            [controller.datyArray removeAllObjects];
            [controller.datyArray  addObjectsFromArray:[self stausFramesWithStatuses:paseData.members]];
            
            [controller.tableView reloadData];

        }else{//加载失败
            _page = 0;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        if (paseData.members.count<8) {
            controller.tableView.footer.hidden = YES;
        }else{
            controller.tableView.footer.hidden = NO;
        }
        [controller.activity stopAnimating];
    } failure:^(NSError *error) {
        [controller.activity stopAnimating];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];

}
- (void)loadTopImGroupMemberInfoWithController:(FDGroupMemberViewController *)controller{
    _page = 1;
    ReqImGroupMemberInfos *reqModel=[[ReqImGroupMemberInfos alloc]init];
    reqModel.page = [NSString stringWithFormat:@"%d",_page];
    reqModel.group_id = controller.group_id;
    
    ApiParseImGroupMemberInfos *request=[[ApiParseImGroupMemberInfos alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespImGroupMemberInfos *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.members != nil && [paseData.members  count] != 0) {
                [controller.datyArray removeAllObjects];
                [controller.datyArray  addObjectsFromArray:[self stausFramesWithStatuses:paseData.members]];
                [controller.tableView reloadData];
            }else{
                
            }

            
        }else{
            _page = 0;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        if (paseData.members.count<8) {
            controller.tableView.footer.hidden = YES;
        }else{
            controller.tableView.footer.hidden = NO;
        }
        [controller.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.header endRefreshing];
        controller.page = 0;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
    

}
- (void)loadMoreImGroupMemberInfoWithController:(FDGroupMemberViewController *)controller{
    _page += 1;
    ReqImGroupMemberInfos *reqModel=[[ReqImGroupMemberInfos alloc]init];
    reqModel.page = [NSString stringWithFormat:@"%d",_page];
    reqModel.group_id = controller.group_id;
    
    ApiParseImGroupMemberInfos *request=[[ApiParseImGroupMemberInfos alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespImGroupMemberInfos *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.members != nil && [paseData.members  count] != 0) {
                
                [controller.datyArray  addObjectsFromArray:[self stausFramesWithStatuses:paseData.members]];
                [controller.tableView reloadData];
            }else{

            }
            
        }else{
            _page-=1;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        if (paseData.members.count<8) {
            controller.tableView.footer.hidden = YES;
            //[SVProgressHUD showImage:nil status:@"没有更多评论了！"];
            [controller.view makeToast:@"没有更多成员了！"];
        }else{
            controller.tableView.footer.hidden = NO;
        }
        [controller.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.footer endRefreshing];
        controller.page -= 1;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];

}
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (GroupMembersModel *status in statuses) {
        FDGroupMembersFrame *f = [[FDGroupMembersFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}
@end
