//
//  MoodAddView.m
//  Weather
//
//  Created by 15 on 14-3-15.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "MoodAddView.h"
#import "SqlManager.h"
#import "Mood.h"

@interface MoodAddView ()

@property(nonatomic,retain) UIView *moodcell;
@property(nonatomic,retain) UITextField *textfield;
@property(nonatomic,retain) UIButton *savebutton;

@end

@implementation MoodAddView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
        self.textfield = [[[UITextField alloc] initWithFrame:CGRectMake(85, 4, 180, 30)] autorelease];
        self.textfield.textColor = [UIColor whiteColor];
        self.textfield.font = [UIFont boldSystemFontOfSize:17];
        
        
        self.savebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.savebutton.frame = CGRectMake(250, 4, 60, 40);
        [self.savebutton setTitle:@"保存" forState:UIControlStateNormal];
        [self.savebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.savebutton addTarget:self action:@selector(saveMood) forControlEvents:UIControlEventTouchUpInside];
        
        
        // Initialization code
    }
    return self;
}


- (void)starAnim
{
    self.moodcell = [[[UIView alloc] initWithFrame:CGRectMake(0, self.yset + 50, self.frame.size.width, 50)] autorelease];
    self.moodcell.backgroundColor = [UIColor clearColor];
    self.cell = [[[MoodCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)] autorelease];
    
    [self.moodcell addSubview:self.cell];
    
    
    [self addSubview:self.moodcell];
    
    [UIView animateWithDuration:0.7 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
        self.moodcell.frame = CGRectMake(0, self.frame.size.height / 2 - 100, self.frame.size.width, 50);
    } completion:^(BOOL finished) {
        //添加保存按钮
        [self.cell addSubview:self.savebutton];
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < self.moodcell.frame.origin.y || point.y > self.moodcell.frame.origin.y + self.moodcell.frame.size.height) {
        //如果不保存就移除输入框
//        [self.textfield removeFromSuperview];
        [UIView animateWithDuration:0.7 animations:^{
            //撤销移除保存按钮
            [self.savebutton removeFromSuperview];
            
            self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
            self.moodcell.frame = CGRectMake(0, self.yset + 50, self.frame.size.width, 50);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)saveMood
{
    [UIView animateWithDuration:1 animations:^{
        //撤销移除保存按钮
        [self.savebutton removeFromSuperview];
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
        self.moodcell.frame = CGRectMake(0, self.yset + 50, self.frame.size.width, 50);
    } completion:^(BOOL finished) {
        
        //刷新表示图
        if (self.delegate && [self.delegate respondsToSelector:@selector(saveMoodRefresh)]) {
            [self.delegate saveMoodRefresh];
        }
        
        [self removeFromSuperview];
    }];
    
    //如果数据库中有记录更新，没有就插入
    SqlManager *manager = [[SqlManager alloc] init];
    NSArray *array = [manager getTodayMood:self.daystr];
    if (array.count == 0) {
        //插入数据库
        [manager addMood:self.textfield.text day:self.cell.daystr time:self.cell.timestr];
    }else {
        [manager update:self.textfield.text day:self.cell.daystr time:self.cell.timestr];
    }
    [manager release];
    
    
    
}

//添加按钮时刷新方法
- (void)setMoodCell
{
//    self.cell.titlestr = self.titlestr;
    self.cell.daystr = self.daystr;
    self.cell.timestr = self.timestr;
    
    //添加时添加一个输入框
    [self.moodcell addSubview:self.textfield];
    self.textfield.text = self.titlestr;
    [self.textfield becomeFirstResponder];
    
    [self.cell setMessage];
}


//点击编辑时的刷新方法
- (void)setEditMoodCell
{
//    self.cell.titlestr = self.titlestr;
    self.cell.daystr = self.daystr;
    self.cell.timestr = self.timestr;
    self.cell.title.hidden = YES;
    
    //添加时添加一个输入框
    [self.moodcell addSubview:self.textfield];
    self.textfield.text = self.titlestr;
    [self.textfield becomeFirstResponder];
    
    [self.cell setMessage];
}


- (void)dealloc
{
    [_titlestr release];
    [_daystr release];
    [_timestr release];
    [_cell release];
    [_moodcell release];
    [_textfield release];
    [_savebutton release];
    [super dealloc];
}




@end
