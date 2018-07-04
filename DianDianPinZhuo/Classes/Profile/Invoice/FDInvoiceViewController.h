//
//  FDInvoiceViewController.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"
#import "RespInvoiceDefaultModel.h"

@interface FDInvoiceViewController : RootGroupTableViewController
@property (nonatomic ,strong) RespInvoiceDefaultModel *defaultModel;
@property (nonatomic ,copy) NSString *invoice_amount;
@end
