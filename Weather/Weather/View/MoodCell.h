//
//  MoodCell.h
//  Weather
//
//  Created by 15 on 14-3-14.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoodCell : UITableViewCell


@property(nonatomic,retain) NSString *titlestr;
@property(nonatomic,retain) NSString *daystr;
@property(nonatomic,retain) NSString *timestr;

@property(nonatomic,retain) UILabel *title;

- (void)setMessage;



@end
