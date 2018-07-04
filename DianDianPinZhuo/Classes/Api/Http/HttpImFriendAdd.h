//
//  HttpImFriendAdd.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpImFriendAdd : NSObject
+(id)sharedInstance;
- (void)addFriendTopush:(NSString *)friend_kid;
@end
