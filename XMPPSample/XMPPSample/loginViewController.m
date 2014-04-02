//
//  loginViewController.m
//  XMPPSample
//
//  Created by 范林松 on 14-4-2.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "loginViewController.h"
#import "StreamManager.h"

@interface loginViewController ()

@end

@implementation loginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didClickBack:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(IBAction)didClickLogin:(id)sender{

    [[StreamManager defaultManager] loginWithName:self.nameField.text password:self.pwdField.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
