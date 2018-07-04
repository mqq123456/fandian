//
//  MerchantListCell.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusFrame;
@interface MerchantListCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)StatusFrame *statusFrame;
@property (nonatomic,assign)int is_bz;
@property (nonatomic,copy)NSString *peopleNum;

@end
