//
//  FDExplanationViewController.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDExplanationViewController.h"

@interface FDExplanationViewController ()

@end

@implementation FDExplanationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTitleViewWithTitle:@"开票说明"];
    switch (self.invoice_instruction.count) {
        case 0:
        {
        
        
        }
            break;
        case 1:
        {
            self.Q1.text = [self.invoice_instruction objectAtIndex:0][@"question"];
            self.A1.text = [self.invoice_instruction objectAtIndex:0][@"answer"];

            
        }
            break;
        case 2:
        {
            self.Q1.text = [self.invoice_instruction objectAtIndex:0][@"question"];
            self.A1.text = [self.invoice_instruction objectAtIndex:0][@"answer"];
            self.Q2.text = [self.invoice_instruction objectAtIndex:1][@"question"];
            self.A2.text = [self.invoice_instruction objectAtIndex:1][@"answer"];
            
            
        }
            break;
        case 3:
        {
            self.Q1.text = [self.invoice_instruction objectAtIndex:0][@"question"];
            self.A1.text = [self.invoice_instruction objectAtIndex:0][@"answer"];
            self.Q2.text = [self.invoice_instruction objectAtIndex:1][@"question"];
            self.A2.text = [self.invoice_instruction objectAtIndex:1][@"answer"];
            self.Q3.text = [self.invoice_instruction objectAtIndex:2][@"question"];
            self.A3.text = [self.invoice_instruction objectAtIndex:2][@"answer"];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
