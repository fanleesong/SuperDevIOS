//
//  Mood.h
//  Weather
//
//  Created by 15 on 14-3-15.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mood : NSObject


@property(nonatomic,retain) NSString *content;
@property(nonatomic,retain) NSString *day;
@property(nonatomic,retain) NSString *time;

+ (id)initWithContent:(NSString *)cont day:(NSString *)daystr time:(NSString *)timestr;


@end
