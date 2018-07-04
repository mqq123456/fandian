//
//  HttpBaseVersion.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDHomeViewController;
@interface HttpBaseVersion : NSObject
+(id)sharedInstance;
- (void)getVersionWithContoller:(FDHomeViewController *)viewController;
@end
