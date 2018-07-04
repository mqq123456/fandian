//
//  FDNearMerchantViewController.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootTableViewController.h"
#import "HMLoadMoreFooter.h"

@interface FDNearMerchantViewController : RootTableViewController
@property (nonatomic ,strong) UIView *headView;
@property (nonatomic ,strong) UILabel *descriptionLabel;
@property(nonatomic,weak)HMLoadMoreFooter *footer;
@property (nonatomic ,copy) NSString *soldout_hint;
@end
