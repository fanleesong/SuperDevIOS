//
//  MoodViewController.m
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "MoodViewController.h"
#import "MoodCell.h"
#import "WeiboEditViewController.h"

#import "Mood.h"
#import "SqlManager.h"


@interface MoodViewController ()

@property(nonatomic,retain) UIImageView *dandelion;
@property(nonatomic,retain) NSMutableArray *resultarray;
@property(nonatomic,retain) UITableView *tableview;
@property(nonatomic,retain) UILabel *dateLabel;

@end

@implementation MoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem.title = @"心情";
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        self.resultarray = [NSMutableArray arrayWithCapacity:1];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if(self->wbapi == nil)
    {
        self->wbapi = [[WeiboApi alloc]initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUri:REDIRECTURI andAuthModeFlag:0 andCachePolicy:0] ;
    }
    
//    [self redrawSubView:self.interfaceOrientation];
    
    [super viewDidLoad];
    
    
    //背景
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageview.image = [UIImage imageNamed:@"Mood2.jpg"];
    [self.view addSubview:imageview];
    [imageview release];
    
    //标题栏
    UIView *titleview = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)] autorelease];
    titleview.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:titleview];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 140, 35)];
    titlelabel.text = @"每日一记";
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:22];
    titlelabel.textColor = [UIColor whiteColor];
    [titleview addSubview:titlelabel];
    [titlelabel release];
    //分享按钮
    UIButton *share = [[UIButton alloc] initWithFrame:CGRectMake(210, 15, 35, 35)];
    share.backgroundColor = [UIColor blueColor];
    [share setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [titleview addSubview:share];
    
    
    
    //日期显示
    self.dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 25, 100, 25)] autorelease];
    self.dateLabel.userInteractionEnabled = YES;
    self.dateLabel.textColor = [UIColor whiteColor];
    self.dateLabel.font = [UIFont boldSystemFontOfSize:15];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    self.dateLabel.text = [formatter stringFromDate:date];
    [formatter release];
    //根据日期查询当月的记录
    SqlManager *manager = [[SqlManager alloc] init];
    NSArray *moodarray = [manager getMood:self.dateLabel.text];
    [manager release];
    [self.resultarray addObjectsFromArray:moodarray];
    [titleview addSubview:self.dateLabel];
    //日期添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateAction)];
    [self.dateLabel addGestureRecognizer:tap];
    [tap release];
    
    
    //添加按钮
    UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbutton setImage:[UIImage imageNamed:@"citymanagement_icon_add.png"] forState:UIControlStateNormal];
    [addbutton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    addbutton.frame = CGRectMake(280, 20, 40, 30);
    [titleview addSubview:addbutton];
    
    //table列表
    self.tableview = [[[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50 - 44)] autorelease];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    
    
    
	// Do any additional setup after loading the view.
}


- (void)shareAction
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   @"0", @"pageflag",
                                   @"30", @"reqnum",
                                   @"0", @"type",
                                   @"0", @"contenttype",
                                   nil];
    int result = [wbapi requestWithParams:params apiName:@"statuses/home_timeline" httpMethod:@"GET" delegate:self];
    [params release];
    
    if (result < 0) {
        [wbapi loginWithDelegate:self andRootController:self];
    }else {
        WeiboEditViewController *weiboC = [[WeiboEditViewController alloc] init];
        weiboC.wbapi = self->wbapi;
        [self presentViewController:weiboC animated:YES completion:^{
            
        }];
        [weiboC release];
    }
    
}



//tableview的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mark = @"moodmark";
    MoodCell *cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (cell == Nil) {
        cell = [[[MoodCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mark] autorelease];
    }
    Mood *mood = [self.resultarray objectAtIndex:indexPath.row];
    cell.titlestr = mood.content;
    cell.daystr = mood.day;
    cell.timestr = mood.time;
    [cell setMessage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoodCell *cell = (MoodCell *)[self.tableview cellForRowAtIndexPath:indexPath];
    
    MoodAddView *addview = [[MoodAddView alloc] initWithFrame:self.view.frame];
    addview.delegate = self;
    addview.yset = cell.frame.origin.y - self.tableview.contentOffset.y;
    addview.titlestr = cell.titlestr;
    addview.daystr = cell.daystr;
    addview.timestr = cell.timestr;
    [self.view addSubview:addview];
    [addview starAnim];
    [addview setEditMoodCell];//点击单元格调用编辑的刷新方法
    [addview release];
}


//添加心情
- (void)addAction
{
    MoodAddView *addview = [[MoodAddView alloc] initWithFrame:self.view.frame];
    addview.delegate = self;
    addview.yset = self.view.frame.size.height + 100;
    NSDate *date = [NSDate date];
    
    //获得当前的日期
    NSDateFormatter *dayformatter = [[NSDateFormatter alloc] init];
    [dayformatter setDateFormat:@"yyyy-MM-dd"];
    addview.daystr = [dayformatter stringFromDate:date];
    [dayformatter setDateFormat:@"HH:mm:ss"];
    addview.timestr = [dayformatter stringFromDate:date];
    [dayformatter release];
    //查看数据库是否有记录
    SqlManager *manager = [[SqlManager alloc] init];
    NSArray *array = [manager getTodayMood:addview.daystr];
    if (array.count != 0) {
        Mood *mood = [array objectAtIndex:0];
        addview.titlestr = mood.content;
    }
    [manager release];
    
    [self.view addSubview:addview];
    
    [addview starAnim];
    [addview setMoodCell];
    [addview release];
}

//选择日期
- (void)dateAction
{
//    SelectDateView *selectdate = [[SelectDateView alloc] init];
//    [self.view addSubview:selectdate];
//    [selectdate release];
    
    SelectDateView *selectView = [[SelectDateView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    selectView.delegate = self;
    
    [self.view addSubview:selectView];
    [selectView release];
}


//selectdateview代理方法
- (void)passValueOfDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateLabel.text = [formatter stringFromDate:date];
    [formatter release];
    SqlManager *manager = [[SqlManager alloc] init];
    [self.resultarray removeAllObjects];
    NSArray *array = [manager getMood:self.dateLabel.text];
    [manager release];
    [self.resultarray addObjectsFromArray:array];
    [self.tableview reloadData];
}

//MoodAddView的代理方法
- (void)saveMoodRefresh
{
    SqlManager *manager = [[SqlManager alloc] init];
    [self.resultarray removeAllObjects];
    NSArray *array = [manager getMood:self.dateLabel.text];
    [manager release];
    [self.resultarray addObjectsFromArray:array];
    [self.tableview reloadData];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f  %f",self.tableview.contentOffset.y,self.tableview.contentOffset.x);
}


- (void)dealloc
{
    [_dandelion release];
    [_resultarray release];
    [_tableview release];
    [_dateLabel release];
    [super dealloc];
}





//腾讯微博-----------------------------------------------------------------------------



-(float)GetXPos:(UIInterfaceOrientation)toInterfaceOrientation
{
    float x;
    
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        x = [[UIScreen mainScreen]bounds].size.width/2 - 120;
        
    }
    else
    {
        x = [[UIScreen mainScreen]bounds].size.height/2 - 120;
    }
    
    //NSLog(@"x pos = %f", x);
    
    return x;
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    
    return YES;
    
}




-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
//    [self redrawSubView:toInterfaceOrientation];
}


