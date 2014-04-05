//
//  CitySort.h
//  Weather
//
//  Created by 15 on 14-3-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitySort : NSObject

@property(nonatomic,retain) NSString *cityname;
@property(nonatomic,retain) NSString *temperature;


+ (id)initWithCityname:(NSString *)city temperature:(NSString *)temp;

- (NSInteger)getMax;


@end
