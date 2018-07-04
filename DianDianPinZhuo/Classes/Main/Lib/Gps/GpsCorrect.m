//
//  GpsCorrect.m
//  SP
//
//  Created by Apple on 14/7/18.
//  Copyright (c) 2014年 qqworkroom. All rights reserved.
//

#import "GpsCorrect.h"

@implementation GpsCorrect

-(LngLat *)transform:(double) lat longitude:(double) lng{
    LngLat *lnglat=[[LngLat alloc] init];
    
    if ([self outOfChina:lat longitude:lng]) {
        lnglat.latitude = lat;
        lnglat.longitude = lng;
    }else{
        double dLat = [self transformLat:lng - 105.0 latitude:lat - 35.0];
        double dLon = [self transformLng:lng - 105.0 latitude:lat - 35.0];
        double radLat = lat / 180.0 * T_PI;
        double magic = sin(radLat);
        magic = 1 - T_EE * magic * magic;
        double sqrtMagic = sqrt(magic);
        dLat = (dLat * 180.0) / ((T_A * (1 - T_EE)) / (magic * sqrtMagic) * T_PI);
        dLon = (dLon * 180.0) / (T_A / sqrtMagic * cos(radLat) * T_PI);
        lnglat.latitude = lat + dLat;
        lnglat.longitude =lng + dLon;
    }
    return lnglat;
}

-(BOOL)outOfChina:(double) lat longitude:(double) lng{
    if (lng < 72.004 || lng > 137.8347)
        return TRUE;
    if (lat < 0.8293 || lat > 55.8271)
        return TRUE;
    return FALSE;
}

-(double)transformLat:(double) x latitude:(double) y{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * T_PI) + 20.0 * sin(2.0 * x * T_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * T_PI) + 40.0 * sin(y / 3.0 * T_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * T_PI) + 320 * sin(y * T_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

-(double)transformLng:(double) x latitude:(double) y{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * T_PI) + 20.0 * sin(2.0 * x * T_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * T_PI) + 40.0 * sin(x / 3.0 * T_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * T_PI) + 300.0 * sin(x / 30.0 * T_PI)) * 2.0 / 3.0;
    return ret;
}

@end
