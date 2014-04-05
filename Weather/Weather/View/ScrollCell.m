//
//  ScrollCell.m
//  Weather
//
//  Created by 15 on 14-3-16.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "ScrollCell.h"

@implementation ScrollCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //城市名字
//        self.cityname = [[[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 40)] autorelease];
//        self.cityname.font = [UIFont systemFontOfSize:25];
//        
//        //天气
//        self.weather = [[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 30)] autorelease];
//        
//        //温度
//        self.temperature = [[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 120, 30)] autorelease];
//        
//        //日期
//        self.date = [[[UILabel alloc] initWithFrame:CGRectMake(20, 160, 200, 30)] autorelease];

        self.cityname = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)] autorelease];
        self.cityname.font = [UIFont systemFontOfSize:25];
        self.cityname.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.cityname];
        
        self.weather = [[[UILabel alloc] initWithFrame:CGRectMake(10, 90, 100, 30)] autorelease];
        self.weather.textColor = [UIColor whiteColor];
        [self addSubview:self.weather];
        
        self.temperature = [[[UILabel alloc] initWithFrame:CGRectMake(10, 50, 120, 30)] autorelease];
        self.temperature.textColor = [UIColor whiteColor];
        [self addSubview:self.temperature];
        
        self.date = [[[UILabel alloc] initWithFrame:CGRectMake(10, 130, 200, 30)] autorelease];
        self.date.textColor = [UIColor whiteColor];
        [self addSubview:self.date];
        
        
        
        
        // Initialization code
    }
    return self;
}


- (void)dealloc
{
    [_cityname release];
    [_weather release];
    [_temperature release];
    [_date release];
    [super dealloc];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
