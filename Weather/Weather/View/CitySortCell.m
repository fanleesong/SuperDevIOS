//
//  CitySortCell.m
//  Weather
//
//  Created by 15 on 14-3-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "CitySortCell.h"

@interface CitySortCell ()

@property(nonatomic,retain) UILabel *cityl;
@property(nonatomic,retain) UILabel *contentl;
@property(nonatomic,retain) UILabel *subl;

@end

@implementation CitySortCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *citylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 130, 30)];
        citylabel.backgroundColor = [UIColor clearColor];
        citylabel.textColor = [UIColor whiteColor];
        citylabel.font = [UIFont systemFontOfSize:14];
        self.cityl = citylabel;
        [self addSubview:citylabel];
        [citylabel release];
        
        UILabel *contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 0, 100, 25)];
        contentlabel.backgroundColor = [UIColor clearColor];
        contentlabel.textColor = [UIColor whiteColor];
        contentlabel.font = [UIFont systemFontOfSize:13];
        self.contentl = contentlabel;
        [self addSubview:contentlabel];
        [contentlabel release];
        
        UILabel *sublabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 25, 120, 17)];
        sublabel.backgroundColor = [UIColor clearColor];
        sublabel.textColor = [UIColor whiteColor];
        sublabel.font = [UIFont systemFontOfSize:15];
        self.subl = sublabel;
        [self addSubview:sublabel];
        [sublabel release];
        
        
        // Initialization code
    }
    return self;
}


- (void)setMessage
{
    self.cityl.text = self.city;
    self.contentl.text = self.content;
    self.subl.text = self.sub;
    
}



- (void)dealloc
{
    [_city release];
    [_content release];
    [_sub release];
    [_cityl release];
    [_contentl release];
    [_subl release];
    [super dealloc];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
