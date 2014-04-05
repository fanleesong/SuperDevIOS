//
//  WeiboEditViewController.m
//  Weather
//
//  Created by 15 on 14-3-20.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "WeiboEditViewController.h"


@interface WeiboEditViewController ()

@property(nonatomic,retain) UITextView *text;


@end

@implementation WeiboEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.text = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.text.font = [UIFont systemFontOfSize:15];
    self.text.text = @"编辑内容";
    [self.view addSubview:self.text];
    [self.text becomeFirstResponder];
    
    //分享提示
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.text.frame.size.height, 80, 30)];
    label.text = @"分享到";
    [self.view addSubview:label];
    [label release];
    
    //分享按钮
    UIButton *sharebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    sharebutton.frame = CGRectMake(90, self.text.frame.size.height, 30, 30);
    [sharebutton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [sharebutton addTarget:self action:@selector(commitShare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sharebutton];
    
    //退出按钮
    UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake(0, label.frame.origin.y + 30, 50, 30)];
    [exit setTitle:@"返回" forState:UIControlStateNormal];
    [exit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    exit.titleLabel.textAlignment = NSTextAlignmentLeft;
    [exit addTarget:self action:@selector(goToMoodView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exit];
    [exit release];
    
    //注销
    UIButton *weiboexit = [[UIButton alloc] initWithFrame:CGRectMake(60, label.frame.origin.y + 30, 80, 30)];
    [weiboexit setTitle:@"注销" forState:UIControlStateNormal];
    [weiboexit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    weiboexit.titleLabel.textAlignment = NSTextAlignmentLeft;
    [weiboexit addTarget:self action:@selector(weiboexit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weiboexit];
    [weiboexit release];
    
    
    
	// Do any additional setup after loading the view.
}

//返回
- (void)goToMoodView
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//分享提交
- (void)commitShare
{
//    UIImage *pic = [UIImage imageNamed:@"icon.png"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   self.text.text, @"content",
                                   nil];
    [self.wbapi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
    //[pic release];
    [params release];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//微博退出
- (void)weiboexit
{
    [self.wbapi  cancelAuth];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [_text release];
    [super dealloc];
}


@end
