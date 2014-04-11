//
//  ViewController.m
//  UIDeviceAutoFit
//
//  Created by 范林松 on 14-4-10.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.views = [[UIView alloc] initWithFrame:CGRectMake(10,30,40,80)];
    self.views.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.views];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
