//
//  OccupationModel.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OccupationModel : NSObject
///某个行业名称
@property (copy,nonatomic) NSString *name;

///其行业下所有职业信息
@property (strong,nonatomic) NSMutableArray *children;
@end
