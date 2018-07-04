//
//  FDTopicUsersView.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTopicUsersView : UIView

@property (nonatomic, strong) NSArray *photos;
+ (CGSize)sizeWithCount:(NSUInteger)count;
@end
