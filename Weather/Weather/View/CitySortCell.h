//
//  CitySortCell.h
//  Weather
//
//  Created by 15 on 14-3-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySortCell : UITableViewCell

@property(nonatomic,retain) NSString *city;
@property(nonatomic,retain) NSString *content;
@property(nonatomic,retain) NSString *sub;

- (void)setMessage;


@end
