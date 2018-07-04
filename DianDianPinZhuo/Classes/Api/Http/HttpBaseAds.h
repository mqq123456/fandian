//
//  HttpBaseAds.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDHomeViewController;
@interface HttpBaseAds : NSObject
+(id)sharedInstance;
- (void)loadBaseAdsWithViewController:(FDHomeViewController *)viewController ;

@end
