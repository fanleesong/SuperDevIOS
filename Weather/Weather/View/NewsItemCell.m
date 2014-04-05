//
//  NewsItemCell.m
//  Weather
//
//  Created by GML on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "NewsItemCell.h"

@implementation NewsItemCell


- (void)dealloc
{
    
    [_newsPublishDateLabel release];
    [_newsTitleLabel release];
    [_image release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.newsTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 260, 50)] autorelease];
        [self addSubview:self.newsTitleLabel];
        
        self.image = [[[UIImageView alloc] init] autorelease];
        self.image.frame = CGRectMake(15, 25,20, 20);
        self.image.image = [UIImage imageNamed:@"标签_百科.png"];
        [self addSubview:self.image];
        
        self.newsPublishDateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(220, 45, 125, 10)] autorelease];
        [self addSubview:self.newsPublishDateLabel];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
    
}

@end
