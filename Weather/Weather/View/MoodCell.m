//
//  MoodCell.m
//  Weather
//
//  Created by 15 on 14-3-14.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "MoodCell.h"

@interface MoodCell ()


@property(nonatomic,retain) UILabel *dayDate;
@property(nonatomic,retain) UILabel *timeDate;


@end



@implementation MoodCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //背景图
        UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 300, 45)];
        back.image = [UIImage imageNamed:@"tablelist_1p.png"];
        [self addSubview:back];
//        [back release];
        
        
        //左边的铅笔图片
        UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 65, 45)];
        left.image = [UIImage imageNamed:@"txt.png"];
        [back addSubview:left];
        [left release];
        
        
        //标题
        self.title = [[[UILabel alloc] initWithFrame:CGRectMake(75, 0, 200, 30)] autorelease];
//        self.title.text = @"不高兴";
        self.title.font = [UIFont boldSystemFontOfSize:17];
        self.title.textColor = [UIColor whiteColor];
        self.title.backgroundColor = [UIColor clearColor];
        [back addSubview:self.title];
        
        
        //日期
        self.dayDate = [[[UILabel alloc] initWithFrame:CGRectMake(90, 30, 100, 10)] autorelease];
        self.dayDate.textColor = [UIColor whiteColor];
        self.dayDate.font = [UIFont systemFontOfSize:12];
//        self.dayDate.text = @"2014-12-20";
        [back addSubview:self.dayDate];
        
        
        //小时
        self.timeDate = [[[UILabel alloc] initWithFrame:CGRectMake(170, 30, 100, 10)] autorelease];
        self.timeDate.textColor = [UIColor whiteColor];
        self.timeDate.font = [UIFont systemFontOfSize:12];
//        self.timeDate.text = @"12:37:28";
        [back addSubview:self.timeDate];
        
        
        
        [back release];
        // Initialization code
    }
    return self;
}


- (void)setMessage
{
    self.title.text = self.titlestr;
    self.dayDate.text = self.daystr;
    self.timeDate.text = self.timestr;
}


- (void)dealloc
{
    [_titlestr release];
    [_daystr release];
    [_timestr release];
    [_title release];
    [_dayDate release];
    [_timeDate release];
    [super dealloc];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
