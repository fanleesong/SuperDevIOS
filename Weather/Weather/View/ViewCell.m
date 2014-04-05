//
//  ViewCell.m
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "ViewCell.h"

@interface ViewCell ()

@property(nonatomic,retain) UIImageView *imagel;
@property(nonatomic,retain) UILabel *datel;
@property(nonatomic,retain) UILabel *weatherl;
@property(nonatomic,retain) UILabel *temperaturel;

@end

@implementation ViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
        self.imagel = [[[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 40, 40)] autorelease];
        [self addSubview:self.imagel];
        
        
        self.datel = [[[UILabel alloc] initWithFrame:CGRectMake(50, 5, 160, 30)] autorelease];
        self.datel.backgroundColor = [UIColor clearColor];
        self.datel.textColor = [UIColor whiteColor];
        self.datel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.datel];
        
        
        self.weatherl = [[[UILabel alloc] initWithFrame:CGRectMake(140, 5, 100, 30)] autorelease];
        self.weatherl.backgroundColor = [UIColor clearColor];
        self.weatherl.textColor = [UIColor whiteColor];
        self.weatherl.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.weatherl];
        
        
        self.temperaturel = [[[UILabel alloc] initWithFrame:CGRectMake(220, 5, 100, 30)] autorelease];
        self.temperaturel.backgroundColor = [UIColor clearColor];
        self.temperaturel.textColor = [UIColor whiteColor];
//        self.temperaturel.text = self.temperature;
        self.temperaturel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.temperaturel];
        
        

        // Initialization code
    }
    return self;
}


- (void)refresh
{
    NSArray *array = [self.weather componentsSeparatedByString:@"转"];
    NSString *temp = [array objectAtIndex:0];
    
    NSString *imagestr = [NSString stringWithFormat:@"%@.png",temp];
    self.imagel.image = [UIImage imageNamed:imagestr];

//    if (self.imagel.image == nil) {
//        
//        NSRange range = [imagestr rangeOfString:@"多云"];
//        if (range.length != 0) {
//            imagestr = [NSString stringWithFormat:@"多云.png"];
//            self.imagel.image = [UIImage imageNamed:imagestr];
//        }
//        
//    }
    
    self.datel.text = self.datestring;
    self.weatherl.text = self.weather;
    self.temperaturel.text = self.temperature;
}

- (void)dealloc
{
    [_imagel release];
    [_datel release];
    [_weatherl release];
    [_temperaturel release];
    [_imagename release];//天气图片的名字
    [_datestring release];//日期
    [_weather release];//天气
    [_temperature release];//温度
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
