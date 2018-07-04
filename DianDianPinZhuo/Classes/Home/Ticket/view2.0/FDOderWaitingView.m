//
//  FDOderWaitingView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDOderWaitingView.h"

@implementation FDOderWaitingView

+(instancetype)selfWaitingView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"FDOderWaitingView" owner:nil options:nil][0];
}
- (void)layoutSubviews{

    [super layoutSubviews];
    

}
@end