- (void) viewDidUnload
{
    [super viewDidUnload];
    
    return;
    
}


//点击登录按钮
- (void)onLogin {
    [wbapi loginWithDelegate:self andRootController:self];
}

//点击登录按钮
- (void)onExtend {
    
    [wbapi checkAuthValid:TCWBAuthCheckServer andDelegete:self];
    
}

//点击登录按钮
- (void)onGetHometimeline {
    
    
    
    //[self showMsg:str];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   @"0", @"pageflag",
                                   @"30", @"reqnum",
                                   @"0", @"type",
                                   @"0", @"contenttype",
                                   nil];
    [wbapi requestWithParams:params apiName:@"statuses/home_timeline" httpMethod:@"GET" delegate:self];
    [params release];
}

//点击登录按钮
- (void)onAddPic {
    
    
    
    
    UIImage *pic = [UIImage imageNamed:@"icon.png"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   @"hello world", @"content",
                                   pic, @"pic",
                                   nil];
    [wbapi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
    //[pic release];
    [params release];
    
}


//点击登录按钮
- (void)AddPic {
    
    
    
    
    UIImage *pic = [UIImage imageNamed:@"icon.png"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   @"hi,weibo sdk", @"content",
                                   pic, @"pic",
                                   nil];
    [wbapi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
    //[pic release];
    [params release];
    
}

//展示结果
- (void)showMsg:(NSString *)msg
{
//    ResultViewController *rvc = [[ResultViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rvc];
//    rvc.result = msg;
//    
//    [self presentModalViewController:nav animated:YES];
//    [rvc release];
//    [nav release];
}

- (void)onLogout {
    // 注销授权
    [wbapi  cancelAuth];
    
    NSString *resStr = [[NSString alloc]initWithFormat:@"取消授权成功！"];
    
    [self showMsg:resStr];
    [resStr release];
    
}



#pragma mark WeiboRequestDelegate

/**
 * @brief   接口调用成功后的回调
 * @param   INPUT   data    接口返回的数据
 * @param   INPUT   request 发起请求时的请求对象，可以用来管理异步请求
 * @return  无返回
 */
- (void)didReceiveRawData:(NSData *)data reqNo:(int)reqno
{
    NSString *strResult = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"result = %@",strResult);
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:strResult];
    });
    
    [strResult release];
    
}
/**
 * @brief   接口调用失败后的回调
 * @param   INPUT   error   接口返回的错误信息
 * @param   INPUT   request 发起请求时的请求对象，可以用来管理异步请求
 * @return  无返回
 */
- (void)didFailWithError:(NSError *)error reqNo:(int)reqno
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    [str release];
}



#pragma mark WeiboAuthDelegate

/**
 * @brief   重刷授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthRefreshed:(WeiboApiObject *)wbobj
{
    
    
    //UISwitch
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r",wbobj.accessToken, wbobj.openid, wbobj.appKey, wbobj.appSecret];
    
    NSLog(@"result = %@",str);
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    [str release];
    
}

/**
 * @brief   重刷授权失败后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthRefreshFail:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    [str release];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthFinished:(WeiboApiObject *)wbobj
{
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r\n openid = %@\r\n appkey=%@ \r\n appsecret=%@ \r\n refreshtoken=%@ ", wbobj.accessToken, wbobj.openid, wbobj.appKey, wbobj.appSecret, wbobj.refreshToken];
    
    NSLog(@"result = %@",str);
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    
    
    // NSLog(@"after add pic");
    [str release];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi   weiboapi 对象，取消授权后，授权信息会被清空
 * @return  无返回
 */
- (void)DidAuthCanceled:(WeiboApi *)wbapi_
{
    
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthFailWithError:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"get token error, errcode = %@",error.userInfo];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    [str release];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
-(void)didCheckAuthValid:(BOOL)bResult suggest:(NSString *)strSuggestion
{
    NSString *str = [[NSString alloc] initWithFormat:@"ret=%d, suggestion = %@", bResult, strSuggestion];
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    [str release];
}























- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
