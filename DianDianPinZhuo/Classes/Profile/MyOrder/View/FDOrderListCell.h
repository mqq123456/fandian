//
//  FDOrderListCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/7.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FDOrderListFrame;
@interface FDOrderListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) FDOrderListFrame *statusFrame;
/** 再吃一次 */
@property (nonatomic, weak) UIButton *again_btn;
/** 只有一个btn，有可能是去支付，退款，评价送积分 */
@property (nonatomic, weak) UIButton *only_btn;
@end
