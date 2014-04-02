//
//  QYBaseNavigationController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseNavigationController.h"
#import "QYProfileWebViewController.h"
@interface QYBaseNavigationController ()

@end

@implementation QYBaseNavigationController

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
	// Do any additional setup after loading the view.
    
    
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_titleBar.png"] forBarMetrics:UIBarMetricsDefault];
    
//    self.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top.png"]];
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
