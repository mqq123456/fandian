//
//  FDCommentDetailViewController.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/2.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"
@class CommentModel;
@class RespMerchantCommentDetail;
@interface FDCommentDetailViewController : RootGroupTableViewController
@property (nonatomic , strong) CommentModel *model;
@property (nonatomic , copy) NSString *comment_id;
@property (nonatomic , strong) RespMerchantCommentDetail *respModel;
@end
