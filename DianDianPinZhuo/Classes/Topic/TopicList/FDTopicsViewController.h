//
//  FDTopicsViewController.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootTableViewController.h"

@class HMLoadMoreFooter;

@interface FDTopicsViewController : RootTableViewController

@property (nonatomic ,copy) NSString *latString;
@property (nonatomic ,copy) NSString *lngString;
@property (nonatomic ,strong) NSMutableArray *adsArray;//广告
@property(nonatomic,weak)HMLoadMoreFooter *footer;
//默认发起话题的文案
@property (nonatomic ,copy) NSString *default_topic_title;
///登陆之后跳转到发起话题页面
- (void)pushToMakeTopic;

@property (nonatomic,strong)NSMutableArray *groupArray;
@property (nonatomic,strong)NSMutableArray *groupArray_desc;
-(void)getGroupInfo;
@property (nonatomic,assign) BOOL topic_list_load_success;
@property (nonatomic,assign) BOOL im_list_load_success;
@end
