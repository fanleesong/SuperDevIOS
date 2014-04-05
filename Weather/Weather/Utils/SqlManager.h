//
//  SqlManager.h
//  Weather
//
//  Created by 15 on 14-3-11.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface SqlManager : NSObject


+ (sqlite3 *)openDateBase;
+ (void)closeDateBase;


//根据省会的名字得到市级城市
- (NSArray *)getProvinceCity:(NSInteger)number;

//根据城市的名字得到cityid
- (NSString *)getcityid:(NSString *)city;

//搜索框查询
- (NSArray *)getCity:(NSString *)city;

//根据日期查询当月的所有记录
- (NSArray *)getMood:(NSString *)mouth;

//查询当天的信息
- (NSArray *)getTodayMood:(NSString *)today;

//插入一条记录
- (void)addMood:(NSString *)content day:(NSString *)daystr time:(NSString *)timestr;

//跟新一条记录
- (void)update:(NSString *)content day:(NSString *)daystr time:(NSString *)timestr;



@end
