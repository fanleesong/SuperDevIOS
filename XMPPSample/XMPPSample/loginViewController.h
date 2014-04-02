//
//  loginViewController.h
//  XMPPSample
//
//  Created by 范林松 on 14-4-2.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "ViewController.h"

@interface loginViewController : ViewController

@property(nonatomic,strong)IBOutlet UITextField *nameField;
@property(nonatomic,strong)IBOutlet UITextField *pwdField;


-(IBAction)didClickLogin:(id)sender;
-(IBAction)didClickBack:(id)sender;



@end
