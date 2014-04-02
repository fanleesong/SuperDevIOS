//
//  ViewController.h
//  XMPPSample
//
//  Created by 范林松 on 14-4-2.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StreamManager.h"

@interface ViewController : UIViewController

@property(nonatomic,strong)IBOutlet UITextField *nameField;
@property(nonatomic,strong)IBOutlet UITextField *pwdField;

//点击提交按钮
-(IBAction)didClickCommit:(id)sender;
//点击取消按钮方法
-(IBAction)didClickCancel:(id)sender;


@end
