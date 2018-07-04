//
//  FDPerfectAgeCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/31.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDPerfectAgeCell.h"
#import "HQDefaultTool.h"
@interface FDPerfectAgeCell () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic ,strong) NSMutableArray *dataArray;
@end
@implementation FDPerfectAgeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDPerfectAgeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDPerfectAgeCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDPerfectAgeCell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"选择年龄",@"60前",@"60后",@"70后",@"75后",@"80后",@"85后",@"90后",@"95后", nil];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    NSInteger selectRow = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
        if ([[HQDefaultTool getAge] isEqualToString:self.dataArray[i]]) {
            selectRow = i;
        }
    }
    [self.pickerView selectRow:selectRow inComponent:0 animated:NO];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataArray.count;
 
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectedAndReloadTableViewWithAge:)]) {
        [self.delegate selectedAndReloadTableViewWithAge:self.dataArray[row]];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.dataArray[row];

}

@end
