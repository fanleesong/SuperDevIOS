//
//  ViewController.m
//  XMPPSample
//
//  Created by 范林松 on 14-4-2.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark--------------------------
-(IBAction)didClickCancel:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];


}
-(IBAction)didClickCommit:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end












