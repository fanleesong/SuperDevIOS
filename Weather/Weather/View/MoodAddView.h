//
//  MoodAddView.h
//  Weather
//
//  Created by 15 on 14-3-15.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodCell.h"

@protocol MoodAddViewDelegate <NSObject>

- (void)saveMoodRefresh;

@end

@interface MoodAddView : UIView


@property(nonatomic,retain) NSString *titlestr;
@property(nonatomic,retain) NSString *daystr;
@property(nonatomic,retain) NSString *timestr;

@property(nonatomic,retain) MoodCell *cell;
@property(nonatomic,assign) float yset;

@property(nonatomic,assign) id<MoodAddViewDelegate> delegate;

- (void)starAnim;
- (void)setMoodCell;
- (void)setEditMoodCell;
@end
