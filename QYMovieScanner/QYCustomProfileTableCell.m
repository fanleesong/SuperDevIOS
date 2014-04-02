//
//  QYCustomProfileTableCell.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-13.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYCustomProfileTableCell.h"

@implementation QYCustomProfileTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self _initImageViewLabel];
    }
    return self;
}

//初始化视图
-(void)_initImageViewLabel{

    //图片
//    self.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]] autorelease];
    self.backgroundView = [[[UIImageView alloc] init] autorelease];
//    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundView.alpha = 0.5;
    self.backgroundView.frame = CGRectMake(10,0, self.bounds.size.width-20, self.bounds.size.height);
    [self.contentView addSubview: self.backgroundView];
    //
    self.instructLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, self.bounds.size.height-20)] autorelease];
    self.instructLabel.textAlignment = NSTextAlignmentLeft;
    self.instructLabel.font = [UIFont systemFontOfSize:15.0f];
    self.instructLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.contentView addSubview:self.instructLabel];
    
    self.rightNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(260, 10, 30, self.bounds.size.height-20)] autorelease];
    self.rightNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.rightNumberLabel.font = [UIFont systemFontOfSize:15.0f];
    self.rightNumberLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.rightNumberLabel];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc{
    RELEASE_SAFETY(_backgroundImage);
    RELEASE_SAFETY(_instructLabel);
    RELEASE_SAFETY(_rightNumberLabel);
    [super dealloc];
}

@end
