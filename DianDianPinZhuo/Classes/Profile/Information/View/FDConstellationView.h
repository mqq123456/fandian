//
//  FDConstellationView.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDInformationViewController.h"

@interface FDConstellationView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    NSArray *titleArray;
    
}

@property(nonatomic,strong)FDInformationViewController *delegate;
@end
