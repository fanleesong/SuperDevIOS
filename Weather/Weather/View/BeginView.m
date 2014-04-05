//
//  BeginView.m
//  Weather
//
//  Created by 15 on 14-3-16.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "BeginView.h"

@interface BeginView ()

@property(nonatomic,retain) NSTimer *timer;


@end


@implementation BeginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        NSDate *date = [NSDate date];
//        NSDateFormatter *format = [NSDateFormatter a]
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:frame];
        image.image = [UIImage imageNamed:@"begin.png"];
        [self addSubview:image];
        [image release];
        
        
        
        
        
        
        // Initialization code
    }
    return self;
}


- (void)beginview
{
    [UIView animateWithDuration:4 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - 0.1);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
