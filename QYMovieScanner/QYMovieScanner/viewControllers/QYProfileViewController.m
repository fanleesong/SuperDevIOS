//
//  QYProfileViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYProfileViewController.h"
#import "QYCustomProfileTableCell.h"
#import "QYProfileWebViewController.h"
#import "QYBaseNavigationController.h"
#import "QYHttpRequestManager.h"
#import "UIImageView+WebCache.h"
#import "QYUserLoginViewController.h"
#import "QYUserRegistViewController.h"
#import "QYUserInfo.h"
#import "JSON.h"

@interface QYProfileViewController ()

@end

@implementation QYProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        self.title = @"我的地盘";
        //初始化数组
        self.textArray = [NSArray arrayWithObjects:PROFILE_LOOKOVER,PROFILE_MYCACHCE,PROFILE_MYCOLLECT,PROFILE_MYATTETION,PROFILE_MYUPLOAD,PROFILE_APPRECOMMENT, nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initTableView];
    
//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(getReWeb)] autorelease];
    
}
//-(void)getReWeb{
//
//}
-(void)_initTableView{
    
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    self.tableView.userInteractionEnabled = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView *bgImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_usercenter_0.png"]] autorelease];
    bgImageView.frame = CGRectMake(0, 0, 320, 150);
#warning mark---------未完善------------
    //显示用户名
    self.nickNameAndDate = [[[UILabel alloc ]initWithFrame:CGRectMake(120, 90, 78, 33)] autorelease];
    //    self.nickNameAndDate.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"log_in.png"]];
    self.nickNameAndDate.textColor = [UIColor whiteColor];
    self.nickNameAndDate.font = [UIFont boldSystemFontOfSize:17.0f];
    
    //登陆按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"log_in.png"]];
    self.loginButton.frame = CGRectMake(120, 90, 78, 33);
    self.loginButton.userInteractionEnabled = YES;
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitle:@"登 陆" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //注册按钮
    self.registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_button_grey.png"]];
    self.registButton.frame = CGRectMake(218, 90, 78, 33);
    [self.registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registButton setTitle:@"注 册" forState:UIControlStateNormal];
    [self.registButton addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.avatarImages = [[[UIImageView alloc] init] autorelease];
    [self.avatarImages setImage:[UIImage imageNamed:@"renqiboke2.png"]];
    self.avatarImages.frame = CGRectMake(20, 70,90, 90);
    
    self.tableView.tableHeaderView = bgImageView;
    [self.tableView addSubview:self.nickNameAndDate];
    [self.tableView addSubview:self.loginButton];
    [self.tableView addSubview:self.registButton];
    [self.tableView addSubview:self.avatarImages];
    
    [self.view addSubview: self.tableView];
    
    //使用通知进行消息传递（通知NSNotificationCenter不可都用）
    //NSNotificationCenter可以在毫无关系的视图中进行参数传值
    //NSNotificationCenter是一个one-to-one &one-to-many &one-to- none的关系
    //过多使用会降低代码的可读性，增加程序的耦合度
    //#define kChangeUserAvatarByNotification @"kChangeUserAvatarByNotification"宏定义
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImageAction:) name:kChangeUserAvatarByNotification object:nil];
    
    
}
#pragma mark----实现通知方法----
-(void)changeImageAction:(NSNotification *)notification{

    //获取通知传递过来的对象
    QYUserInfo *userInfo = (QYUserInfo *)notification.object;
    //修改原有Label值
    [self.avatarImages setImageWithURL:[NSURL URLWithString: userInfo.userPicUrl]];


}
#pragma mark--实现登陆注册方法--
-(void)loginAction:(UIButton *)sender{
    
    NSLog(@"%s",__FUNCTION__);
    
    //发送授权请求
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSDictionary *firstRequestDic = [parser objectWithString:[QYHttpRequestManager getOauthRight]];
//    NSLog(@"%@",firstRequestDic);
    //获取code和state
    
    
        
    //初始化登陆界面
    QYUserLoginViewController *userlogin = [[QYUserLoginViewController alloc] init];
    QYBaseNavigationController *loginVC = [[QYBaseNavigationController alloc] initWithRootViewController:userlogin];
    [self presentViewController:loginVC animated:YES completion:nil];
    RELEASE_SAFETY(userlogin);
    RELEASE_SAFETY(loginVC);
    
    
}

-(void)registAction:(UIButton *)sender{
    
    NSLog(@"%s",__FUNCTION__);
    
    //初始化登陆界面
    QYUserRegistViewController *userRegist = [[QYUserRegistViewController alloc] init];
    QYBaseNavigationController *registerVC = [[QYBaseNavigationController alloc] initWithRootViewController:userRegist];
    [self presentViewController:registerVC animated:YES completion:nil];
    RELEASE_SAFETY(userRegist);
    RELEASE_SAFETY(registerVC);
    
}


#pragma mark-----------tableView Delegate-----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.textArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellInditifier = @"CELL";
    QYCustomProfileTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInditifier];
    if (cell == nil) {
        cell = [[[QYCustomProfileTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellInditifier] autorelease];
        cell.frame = CGRectMake(10, 0, 300, 50);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0) {
        
        cell.instructLabel.text = [self.textArray objectAtIndex:indexPath.section];
    }
    else if(indexPath.section == 1) {
    
        cell.instructLabel.text = [self.textArray objectAtIndex:indexPath.section];
        
    }
    else if(indexPath.section == 2) {
    
        cell.instructLabel.text = [self.textArray objectAtIndex:indexPath.section];
        
    }
    else if(indexPath.section == 3) {
    
        cell.instructLabel.text = [self.textArray objectAtIndex:indexPath.section];
        
    }
    else if(indexPath.section == 4) {
    
        cell.instructLabel.text = [self.textArray objectAtIndex:indexPath.section];
        
    }
    else if(indexPath.section == 5) {
    
        cell.instructLabel.text = [self.textArray objectAtIndex:indexPath.section];
        
    }
    
    
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 3;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kChangeUserAvatarByNotification object:nil];
    RELEASE_SAFETY(_textArray);
    RELEASE_SAFETY(_tableView);
    RELEASE_SAFETY(_avatarImages);
    RELEASE_SAFETY(_loginButton);
    RELEASE_SAFETY(_registButton);
    RELEASE_SAFETY(_nickNameAndDate);
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
