//
//  SelectDateView.m
//  CreateSqliteTable
//
//  Created by 刘国靖 on 14-3-10.
//  Copyright (c) 2014年 欧兰. All rights reserved.
//

#import "SelectDateView.h"
//#import <QuartzCore/QuartzCore.h>
@implementation SelectDateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAction)];
        [self addGestureRecognizer:tap];
        [tap release];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];//空白底面
        view.backgroundColor = [UIColor clearColor];
        self.selectView = [[[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 480 - 150) ] autorelease];//白色的view
        self.selectView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        label.text = @"请选择日期";
        label.textAlignment = NSTextAlignmentCenter;
        [self.selectView addSubview:label];
        [label release];
        UIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 50, 0, 0)];//日期类
        pickerView.tag = 100;
        pickerView.date = [NSDate date];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        pickerView.locale = locale;
        [locale release];
        pickerView.datePickerMode = UIDatePickerModeDate;
        //        pickerView.backgroundColor = [UIColor yellowColor];
        //取消按钮
        UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleButton.frame = CGRectMake(40, 246, 115, 30);
        [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        //        cancleButton.tintColor = [UIColor blackColor];tintColor不能改变字体颜色
        
        //确定按钮                属性设置
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(160, 246, 115, 30);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancleButton.backgroundColor = [UIColor whiteColor];
        [button setShowsTouchWhenHighlighted:YES];
        [cancleButton setShowsTouchWhenHighlighted:YES];
        //设置阴影
        button.layer.cornerRadius = 5;
        button.layer.shadowOffset = CGSizeMake(1 ,1);
        button.layer.shadowOpacity = 1.0;
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        cancleButton.layer.cornerRadius = 5;
        cancleButton.layer.shadowColor = [UIColor blackColor].CGColor;
        cancleButton.layer.shadowOffset = CGSizeMake(1, 1);
        cancleButton.layer.shadowOpacity = 1.0;
        //设置动画
        
        ////添加任务
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.selectView addSubview:button];
        [cancleButton addTarget:self action:@selector(handleButtonCancleAction) forControlEvents:UIControlEventTouchUpInside];
        //        cancleButton.backgroundColor = [UIColor yellowColor];
        [self.selectView addSubview:cancleButton];
        [self.selectView addSubview:pickerView];
        [pickerView release];
        [view addSubview:self.selectView];
        //        [self.selectView release];
        
        [view addSubview:self.selectView];
        [self addSubview:view];
        [view release];
        [UIView animateWithDuration:0.5 animations:^{
            self.selectView.frame = CGRectMake(0, 150, 320, 480 - 150);
        }];
    }
    return self;
}
//设置取消按钮
- (void)handleButtonCancleAction
{
    [self removeFromSuperview];
}

//确定按钮时间
- (void)handleButtonAction
{
    UIDatePicker *pickerView = (UIDatePicker *)[self viewWithTag:100];
    [self.delegate passValueOfDate:pickerView.date];
    [self removeFromSuperview];
    
}

- (void)removeAction
{
    [self removeFromSuperview];
}


- (void)dealloc
{
    [_date release];
    [_selectView release];
    [super dealloc];
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
