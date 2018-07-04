//
//  FDInvoiceHistoryCell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDInvoiceHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
