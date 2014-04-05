//
//  CityAirSort.h
//  Weather
//
//  Created by 15 on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityAirSort : NSObject



@property(nonatomic,retain) NSString *cityname;//城市名字
@property(nonatomic,retain) NSString *aqi;//空气污染指数
@property(nonatomic,retain) NSString *quality;//空气质量
@property(nonatomic,retain) NSString *pm;//pm2.5指数


+ (id)initWityCityname:(NSString *)name aqi:(NSString *)aqinumber quality:(NSString *)qualitynumber pm:(NSString *)pmnumber;


- (NSInteger)aqiInt;


- (NSInteger)pmInt;





@end
