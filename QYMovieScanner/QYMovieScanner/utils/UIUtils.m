//
//  UIUtils.m
//  WXTime
//
//  Created by wei.chen on 12-7-22.
//  Copyright (c) 2014年 范林松 All rights reserved.
//

#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UIUtils

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    
    //两种获取document路径的方式
//    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter release];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}

+ (NSString *)totalTimeFromString:(NSString *)totalString
{
    //毫秒值
    NSInteger timeValue = [totalString intValue];
    //总的秒值
    NSInteger minuteValue = timeValue/1000;
    //秒
    NSInteger secondeTime = minuteValue%60;
    NSInteger totalMinutesTime = minuteValue/60;
    //分
    NSInteger minuteTime = totalMinutesTime%60;
    //时
    NSInteger hourTime = totalMinutesTime/60;
    //统一格式
    NSString *secondeString;
    if (secondeTime < 10) {
        secondeString = [NSString stringWithFormat:@"0%d",secondeTime];
    }else{
        secondeString = [NSString stringWithFormat:@"%d",secondeTime];
    }
    NSString *minuteString;
    if (minuteTime < 10) {
        minuteString = [NSString stringWithFormat:@"0%d",minuteTime];
    }else{
        minuteString = [NSString stringWithFormat:@"%d",minuteTime];
    }
    NSString *hourString;
    if (hourTime < 10) {
        hourString = [NSString stringWithFormat:@"0%d",hourTime];
    }else{
        hourString = [NSString stringWithFormat:@"%d",hourTime];
    }
    
    NSString * timeString = [NSString stringWithFormat:@"%@:%@:%@",hourString,minuteString,secondeString];
    return timeString;
}


@end
