//
//  CitySort.m
//  Weather
//
//  Created by 15 on 14-3-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "CitySort.h"

@implementation CitySort

+ (id)initWithCityname:(NSString *)city temperature:(NSString *)temp
{
    CitySort *sort = [[[CitySort alloc] init] autorelease];
    if (sort != Nil) {
        sort.cityname = city;
        sort.temperature = temp;
    }
    return sort;
}


- (NSInteger)getMax
{
    //13℃~3℃
    NSArray *array = [self.temperature componentsSeparatedByString:@"~"];
    NSString *first = [array objectAtIndex:0];
    NSString *second = [array objectAtIndex:1];
    
    NSArray *arrayfirst = [first componentsSeparatedByString:@"℃"];
    NSArray *arraysecond = [second componentsSeparatedByString:@"℃"];
    
    NSString *firststr = [arrayfirst objectAtIndex:0];
    NSString *secondstr = [arraysecond objectAtIndex:0];;
    
    NSInteger number1 = [firststr integerValue];
    NSInteger number2 = [secondstr integerValue];
    return number1 > number2 ? number1 : number2;
}

- (void)dealloc
{
    [_cityname release];
    [_temperature release];
    [super dealloc];
}

@end
