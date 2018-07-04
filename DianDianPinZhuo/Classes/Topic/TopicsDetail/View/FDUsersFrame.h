//
//  FDUsersFrame.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FDUsersFrame : NSObject
@property (nonatomic, strong) NSArray *status;
@property (nonatomic, copy) NSString *joinPeople;
@property (nonatomic, assign) BOOL left_seat;

@property (nonatomic,assign) CGRect photosViewF;
@property (nonatomic,assign) CGRect headViewF;
@property (nonatomic,assign) CGRect gapViewF;
@property (nonatomic,assign) CGRect lineViewF;
@property (nonatomic,assign) CGRect iconF;
@property (nonatomic,assign) CGRect peopleF;
@property (nonatomic,assign) CGRect people_descF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
