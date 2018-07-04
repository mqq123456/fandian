//
//  GpsCorrect.h
//  SP
//
//  Created by Apple on 14/7/18.
//  Copyright (c) 2014年 qqworkroom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LngLat.h"
#define T_PI 3.14159265358979324
#define T_A 6378245.0
#define T_EE 0.00669342162296594323

@interface GpsCorrect : NSObject
-(LngLat *)transform:(double) lat longitude:(double) lng;
-(BOOL)outOfChina:(double) lat longitude:(double) lng;
-(double)transformLat:(double) x latitude:(double) y;
-(double)transformLng:(double) x latitude:(double) y;
@end
