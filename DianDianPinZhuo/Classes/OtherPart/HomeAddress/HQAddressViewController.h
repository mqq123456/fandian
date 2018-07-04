//
//  HQAddressViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/8/22.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "RootViewController.h"

@protocol HQAddressViewControllerDelegate <NSObject>

- (void)backWithAddress:(NSString *)address lng:(NSString *)lng lat:(NSString *)lat;

@end


@interface HQAddressViewController : RootViewController
@property (nonatomic ,copy) NSString *lat;
@property (nonatomic ,copy) NSString *lng;
@property (nonatomic,assign) id<HQAddressViewControllerDelegate>delegate;
@end
