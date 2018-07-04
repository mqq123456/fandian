//
//  FDPerfectCompanyCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/31.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDPerfectCompanyCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end
