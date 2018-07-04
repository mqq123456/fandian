//
//  HttpMerchantDetail.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMerchantDetail.h"
#import "ApiParseMerchantDetail.h"
#import "ReqMerchantDetailModel.h"
#import "RespMerchantDetailModel.h"
#import "CommentModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "MenusModel.h"
#import "OrderModel.h"
#import "HQDefaultTool.h"
#import "ImagesModel.h"
#import "KdateModel.h"
#import "MealsModel.h"
#import "FDCommentFrame.h"
#import "SeatsModel.h"
#import "FDMerchantIntroductionViewController.h"
#import "FDMerchantDetailFooterView.h"
#import "FDMerchantDetailController.h"
#import "HQDefaultTool.h"
#import "TaoCanModel.h"
#import "FDMerchantDetail_Menu_Cell.h"
#import "FDMerchantDetailShareModel.h"

@implementation HttpMerchantDetail
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

- (void)merchantDetailWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng meal_id:(NSString *)meal_id merchant_id:(NSString *)merchant_id meal_date:(NSString *)meal_date local:(NSString *)local viewController :(FDMerchantDetailController *)controller bestSelect_index:(NSInteger)bestSelect_index{
    [controller.activity startAnimating];
//    [FDLoadingGifHUD showLoadingGifHUD];
    ReqMerchantDetailModel *reqModel=[[ReqMerchantDetailModel alloc]init];
    reqModel.merchant_id = merchant_id;
    reqModel.lat = lat;
    reqModel.lng = lng;
    reqModel.local_lat = local_lat;
    reqModel.local_lng = local_lng;
    if ([meal_id isEqualToString:@""]) {
        
    }else{
        reqModel.meal_id = meal_id;
    }
    if ([meal_date isEqualToString:@""]) {
        
    }else{
        reqModel.meal_date = meal_date;
    }
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        reqModel.kid = [HQDefaultTool getKid];
    }
    reqModel.is_bz = controller.is_bz;
    reqModel.local= local;
    
    ApiParseMerchantDetail *request=[[ApiParseMerchantDetail alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
       

        RespMerchantDetailModel *paseData=[request parseData:json];
        
        if ([paseData.code isEqualToString:@"1"]) {
            controller.scrollMenu.soldout_hint = paseData.soldout_hint;
            
            controller.scrollMenu.meal_time_end_hint = paseData.meal_time_end_hint;
            controller.scrollMenu.meal_time_expired_hint = paseData.meal_time_expired_hint;
            
            [controller.imagesURL removeAllObjects];
            [controller.menuArray removeAllObjects];
            [controller.commentArray removeAllObjects];
            [controller.categoryArray removeAllObjects];
         
            [controller.kdates removeAllObjects];
            [controller.seats removeAllObjects];

            controller.seats = paseData.seats;
            
            controller.is_western_restaurant = paseData.is_western_restaurant;            
            
            controller.soldout_hint= paseData.soldout_hint;
            controller.meal_time_end_hint= paseData.meal_time_end_hint;
            controller.meal_time_expired_hint= paseData.meal_time_expired_hint;
            
            
            controller.commentArray = [NSMutableArray arrayWithArray:[self stausFramesWithStatuses:paseData.comments]];
            controller.menus_copy = paseData.menus_copy;
            
            
            if (paseData.menus_copy.count==2) {
                TaoCanModel *model = [paseData.menus_copy objectAtIndex:0];
                if ([model.is_soldout intValue]!=1) {
                    controller.menuArray = model.menus;
//                    for (MenusModel *menusModel in model.menus) {
//                        
//                        NSArray *array = [menusModel.menu_detail componentsSeparatedByString:@","];
//                        [controller.menuArray addObject:array];
//                        [controller.categoryArray addObject:menusModel.menu_name];
//                        
//                    }
                    for (ImagesModel *imageModel in model.imgs) {
                        [controller.imagesURL addObject:imageModel.url];
                    }
                    controller.left_right = 1;
                    controller.price = model.price;
                    controller.peopleNum = model.menu_people;
                    controller.people_desc = model.menu_people_desc;
                    controller.menu_id = model.menu_id;
                    controller.original_price = model.original_price;
                    controller.jzjg = model.jzjg;
                    controller.total_deduction = model.total_deduction;
                    controller.paid = model.paid;
                }else{
                    TaoCanModel *model = [paseData.menus_copy objectAtIndex:1];
                    if ([model.is_soldout intValue]!=1) {
                        controller.menuArray = model.menus;
//                        for (MenusModel *menusModel in model.menus) {//小菜单
//                            NSArray *array = [menusModel.menu_detail componentsSeparatedByString:@","];
//                            [controller.menuArray addObject:array];
//                            [controller.categoryArray addObject:menusModel.menu_name];
//                            
//                        }
                        for (ImagesModel *imageModel in model.imgs) {
                            [controller.imagesURL addObject:imageModel.url];
                        }
                        controller.left_right = 2;
                        controller.price = model.price;
                        controller.peopleNum = model.menu_people;
                        controller.people_desc = model.menu_people_desc;
                        controller.menu_id = model.menu_id;
                        controller.original_price = model.original_price;
                        controller.jzjg = model.jzjg;
                        controller.total_deduction = model.total_deduction;
                        controller.paid = model.paid;
                    }
                    
                }
            }else{
                if (paseData.menus_copy.count==1) {
                    TaoCanModel *model = [paseData.menus_copy objectAtIndex:0];
                    if ([model.is_soldout intValue]!=1) {
                        controller.menuArray = model.menus;
//                        for (MenusModel *menusModel in model.menus) {//小菜单
//                            NSArray *array = [menusModel.menu_detail componentsSeparatedByString:@","];
//                            [controller.menuArray addObject:array];
//                            [controller.categoryArray addObject:menusModel.menu_name];
//                            
//                        }
                        for (ImagesModel *imageModel in model.imgs) {
                            [controller.imagesURL addObject:imageModel.url];
                        }
                        controller.left_right = 1;
                        controller.price = model.price;
                        controller.peopleNum = model.menu_people;
                        controller.people_desc = model.menu_people_desc;
                        controller.menu_id = model.menu_id;
                        controller.original_price = model.original_price;
                        controller.jzjg = model.jzjg;
                        controller.total_deduction = model.total_deduction;
                        controller.paid = model.paid;
                    }
                }else{
                    //
                    controller.left_right = 0;
                }
            }
            
            controller.friend_hint = paseData.friend_hint;
            
            
            NSMutableArray *array = [NSMutableArray array];
            
            [controller.kdates removeAllObjects];
            [controller.kdescs removeAllObjects];
            [controller.ktimes removeAllObjects];
            [controller.kmeal_ids removeAllObjects];
            [controller.timeArray removeAllObjects];
            [controller.kmeal_state removeAllObjects];
            [controller.is_discounts removeAllObjects];
            for (KdateModel *model in paseData.kdates) {//将开餐时间装到不同数组中
                
                for (MealsModel *meals in model.meals) {
                    [array addObject:[NSString stringWithFormat:@"%@ %@ %@ %@",model.kdate_desc,meals.meal_desc,meals.meal_id,model.kdate]];
                    [controller.kdates addObject:model.kdate];
                    [controller.kdescs addObject:model.kdate_desc];
                    [controller.ktimes addObject:meals.meal_desc];
                    [controller.kmeal_ids addObject:meals.meal_id];
                    [controller.kmeal_state addObject:meals.state];
                    [controller.is_discounts addObject:meals.is_discount];
                    [controller.timeArray addObject:[NSString stringWithFormat:@"%@%@ ",model.kdate_desc,meals.meal_desc]];
                    
                    for (int i=0; i<paseData.kdates.count; i++) {//计算最优时间
                        KdateModel *kdateModel = paseData.kdates[i];
                        for (int j=0; j<kdateModel.meals.count; j++) {
                            MealsModel *mealModel = kdateModel.meals[j];
                            if ([mealModel.state intValue]==1) {
                                if (bestSelect_index == -1) {
                                    controller.best_select_index = i*kdateModel.meals.count+j;
                                    controller.select_index = i*kdateModel.meals.count+j;
                                    if ([controller.meal_id isEqualToString:@""]&&[controller.kdate isEqualToString:@""]) {
                                        controller.meal_id= mealModel.meal_id;
                                        controller.kdate = kdateModel.kdate;
                                        controller.kdate_desc = kdateModel.kdate_desc;
                                        controller.meal_time = mealModel.meal_desc;
                                        
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                }
                
                
            }
            controller.model = paseData.merchant;
            
            controller.left_seat = paseData.left_seat;
            
            controller.people_hint = paseData.people_hint;
            [controller loadMerchantDetailBack];
            if ([paseData.comment_num intValue]>2) {
                FDMerchantDetailFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"FDMerchantDetailFooterView" owner:nil options:nil]lastObject];
                footerView.frame = CGRectMake(0, 0, ScreenW, 74);
                
                [footerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:controller action:@selector(pushToCommentController)]];
                controller.tableView.tableFooterView = footerView;
            }
            
            controller.title = paseData.merchant.merchant_name;
            if ([paseData.is_western_restaurant intValue]==1) {
                [controller.bottomView.orderBtn setTitle:@"我要拼桌" forState:UIControlStateNormal];
            }
            
            FDMerchantDetailShareModel *shareModel = [[FDMerchantDetailShareModel alloc] init];
            shareModel.WeChat_friends_circle_share_title = paseData.WeChat_friends_circle_share_title;
            shareModel.WeChat_friends_share_text = paseData.WeChat_friends_share_text;
            shareModel.WeChat_friends_share_title = paseData.WeChat_friends_share_title;
            shareModel.group_share_title = paseData.group_share_title;
            shareModel.group_share_hint = paseData.group_share_hint;
            controller.shareModel = shareModel;
            
            
        }
        else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
//        [FDLoadingGifHUD dismiss];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            [controller.tableView reloadData];
//            
//        });
        [controller.tableView reloadData];

        [controller.activity stopAnimating];
        
    } failure:^(NSError *error) {
        MQQLog(@"==%@",[error description]);
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
//        [FDLoadingGifHUD dismiss];
        [controller.activity stopAnimating];
    }];
    
    
}
- (void)merchantDetailWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng merchant_id:(NSString *)merchant_id local:(NSString *)local viewController:(FDMerchantIntroductionViewController *)controller bestSelect_index:(NSInteger)bestSelect_index meal_id:(NSString *)meal_id meal_date:(NSString *)meal_date{
    
    ReqMerchantDetailModel *reqModel=[[ReqMerchantDetailModel alloc]init];
    reqModel.merchant_id = merchant_id;
    reqModel.lat = lat;
    reqModel.lng = lng;
    reqModel.local_lat = local_lat;
    reqModel.local_lng = local_lng;
    
    reqModel.meal_id = meal_id;
    reqModel.menu_id = controller.menu_id;
    reqModel.meal_date = meal_date;
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        reqModel.kid = [HQDefaultTool getKid];
    }
    reqModel.is_bz = controller.is_bz;
    if (controller.is_from_topic) {
        reqModel.is_bz = @"0";
    }
    reqModel.local= local;
    
    ApiParseMerchantDetail *request=[[ApiParseMerchantDetail alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespMerchantDetailModel *paseData=[request parseData:json];
        
        if ([paseData.code isEqualToString:@"1"]) {
            
            
            [controller.imagesURL removeAllObjects];
            [controller.menuArray removeAllObjects];
            [controller.commentArray removeAllObjects];
            [controller.categoryArray removeAllObjects];
            [controller.merchantArray removeAllObjects];
            [controller.small_menusArray removeAllObjects];
            [controller.small_imagesURL removeAllObjects];
            [controller.small_categoryArray removeAllObjects];
            [controller.kdates removeAllObjects];
            [controller.seats removeAllObjects];

            controller.seats = paseData.seats;

            
            controller.small_menu_hint = paseData.small_menu_hint;
            controller.clean_plate_hint = paseData.clean_plate_hint;
            controller.small_menu_title = paseData.small_menu_title;
            
            controller.commentArray = [NSMutableArray arrayWithArray:[self stausFramesWithStatuses:paseData.comments]];
             controller.menus_copy = paseData.menus_copy;
            
            if (paseData.menus_copy.count==2) {
                TaoCanModel *model = [paseData.menus_copy objectAtIndex:0];
                if ([model.is_soldout intValue]!=1) {
                    for (MenusModel *menusModel in model.menus) {//小菜单
                        NSArray *array = [menusModel.menu_detail componentsSeparatedByString:@","];
                        [controller.menuArray addObject:array];
                        [controller.categoryArray addObject:menusModel.menu_name];
                        
                    }
                    for (ImagesModel *imageModel in model.imgs) {
                        [controller.imagesURL addObject:imageModel.url];
                    }
                    controller.left_right = 1;
                    controller.menu_id = model.menu_id;
                }else{
                    TaoCanModel *model = [paseData.menus_copy objectAtIndex:1];
                    if ([model.is_soldout intValue]!=1) {
                        for (MenusModel *menusModel in model.menus) {//小菜单
                            NSArray *array = [menusModel.menu_detail componentsSeparatedByString:@","];
                            [controller.menuArray addObject:array];
                            [controller.categoryArray addObject:menusModel.menu_name];
                            
                        }
                        for (ImagesModel *imageModel in model.imgs) {
                            [controller.imagesURL addObject:imageModel.url];
                        }
                        controller.left_right = 2;

                    }
                }
            }else{
                if (paseData.menus_copy.count==1) {
                    TaoCanModel *model = [paseData.menus_copy objectAtIndex:0];
                        for (MenusModel *menusModel in model.menus) {//小菜单
                            NSArray *array = [menusModel.menu_detail componentsSeparatedByString:@","];
                            [controller.menuArray addObject:array];
                            [controller.categoryArray addObject:menusModel.menu_name];
                        }
                        for (ImagesModel *imageModel in model.imgs) {
                            [controller.imagesURL addObject:imageModel.url];
                        }
                        controller.left_right = 1;

                }else{
                    
                    controller.left_right = 0;
                }
            }
            
            controller.friend_hint = paseData.friend_hint;
            
            
//            NSMutableArray *array = [NSMutableArray array];
            
            [controller.kdates removeAllObjects];
            [controller.kdescs removeAllObjects];
            [controller.ktimes removeAllObjects];
            [controller.kmeal_ids removeAllObjects];
            [controller.timeArray removeAllObjects];
            
            controller.menu_id = paseData.pz_menu_id;
            
            controller.model = paseData.merchant;
            controller.left_seat = paseData.left_seat;
            
            controller.people_hint = paseData.people_hint;
            
            [controller loadMerchantDetailBack];
//            if ([paseData.comment_num intValue]>2) {
//                FDMerchantDetailFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"FDMerchantDetailFooterView" owner:nil options:nil]lastObject];
//                footerView.frame = CGRectMake(0, 0, ScreenW, 74);
//                
//                [footerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:controller action:@selector(pushToCommentController)]];
//                controller.tableView.tableFooterView = footerView;
//            }
            
            [controller.tableView reloadData];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"==%@",[error description]);
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
