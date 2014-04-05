//
//  CityAirSort.m
//  Weather
//
//  Created by 15 on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "CityAirSort.h"

@implementation CityAirSort



+ (id)initWityCityname:(NSString *)name aqi:(NSString *)aqinumber quality:(NSString *)qualitynumber pm:(NSString *)pmnumber
{
    CityAirSort *city = [[[CityAirSort alloc] init] autorelease];
    if (city != nil) {
        city.cityname = name;
        city.aqi = aqinumber;
        city.quality = qualitynumber;
        city.pm = pmnumber;
    }
    return city;
}

- (NSInteger)aqiInt
{
//    NSLog(@"get aqi int");
    NSString *resultstr = [NSString stringWithString:self.aqi];
    NSInteger result = [resultstr integerValue];
    return result;
}



- (NSInteger)pmInt
{
    NSString *resultstr = [NSString stringWithString:self.pm];
    NSInteger result = [resultstr integerValue];
    return result;
}


- (void)dealloc
{
    [_cityname release];//城市名字
    [_aqi release];//空气污染指数
    [_quality release];//空气质量
    [_pm release];//pm2.5指数
    [super dealloc];
}



@end
