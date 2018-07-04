//
//  FDNearMerchantCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDNearMerchantFrame;
@class FDTopicMerchantListFram;
@interface FDNearMerchantCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) FDNearMerchantFrame *statusFrame;
@property (nonatomic, strong)FDTopicMerchantListFram *topic_statusFrame;
///topic_merchantList
@property(nonatomic,assign)BOOL topic_merchantList;

@end
