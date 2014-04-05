//
//  Mood.m
//  Weather
//
//  Created by 15 on 14-3-15.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "Mood.h"

@implementation Mood

+ (id)initWithContent:(NSString *)cont day:(NSString *)daystr time:(NSString *)timestr
{
    Mood *mood = [[[Mood alloc] init] autorelease];
    if (mood != nil) {
        mood.content = cont;
        mood.day = daystr;
        mood.time = timestr;
    }
    return mood;
}

- (void)dealloc
{
    [_content release];
    [_day release];
    [_time release];
    [super dealloc];
}



@end
