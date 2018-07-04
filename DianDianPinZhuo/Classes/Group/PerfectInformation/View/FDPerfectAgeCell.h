//
//  FDPerfectAgeCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/31.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FDPerfectAgeCellDelegate <NSObject>

- (void)selectedAndReloadTableViewWithAge:(NSString *)sex;

@end

@interface FDPerfectAgeCell : UITableViewCell 
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,weak) id <FDPerfectAgeCellDelegate> delegate;

@end
