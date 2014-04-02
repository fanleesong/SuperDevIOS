//
//  QYUserRegistViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-14.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYUserRegistViewController.h"

@interface QYUserRegistViewController ()

@end

@implementation QYUserRegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //初始化左边按钮
    UIBarButtonItem *leftButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_close_right.png"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewControllerAction:)] autorelease];
   
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
     UIBarButtonItem *rigthButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"personal_check.png"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissSaveInfoViewController:)] autorelease];
    self.navigationItem.rightBarButtonItem = rigthButtonItem;
    
    //添加一个手势
    UITapGestureRecognizer *tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    [self.view addGestureRecognizer:tapGuest];
    [tapGuest release];
    
    [self _initSomeProperty];
}
#pragma mark-----------实现手势-------------
-(void)handleTapGesture{
    
    NSLog(@"%s",__FUNCTION__);
    if (self.userNameTextField.becomeFirstResponder) {
        [self.userNameTextField resignFirstResponder];//撤销textfield第一响应者的状态，释放第一响应者
    }
    if (self.userPasswordTextField.becomeFirstResponder) {
        [self.userPasswordTextField resignFirstResponder];//撤销textfield第一响应者的状态，释放第一响应者
    }
    if (self.confirmPasswordField.becomeFirstResponder) {
        [self.confirmPasswordField resignFirstResponder];//撤销textfield第一响应者的状态，释放第一响应者
    }
    if (self.nickNameTextField.becomeFirstResponder) {
        [self.nickNameTextField resignFirstResponder];//撤销textfield第一响应者的状态，释放第一响应者
    }
    
}
#pragma maek---------实现退出模态视图-dismissViewControllerAction-----------
-(void)dismissViewControllerAction:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)dismissSaveInfoViewController:(UIBarButtonItem *)sender{

    //将数据保存并处理后
#warning -----------
    
    //保存后退出视图
    [self dismissViewControllerAnimated:YES completion:nil];

}

//初始化一些属性
-(void)_initSomeProperty{
    
    //    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(120, 90, 78, 33)];
    //    self.bgView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:self.bgView];
    
    //初始化昵称Label
    self.nickNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 90, 280, 40)] autorelease];
    self.nickNameLabel.text = @" 昵       称:";
    self.nickNameLabel.layer.borderWidth = 0.3;
    self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
    self.nickNameLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:self.nickNameLabel];
    //初始化邮箱Label
    self.userNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 135, 280, 40)] autorelease];
    self.userNameLabel.text = @" 邮       箱:";
    self.userNameLabel.backgroundColor = [UIColor whiteColor];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.layer.borderWidth = 0.3;
    self.userNameLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:self.userNameLabel];
    //初始化密码Label
    self.userPasswordLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 180, 280, 40)] autorelease];
    self.userPasswordLabel.text = @" 密       码:";
    self.userPasswordLabel.backgroundColor = [UIColor whiteColor];
    self.userPasswordLabel.textAlignment = NSTextAlignmentLeft;
    self.userPasswordLabel.layer.borderWidth = 0.3;
    self.userPasswordLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:self.userPasswordLabel];
    
    //初始化确认密码Label
    self.confirmPasswordLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 225, 280, 40)] autorelease];
    self.confirmPasswordLabel.text = @" 确认密码:";
    self.confirmPasswordLabel.font = [UIFont systemFontOfSize:14.0f];
    self.confirmPasswordLabel.backgroundColor = [UIColor whiteColor];
    self.confirmPasswordLabel.textAlignment = NSTextAlignmentLeft;
    self.confirmPasswordLabel.layer.borderWidth = 0.3;
    [self.view addSubview:self.confirmPasswordLabel];
    
    
    //初始化昵称
    self.nickNameTextField = [[[UITextField alloc] initWithFrame:CGRectMake(90, 90, 210, 40)] autorelease];
    self.nickNameTextField.placeholder = @"7个汉字或14个英文、数字";
    self.nickNameTextField.delegate = self;
    self.nickNameTextField.textAlignment = NSTextAlignmentLeft;
    self.nickNameTextField.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:self.nickNameTextField];
    
    //初始化邮箱
    self.userNameTextField = [[[UITextField alloc] initWithFrame:CGRectMake(90, 135, 210, 40)] autorelease];
    self.userNameTextField.placeholder = @"请填写常用邮箱";
    self.userNameTextField.delegate = self;
    self.userNameTextField.textAlignment = NSTextAlignmentLeft;
    self.userNameTextField.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:self.userNameTextField];
    
    //初始化密码框
    self.userPasswordTextField = [[[UITextField alloc] initWithFrame:CGRectMake(90, 180, 210, 40)] autorelease];
    self.userPasswordTextField.placeholder = @"6位以上英文、数字、符号";
    self.userPasswordTextField.secureTextEntry = YES;
    self.userPasswordTextField.delegate = self;
    self.userPasswordTextField.textAlignment = NSTextAlignmentLeft;
    self.userPasswordTextField.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:self.userPasswordTextField];
    
    //初始化确认密码框
    self.confirmPasswordField = [[[UITextField alloc] initWithFrame:CGRectMake(90, 225, 210, 40)] autorelease];
    self.confirmPasswordField.placeholder = @"请确认密码";
    self.confirmPasswordField.secureTextEntry = YES;
    self.confirmPasswordField.delegate = self;
    self.confirmPasswordField.textAlignment = NSTextAlignmentLeft;
    self.confirmPasswordField.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:self.confirmPasswordField];
    
    
//    RELEASE_SAFETY(self.nickNameTextField);
//    RELEASE_SAFETY(self.nickNameLabel);
//    RELEASE_SAFETY(self.userNameTextField);
//    RELEASE_SAFETY(self.userNameLabel);
//    RELEASE_SAFETY(self.userPasswordTextField);
//    RELEASE_SAFETY(self.userPasswordLabel);
//    RELEASE_SAFETY(self.confirmPasswordField);
//    RELEASE_SAFETY(self.confirmPasswordLabel);
    
}
#pragma mark-----------UITextfield Delegate------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    RELEASE_SAFETY(_userNameLabel);
    RELEASE_SAFETY(_userNameTextField);
    RELEASE_SAFETY(_userPasswordLabel);
    RELEASE_SAFETY(_userPasswordTextField);
    RELEASE_SAFETY(_confirmPasswordField);
    RELEASE_SAFETY(_nickNameTextField);
    RELEASE_SAFETY(_nickNameLabel);
    RELEASE_SAFETY(_confirmPasswordLabel);
    
    [super dealloc];
}

@end
