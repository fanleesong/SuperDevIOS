//
//  QYUserLoginViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-14.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYUserLoginViewController.h"
#import "QYHttpRequestManager.h"
#import "UIImageView+WebCache.h"
#import "QYUserRegistViewController.h"
#import "QYUserInfo.h"
#import "JSON.h"


@interface QYUserLoginViewController ()

-(void)_initSomeProperty;

@end

@implementation QYUserLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"admin.png"]];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化左边按钮
    UIBarButtonItem *leftButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_close_right.png"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewControllerAction:)] autorelease];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //添加一个手势
    UITapGestureRecognizer *tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    [self.view addGestureRecognizer:tapGuest];
    [tapGuest release];
    
    //调用初始化方法
    [self _initSomeProperty];
    
    
    

}
#pragma mark-----------实现手势-------------
-(void)handleTapGesture{

    if (self.userNameTextField.becomeFirstResponder) {
        [self.userNameTextField resignFirstResponder];//撤销textfield第一响应者的状态，释放第一响应者
    }
    if (self.userPasswordTextField.becomeFirstResponder) {
        [self.userPasswordTextField resignFirstResponder];//撤销textfield第一响应者的状态，释放第一响应者
    }

}
#pragma maek---------实现退出模态视图-dismissViewControllerAction-----------
-(void)dismissViewControllerAction:(UIBarButtonItem *)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}
//初始化一些属性
-(void)_initSomeProperty{
    
//    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(120, 90, 78, 33)];
//    self.bgView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.bgView];

    //初始化用户名Label
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 280, 40)];
    self.userNameLabel.text = @"  邮 箱:";
    self.userNameLabel.layer.borderWidth = 0.3;
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.userNameLabel];
    //初始化密码Label
    self.userPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 135, 280, 40)];
    self.userPasswordLabel.text = @"  密 码:";
    self.userPasswordLabel.backgroundColor = [UIColor whiteColor];
    self.userPasswordLabel.textAlignment = NSTextAlignmentLeft;
    self.userPasswordLabel.layer.borderWidth = 0.3;
    [self.view addSubview:self.userPasswordLabel];
    //初始化用户名框
    self.userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 90, 210, 40)];
    self.userNameTextField.placeholder = @"请输入邮箱";
    self.userNameTextField.tag = 222;
    self.userNameTextField.delegate = self;
    self.userNameTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.userNameTextField];
    
    //初始化密码框
    self.userPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 135, 210, 40)];
    self.userPasswordTextField.placeholder = @"请输入密码";
    self.userPasswordTextField.secureTextEntry = YES;
    self.userPasswordTextField.tag = 111;
    self.userPasswordTextField.delegate = self;
    self.userPasswordTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.userPasswordTextField];
    
    //登陆按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake(20, 180, 78, 33);
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitle:@"登 陆" forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"log_in.png"]];
    [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    //注册按钮
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame = CGRectMake(222, 180, 78, 33);
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton setTitle:@"注 册" forState:UIControlStateNormal];
    self.registerButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_button_grey.png"]];
    [self.registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
    
    RELEASE_SAFETY(self.userPasswordLabel);
    RELEASE_SAFETY(self.userNameLabel);
    RELEASE_SAFETY(self.userPasswordLabel);
    RELEASE_SAFETY(self.userPasswordTextField);
    
}
#pragma mark-----------UITextfield Delegate------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

#pragma mark--------实现登陆方法和注册方法-----------
-(void)loginButtonAction:(UIButton *)sender{
    
#warning mark--------待完善---------
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *dic = [parser objectWithString:[QYHttpRequestManager getAuthorVideoUserInfo:@"2641533671@qq.com"]];
    QYUserInfo *userInfo = [[QYUserInfo alloc] init];
    userInfo.userName = [dic objectForKey:@"userName"];
    userInfo.nickName = [dic objectForKey:@"nickName"];
    userInfo.userPicUrl = [dic objectForKey:@"userPicUrl"];
    userInfo.userId = [dic objectForKey:@"userId"];
    userInfo.gender = [dic objectForKey:@"gender"];
    userInfo.homeUrl = [dic objectForKey:@"homeUrl"];
    
//    NSLog(@"%@",dic);
//    NSLog(@"%@",[dic objectForKey:@"nickName"]);
//    NSLog(@"%@",[dic objectForKey:@"userName"]);

    //使用通知方法传递接收后的用户数据
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeUserAvatarByNotification object:userInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
    RELEASE_SAFETY(userInfo);
    RELEASE_SAFETY(parser);

}
-(void)registerButtonAction:(UIButton *)sender{

    NSLog(@"%s",__FUNCTION__);
    
    //初始化登陆界面
    QYUserRegistViewController *userRegist = [[QYUserRegistViewController alloc] init];
    [self.navigationController pushViewController:userRegist animated:YES];
    RELEASE_SAFETY(userRegist);

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
    RELEASE_SAFETY(_loginButton);
    RELEASE_SAFETY(_registerButton);
    [super dealloc];
}

@end
