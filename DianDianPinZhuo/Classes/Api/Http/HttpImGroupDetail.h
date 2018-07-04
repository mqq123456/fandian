//
//  HttpImGroupDetail.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatGroupDetailViewController;
@interface HttpImGroupDetail : NSObject
+(id)sharedInstance;
- (void)imGroupDetailWithGroupID:(NSString *)group_id viewController:(ChatGroupDetailViewController *)viewController;
@end
