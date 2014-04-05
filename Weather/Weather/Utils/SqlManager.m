//
//  SqlManager.m
//  Weather
//
//  Created by 15 on 14-3-11.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "SqlManager.h"
#import "Mood.h"

@implementation SqlManager

static sqlite3 *dataBasePointer = nil;

+ (sqlite3 *)openDateBase
{
    if (dataBasePointer == nil) {
        NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [document stringByAppendingPathComponent:@"weather.sqlite"];
        NSFileManager *filemanager = [NSFileManager defaultManager];
        NSLog(@"%@",filePath);
        
        if (![filemanager fileExistsAtPath:filePath]) {
            NSString *orignalfile = [[NSBundle mainBundle] pathForResource:@"weather" ofType:@"sqlite"];
            
            NSError *error = nil;
            [filemanager copyItemAtPath:orignalfile toPath:filePath error:&error];
            if (error != nil) {
//                NSLog(@"%@",[error description]);
                return nil;
            }
        }
        
        //拷贝成功，打开沙盒下面的数据库
        sqlite3_open([filePath UTF8String], &dataBasePointer);
    }
    return dataBasePointer;
    
}


+ (void)closeDateBase
{
    if (dataBasePointer != nil) {
        sqlite3_close(dataBasePointer);
        dataBasePointer = nil;
    }
}


- (NSArray *)getProvinceCity:(NSInteger)number
{
    sqlite3 *database = [SqlManager openDateBase];
    sqlite3_stmt *statement = nil;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    NSString *sqlstr = [NSString stringWithFormat:@"select cityname from citynumber where citynumber like '%d%%';",number];
    
    const char *sql = [sqlstr UTF8String];
    
    int result = sqlite3_prepare_v2(database, sql, -1, &statement, nil);
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            const unsigned char *name = sqlite3_column_text(statement, 0);
            
            NSString *cityname = [NSString stringWithUTF8String:(const char *)name];
            [array addObject:cityname];
        }
        
    }
    sqlite3_finalize(statement);
    [SqlManager closeDateBase];
    return array;
}


- (NSString *)getcityid:(NSString *)city
{
    sqlite3 *database = [SqlManager openDateBase];
    sqlite3_stmt *statement = nil;
    
    NSString *sqlstr = [NSString stringWithFormat:@"select citynumber from citynumber where cityname like '%%%@%%';",city];
    const char *sql = [sqlstr UTF8String];
    int result = sqlite3_prepare_v2(database, sql, -1, &statement, nil);
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            const unsigned char *name = sqlite3_column_text(statement, 0);
            
            NSString *cityname = [NSString stringWithUTF8String:(const char *)name];
            sqlite3_finalize(statement);
            [SqlManager closeDateBase];
            return cityname;
        }
    }
    sqlite3_finalize(statement);
    [SqlManager closeDateBase];
    return nil;
}


- (NSArray *)getCity:(NSString *)city
{
    sqlite3 *database = [SqlManager openDateBase];
    sqlite3_stmt *statement = nil;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    NSString *sqlstr = [NSString stringWithFormat:@"select cityname from citynumber where cityname like '%%%@%%';",city];
    const char *sql = [sqlstr UTF8String];
    
    int result = sqlite3_prepare_v2(database, sql, -1, &statement, nil);
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            const unsigned char *name = sqlite3_column_text(statement, 0);
            
            NSString *cityname = [NSString stringWithUTF8String:(const char *)name];
            [array addObject:cityname];
        }
        
    }
    sqlite3_finalize(statement);
    [SqlManager closeDateBase];
    return array;
}


//根据日期查询当月的所有记录
- (NSArray *)getMood:(NSString *)mouth
{
    NSMutableArray *muarray = [NSMutableArray arrayWithCapacity:1];
    sqlite3 *database = [SqlManager openDateBase];
    sqlite3_stmt *statement = Nil;
    
    NSArray *array1 = [mouth componentsSeparatedByString:@"-"];
    NSString *condition = [NSString stringWithFormat:@"%@-%@",[array1 objectAtIndex:0],[array1 objectAtIndex:1]];
    NSString *sqlstr = [NSString stringWithFormat:@"select * from mood where day like '%%%@%%';",condition];
    const char *sql = [sqlstr UTF8String];
    
    int result = sqlite3_prepare_v2(database, sql, -1, &statement, nil);
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            const unsigned char *content = sqlite3_column_text(statement, 1);
            const unsigned char *day = sqlite3_column_text(statement, 2);
            const unsigned char *time = sqlite3_column_text(statement, 3);
            
            NSString *contentstr = [NSString stringWithUTF8String:(const char *)content];
            NSString *daystr = [NSString stringWithUTF8String:(const char *)day];
            NSString *timestr = [NSString stringWithUTF8String:(const char *)time];
            
            Mood *mood = [Mood initWithContent:contentstr day:daystr time:timestr];
            [muarray addObject:mood];
            
        }
        
    }
    sqlite3_finalize(statement);
    [SqlManager closeDateBase];
    return muarray;
}

- (NSArray *)getTodayMood:(NSString *)today
{
    NSMutableArray *muarray = [NSMutableArray arrayWithCapacity:1];
    sqlite3 *database = [SqlManager openDateBase];
    sqlite3_stmt *statement = Nil;
    
    NSString *sqlstr = [NSString stringWithFormat:@"select * from mood where day like '%@';",today];
    const char *sql = [sqlstr UTF8String];
    
    int result = sqlite3_prepare_v2(database, sql, -1, &statement, nil);
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            const unsigned char *content = sqlite3_column_text(statement, 1);
            const unsigned char *day = sqlite3_column_text(statement, 2);
            const unsigned char *time = sqlite3_column_text(statement, 3);
            
            NSString *contentstr = [NSString stringWithUTF8String:(const char *)content];
            NSString *daystr = [NSString stringWithUTF8String:(const char *)day];
            NSString *timestr = [NSString stringWithUTF8String:(const char *)time];
            
            Mood *mood = [Mood initWithContent:contentstr day:daystr time:timestr];
            [muarray addObject:mood];
            
        }
        
    }
    sqlite3_finalize(statement);
    [SqlManager closeDateBase];
    return muarray;
}


//插入一条记录
- (void)addMood:(NSString *)content day:(NSString *)daystr time:(NSString *)timestr
{
    sqlite3 *database = [SqlManager openDateBase];
    NSString *sqlstr = [NSString stringWithFormat:@"insert into mood (content,day,time) values ('%@','%@','%@');",content,daystr,timestr];
    const char *sql = [sqlstr UTF8String];
    sqlite3_exec(database, sql, Nil, Nil, Nil);
    [SqlManager closeDateBase];
}

//跟新一条记录
- (void)update:(NSString *)content day:(NSString *)daystr time:(NSString *)timestr
{
    sqlite3 *database = [SqlManager openDateBase];
    NSString *sqlstr = [NSString stringWithFormat:@"update mood set content = '%@',time = '%@' where day like '%%%@%%';",content,timestr,daystr];
    const char *sql = [sqlstr UTF8String];
    int i = sqlite3_exec(database, sql, Nil, Nil, Nil);
    [SqlManager closeDateBase];
}


@end
