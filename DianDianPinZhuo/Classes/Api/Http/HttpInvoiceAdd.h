//
//  HttpInvoiceAdd.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDInvoiceViewController;
@class ReqInvoiceAddModel;

@interface HttpInvoiceAdd : NSObject
+(id)sharedInstance;
- (void)invoiceAddWithReqInvoiceAddModel:(ReqInvoiceAddModel *)requestModel viewController:(FDInvoiceViewController *)viewController;
@end
