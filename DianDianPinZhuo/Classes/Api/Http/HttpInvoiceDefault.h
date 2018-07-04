//
//  HttpInvoiceDefault.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDInvoiceViewController;
@interface HttpInvoiceDefault : NSObject
+(id)sharedInstance;
- (void)invoiceDefaultWithViewController:(FDInvoiceViewController *)viewController;
@end
