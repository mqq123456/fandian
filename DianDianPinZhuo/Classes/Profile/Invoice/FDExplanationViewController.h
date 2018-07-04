//
//  FDExplanationViewController.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootViewController.h"

@interface FDExplanationViewController : RootViewController
@property(nonatomic,strong)NSMutableArray * invoice_instruction;
@property (weak, nonatomic) IBOutlet UILabel *first;
@property (weak, nonatomic) IBOutlet UILabel *second;
@property (weak, nonatomic) IBOutlet UILabel *third;
@property (weak, nonatomic) IBOutlet UILabel *Q1;
@property (weak, nonatomic) IBOutlet UILabel *A1;
@property (weak, nonatomic) IBOutlet UILabel *Q2;
@property (weak, nonatomic) IBOutlet UILabel *A2;
@property (weak, nonatomic) IBOutlet UILabel *Q3;
@property (weak, nonatomic) IBOutlet UILabel *A3;
@end
