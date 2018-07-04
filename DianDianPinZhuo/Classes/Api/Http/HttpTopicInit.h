//
//  HttpTopicInit.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FDTopicsViewController;
@interface HttpTopicInit : NSObject
+(id)sharedInstance;
- (void)loadTopicInitWithController:(FDTopicsViewController *)controller button:(UIButton *)sender;
@end
