//
//  ViewController.m
//  QQLoginDemo
//
//  Created by Otherplayer on 14-4-4.
//  Copyright (c) 2014年 Guole. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *permissions;
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UILabel *stateLogin;

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId: @"222222" andDelegate:self];
    self.permissions = [NSMutableArray arrayWithObjects:@"get_user_info",@"add_t", nil];
    
}
//登陆按键
- (IBAction)loginAction:(id)sender {
    [_tencentOAuth authorize:_permissions inSafari:NO];
    
}
#pragma mark - 
#pragma mark - TencentSessionDelegate
- (void)tencentDidLogin
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",_permissions);
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        // 记录登录用户的OpenID、Token以及过期时间
        _stateLogin.text = _tencentOAuth.accessToken;
        NSLog(@"openId : %@",[_tencentOAuth openId]);
        [_tencentOAuth getUserInfo];
    }
    else
    {
        _stateLogin.text = @"登录不成功 没有获取accesstoken";
    }

}
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"%s",__func__);
    if (cancelled)
    {
        _stateLogin.text = @"用户取消登录";
    }
    else
    {
        _stateLogin.text = @"登录失败";
    }
}
- (void)tencentDidNotNetWork
{
    NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
