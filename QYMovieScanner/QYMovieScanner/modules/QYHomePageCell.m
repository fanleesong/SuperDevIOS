//
//  QYHomePageCell.m
//  QYMovieScanner
//
//  Created by BB on 14-3-13.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYHomePageCell.h"
#import "QYVideoModule.h"
#import "UIImageView+WebCache.h"


@implementation QYHomePageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i = 0; i<3; i++) {
         
            //单元格视频截图
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8 + 104 * i, 8, 96, 60)];
            imageView.tag = 1100 + i;            
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.contentMode = UIViewContentModeRedraw;
            //
            UILabel * userLable = [[UILabel alloc] initWithFrame:CGRectMake(8 + 104 *i , 8, 100, 80)];
            userLable.tag = 2000 + i;
            userLable.userInteractionEnabled = YES;
            //为单元格添加单机手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            [userLable addGestureRecognizer:tapGesture];
            RELEASE_SAFETY(tapGesture);
            //每个截图上显示的视频总时间长度
            UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, 48, 15)];
            timeLabel.backgroundColor = [UIColor clearColor];
            timeLabel.textAlignment = NSTextAlignmentLeft;
            timeLabel.font = [UIFont boldSystemFontOfSize:12];
            timeLabel.textColor = [UIColor whiteColor];
            //每个截图对应的标题说明
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + 104 * i, 68, 96, 30)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.numberOfLines = 2;
            titleLabel.font = [UIFont boldSystemFontOfSize:10];
            titleLabel.tag = 1200 + i;
            [imageView addSubview:timeLabel];
            [self.contentView addSubview:imageView];
            [self.contentView addSubview:titleLabel];
            [self.contentView addSubview:userLable];
            //安全释放
            RELEASE_SAFETY(imageView);
            RELEASE_SAFETY(timeLabel);
            RELEASE_SAFETY(titleLabel);
            RELEASE_SAFETY(userLable);
        }
    }
    return self;
}
//设置cell工厂
- (void)setCellForDataArray
{
    for (id object in self.contentView.subviews) {
        if ([object isKindOfClass:[UIImageView class]]) {
            UIImageView * imageView = (UIImageView *)object;
            if (imageView.tag == 1100 ) {
                QYVideoModule * firstVideo = [_dataForCellArray objectAtIndex:0];
                [imageView setImageWithURL:[NSURL URLWithString:firstVideo.picUrl]];
                UILabel * timelabel =(UILabel *)[[imageView subviews] objectAtIndex:0];
                NSString * totalTimeString = [NSString stringWithFormat:@"%@",firstVideo.totalTime];
                timelabel.text = totalTimeString;

//                NSLog(@"1111====%@",timelabel.text);
                firstVideo = nil;
            }else if(imageView.tag == 1101){
                QYVideoModule * firstVideo = [_dataForCellArray objectAtIndex:1];
                [imageView setImageWithURL:[NSURL URLWithString:firstVideo.picUrl]];
                UILabel * timelabel = [[imageView subviews] objectAtIndex:0];
                NSString * totalTimeString = [NSString stringWithFormat:@"%@",firstVideo.totalTime];
                timelabel.text = totalTimeString;
            }else if (imageView.tag == 1102){
                QYVideoModule * firstVideo = [_dataForCellArray objectAtIndex:2];
                [imageView setImageWithURL:[NSURL URLWithString:firstVideo.picUrl]];
                UILabel * timelabel = [[imageView subviews] objectAtIndex:0];
                NSString * totalTimeString = [NSString stringWithFormat:@"%@",firstVideo.totalTime];
                timelabel.text = totalTimeString;;
            }
        }else if ([object isKindOfClass:[UILabel class]]){
            UILabel * titleLable = (UILabel *)object;
            if (titleLable.tag == 1200) {
                QYVideoModule * firstVideo = [_dataForCellArray objectAtIndex:0];
                titleLable.text = firstVideo.title;
            }else if (titleLable.tag == 1201){
                QYVideoModule * firstVideo = [_dataForCellArray objectAtIndex:1];
                titleLable.text = firstVideo.title;
            }else if (titleLable.tag == 1202){
                QYVideoModule * firstVideo = [_dataForCellArray objectAtIndex:2];
                titleLable.text = firstVideo.title;
            }
        }        
    }
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    NSInteger i =  sender.view.tag - 2000;
    QYVideoModule * videoModule = [self.dataForCellArray objectAtIndex:i];
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageWithVideoModule:didClick:)]) {        
        [self.delegate imageWithVideoModule:videoModule didClick:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
