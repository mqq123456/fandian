//
//  HttpUserIntegralPoint.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDIntegralViewController;
@interface HttpUserIntegralPoint : NSObject

+(id)sharedInstance;

- (void)MJRefreshTopPage:(int)page controller:(FDIntegralViewController *)controller income:(NSInteger)left;
- (void)loadFristPage:(int)page controller:(FDIntegralViewController *)controller income:(NSInteger)left;
- (void)MJRefreshMorePage:(int)page controller:(FDIntegralViewController *)controller income:(NSInteger)left;

@end
