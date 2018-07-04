//
//  HttpInvoiceHistory.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDInvoiceHistoryViewController;
@interface HttpInvoiceHistory : NSObject

+(id)sharedInstance;

- (void)loadFristController:(FDInvoiceHistoryViewController *)controller;
- (void)MJRefreshTopController:(FDInvoiceHistoryViewController *)controller;
- (void)MJRefreshMoreController:(FDInvoiceHistoryViewController *)controller;

@end
