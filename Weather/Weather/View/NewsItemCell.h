//
//  NewsItemCell.h
//  Weather
//
//  Created by GML on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsItemCell : UITableViewCell

@property (nonatomic,retain) UILabel *newsTitleLabel; // 新闻标题
@property (nonatomic,retain) UILabel *newsPublishDateLabel; // 发布日期
@property (nonatomic,retain) UIImageView *image; //

@end
