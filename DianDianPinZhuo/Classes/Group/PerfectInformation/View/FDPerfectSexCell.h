//
//  FDPerfectSexCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/31.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FDPerfectSexCellDelegate <NSObject>

- (void)selectedAndReloadTableViewWithSex:(NSString *)sex;

@end

@interface FDPerfectSexCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *nanBtn;
@property (weak, nonatomic) IBOutlet UIButton *nvBtn;
- (IBAction)nanClick:(id)sender;
- (IBAction)nvClick:(id)sender;
@property (nonatomic,weak) id <FDPerfectSexCellDelegate> delegate;
@end
