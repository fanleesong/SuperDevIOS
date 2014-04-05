//
//  ViewCell.h
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCell : UIView


@property(nonatomic,retain) NSString *imagename;//天气图片的名字
@property(nonatomic,retain) NSString *datestring;//日期
@property(nonatomic,retain) NSString *weather;//天气
@property(nonatomic,retain) NSString *temperature;//温度


- (void)refresh;


@end
