//
//  WeatherViewController.m
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "WeatherViewController.h"
#import "ViewCell.h"
#import "WeatherDetailViewController.h"
#import "SqlManager.h"
#import "Reachability.h"
#import "BeginView.h"


@interface WeatherViewController ()
{
    NSInteger scrollIndex;//记录scroll的当前的页面
    float v;//箭头的移动速度
}
//存放scrollview视图中，所有城市的名字

@property(nonatomic,retain) UIView *listview;//后几天的信息
@property(nonatomic,retain) UIImageView *imageview;//背景图片
@property(nonatomic,retain) NSMutableArray *listarray;//后几天的数组信息

//总的天气信息
@property(nonatomic,retain) NSDictionary *weatherdictionary;//总的天气信息

//当天信息
@property(nonatomic,retain) UILabel *temperature;//温度      8~9
@property(nonatomic,retain) UILabel *weather;//天气          多云
@property(nonatomic,retain) UILabel *cityname;//城市名字      北京
@property(nonatomic,retain) UILabel *date;//日期             2014-3-15

//后几天的信息
@property(nonatomic,retain) ViewCell *cellone;
@property(nonatomic,retain) ViewCell *celltwo;
@property(nonatomic,retain) ViewCell *cellthree;
@property(nonatomic,retain) ViewCell *cellfour;
@property(nonatomic,retain) ViewCell *cellfive;

//详细页面的buttton
@property(nonatomic,retain) UIButton *detailButton;
@property(nonatomic,retain) UIButton *refreshButton;

//接收网络数据
@property(nonatomic,retain) NSMutableData *muData;


@end

@implementation WeatherViewController

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
    

    
    //背景图片
    self.imageview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)] autorelease];
    self.imageview.backgroundColor = [UIColor grayColor];
    self.imageview.image = [UIImage imageNamed:@"Mood.jpg"];
    [self.view addSubview:self.imageview];
    [self.view sendSubviewToBack:self.imageview];
    
    
    //列表44   最上面236   最下面316;
    self.listview = [[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - 120, self.view.frame.size.width, 200)] autorelease];
    self.listview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.listview];
//    self.listview = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - 120, self.view.frame.size.width, 200)] autorelease];
//    [self.view addSubview:self.listview];
    //添加手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAciton)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self.listview addGestureRecognizer:swipe];
    [swipe release];
    
    //城市名字
    self.cityname = [[[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 40)] autorelease];
    self.cityname.backgroundColor = [UIColor clearColor];
    self.cityname.textColor = [UIColor whiteColor];
    self.cityname.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:self.cityname];
    
    //天气
    self.weather = [[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 30)] autorelease];
    self.weather.backgroundColor = [UIColor clearColor];
    self.weather.textColor = [UIColor whiteColor];
    [self.view addSubview:self.weather];
    
    //温度
    self.temperature = [[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 120, 30)] autorelease];
    self.temperature.backgroundColor = [UIColor clearColor];
    self.temperature.textColor = [UIColor whiteColor];
    [self.view addSubview:self.temperature];
    
    //日期
    self.date = [[[UILabel alloc] initWithFrame:CGRectMake(20, 160, 200, 30)] autorelease];
    self.date.backgroundColor = [UIColor clearColor];
    self.date.textColor = [UIColor whiteColor];
    [self.view addSubview:self.date];
    
    
    
    
    
    //滑动视图
//    self.scrollview = [[[UIScrollView alloc] initWithFrame:CGRectMake(10, 30, 200, 160)] autorelease];
//    self.scrollview.backgroundColor = [UIColor redColor];
//    self.scrollview.contentSize = CGSizeMake(600, 160);
//    self.scrollview.delegate = self;
//    self.scrollview.pagingEnabled = YES;//显示一页
//    self.scrollview.showsHorizontalScrollIndicator = NO;//不显示水平条
//    [self.view addSubview:self.scrollview];
//    for (int i = 0; i < 3; i++) {
//        
//    }
    
    
    //----------------------------------------------------------------------
    //给后几天的天气添加信息
    self.cellone = [[[ViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    [self.listview addSubview:self.cellone];
    self.celltwo = [[[ViewCell alloc] initWithFrame:CGRectMake(0, 40, 320, 40)] autorelease];
    [self.listview addSubview:self.celltwo];
    self.cellthree = [[[ViewCell alloc] initWithFrame:CGRectMake(0, 80, 320, 40)] autorelease];
    [self.listview addSubview:self.cellthree];
    self.cellfour= [[[ViewCell alloc] initWithFrame:CGRectMake(0, 120, 320, 40)] autorelease];
    [self.listview addSubview:self.cellfour];
    self.cellfive = [[[ViewCell alloc] initWithFrame:CGRectMake(0, 160, 320, 40)] autorelease];
    [self.listview addSubview:self.cellfive];
    

    
    
    
    //添加城市按钮
    UIButton *citybutton = [UIButton buttonWithType:UIButtonTypeCustom];
    citybutton.frame = CGRectMake(10, 200, 30, 30);
    [citybutton setImage:[UIImage imageNamed:@"list_city_ad.png"] forState:UIControlStateNormal];
    [citybutton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:citybutton];
    //刷新按钮
    UIButton *refreshbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshbutton.frame = CGRectMake(270, 40, 20, 20);
    [refreshbutton setImage:[UIImage imageNamed:@"icon_sync_03.png"] forState:UIControlStateNormal];
    [refreshbutton addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    self.refreshButton = refreshbutton;
    [self.view addSubview:refreshbutton];
    //详细信息按钮
    UIButton *detailbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.detailButton = detailbutton;
    detailbutton.frame = CGRectMake(260, 200, 30, 30);
    [detailbutton setImage:[UIImage imageNamed:@"roll.png"] forState:UIControlStateNormal];
    [detailbutton addTarget:self action:@selector(detailAcion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:detailbutton];
    
    
    //NSTimer
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerAction) userInfo:Nil repeats:YES];
    v = -0.2;
    
    
    
#warning 网络开关
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reachability currentReachabilityStatus] == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有网络连接" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:Nil, nil];
        [alert show];
        [UIView animateWithDuration:3 animations:^{
            self.cityname.frame = CGRectMake(self.cityname.frame.origin.x, self.cityname.frame.origin.y, self.cityname.frame.size.width, self.cityname.frame.size.height + 0.1);
        }completion:^(BOOL finished) {
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
        [alert release];
    }else {
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        NSString *username = [userdefaults objectForKey:@"citynumber"];
        [self refreshAction:username];
    }
    
    
    
//    BeginView *begin = [[BeginView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.view addSubview:begin];
//    [begin beginview];
//    [begin release];
    
	// Do any additional setup after loading the view.
}


//tableview的代理方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (self.muData != nil) {
        self.muData = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (self.muData == nil) {
        self.muData = [NSMutableData data];
    }
    [self.muData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:self.muData options:NSJSONReadingMutableContainers error:Nil];
    NSDictionary *weatherinfo = [dictionary valueForKey:@"weatherinfo"];
    self.weatherdictionary = weatherinfo;
//-------------------------------当天的信息------------------------------
    //城市名字
    NSString *city = [weatherinfo valueForKey:@"city"];
    self.cityname.text = city;
    //日期
    NSString *datastr = [weatherinfo valueForKey:@"date_y"];
    self.date.text = datastr;
    //温度
    NSString *temperaturestr = [weatherinfo valueForKey:@"temp1"];
    self.temperature.text = temperaturestr;
    //天气
    NSString *weatherstr = [weatherinfo valueForKey:@"weather1"];
    self.weather.text = weatherstr;
    
    NSString *imagename = [self getBackImage:weatherstr];
    
#warning 图片
    //图片
    self.imageview.image = [UIImage imageNamed:imagename];
    
//-------------------------------后几天的信息------------------------------
    NSString *datastr2 = [self getAnotherDay:24];
    self.cellone.datestring = datastr2;
    NSString *temperaturestr2 = [weatherinfo valueForKey:@"temp2"];
    self.cellone.temperature = temperaturestr2;
    NSString *weatherstr2 = [weatherinfo valueForKey:@"weather2"];
    self.cellone.weather = weatherstr2;
    [self.cellone refresh];
    
    NSString *datastr3 = [self getAnotherDay:48];
    self.celltwo.datestring = datastr3;
    NSString *temperaturestr3 = [weatherinfo valueForKey:@"temp3"];
    self.celltwo.temperature = temperaturestr3;
    NSString *weatherstr3 = [weatherinfo valueForKey:@"weather3"];
    self.celltwo.weather = weatherstr3;
    [self.celltwo refresh];
    
    NSString *datastr4 = [self getAnotherDay:72];
    self.cellthree.datestring = datastr4;
    NSString *temperaturestr4 = [weatherinfo valueForKey:@"temp4"];
    self.cellthree.temperature = temperaturestr4;
    NSString *weatherstr4 = [weatherinfo valueForKey:@"weather4"];
    self.cellthree.weather = weatherstr4;
    [self.cellthree refresh];
    
    NSString *datastr5 = [self getAnotherDay:96];
    self.cellfour.datestring = datastr5;
    NSString *temperaturestr5 = [weatherinfo valueForKey:@"temp5"];
    self.cellfour.temperature = temperaturestr5;
    NSString *weatherstr5 = [weatherinfo valueForKey:@"weather5"];
    self.cellfour.weather = weatherstr5;
    [self.cellfour refresh];
    
    NSString *datastr6 = [self getAnotherDay:120];
    self.cellfive.datestring = datastr6;
    NSString *temperaturestr6 = [weatherinfo valueForKey:@"temp6"];
    self.cellfive.temperature = temperaturestr6;
    NSString *weatherstr6 = [weatherinfo valueForKey:@"weather6"];
    self.cellfive.weather = weatherstr6;
    [self.cellfive refresh];
    
    
}


//手势方法
- (void)swipeAciton
{//self.listview = [[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - 120, self.view.frame.size.width, 200)] autorelease];
    if (self.listview.frame.origin.y == self.view.frame.size.height - 49 - 200) {
        [UIView animateWithDuration:1 animations:^{
            self.listview.frame = CGRectMake(0, self.view.frame.size.height - 49 - 120, self.view.frame.size.width, 200);
        }];
    }else {
        [UIView animateWithDuration:1 animations:^{
            self.listview.frame = CGRectMake(0, self.view.frame.size.height - 49 - 200, self.view.frame.size.width, 200);
        }];
    }
}


//NSTimer
- (void)timerAction
{//(280, 200, 30, 30);
    float originx = self.detailButton.frame.origin.x;
    if (originx > 280 || originx < 260) {
        v = v * -1;
        self.detailButton.frame = CGRectMake(originx + v, 200, 30, 30);
    }else {
        self.detailButton.frame = CGRectMake(originx + v, 200, 30, 30);
    }
}


//刷新按钮
- (void)refreshAction:(NSString *)number;
{
    //数据加载
//    NSString *urlstr = @"http://weatherapi.market.xiaomi.com/wtr-v2/temp/forecast?cityId=101010200";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (number == nil) {
        number = [defaults objectForKey:@"citynumber"];
        if (number == nil) {
            [defaults setObject:@"101010200" forKey:@"citynumber"];
            [defaults synchronize];
            number = @"101010200";
        }
    }else if(![number isKindOfClass:[UIButton class]]){//如果number不是button类型，说明传进来的是参数
        [defaults setObject:number forKey:@"citynumber"];
    }
    NSString *urlstr = [NSString stringWithFormat:@"http://weatherapi.market.xiaomi.com/wtr-v2/temp/forecast?cityId=%@",number];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    //按钮动画
    [UIView animateWithDuration:1 animations:^{
        self.refreshButton.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        self.refreshButton.transform = CGAffineTransformMakeRotation(M_PI*2);
    }];
}
//添加按钮
- (void)addAction
{
    
    ProvinceViewController *province = [[ProvinceViewController alloc] init];
    province.delegate = self;
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:province];
    [self presentViewController:navigation animated:YES completion:nil];
    [province release];
    [navigation release];
}
//详细页面按钮
- (void)detailAcion
{

    WeatherDetailViewController *weatherDetail = [[WeatherDetailViewController alloc] init];
    weatherDetail.backimage = self.imageview.image;
    weatherDetail.city = [self.weatherdictionary valueForKey:@"city"];
    weatherDetail.fl1 = [self.weatherdictionary valueForKey:@"fl1"];
    weatherDetail.fx1 = [self.weatherdictionary valueForKey:@"fx1"];
    weatherDetail.index = [self.weatherdictionary valueForKey:@"index"];
    weatherDetail.index_ag = [self.weatherdictionary valueForKey:@"index_ag"];
    weatherDetail.index_cl = [self.weatherdictionary valueForKey:@"index_cl"];
    weatherDetail.index_co = [self.weatherdictionary valueForKey:@"index_co"];
    weatherDetail.index_ls = [self.weatherdictionary valueForKey:@"index_ls"];
    weatherDetail.index_tr = [self.weatherdictionary valueForKey:@"index_tr"];
    weatherDetail.index_uv = [self.weatherdictionary valueForKey:@"index_uv"];
    weatherDetail.index_xc = [self.weatherdictionary valueForKey:@"index_xc"];
    
    
    [self.navigationController pushViewController:weatherDetail animated:YES];
    [weatherDetail release];
}


//province的代理方法
- (void)cityNumber:(NSString *)number
{
    //根据城市名字得到cityid
    [self refreshAction:number];
}


- (NSString *)getAnotherDay:(NSInteger)time;
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[[[NSDate alloc] init] autorelease]];
    [comps setHour:time]; //+24表示获取下一天的date，-24表示获取前一天的date；
    NSDate *getDate = [calendar dateByAddingComponents:comps toDate:date options:0];   //showDate表示某天的date，nowDate表示showDate的前一天或下一
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    NSString *day = [format stringFromDate:getDate];
    [format release];
    
    return day;
}


//根据当前的天气返回图片
- (NSString *)getBackImage:(NSString *)today
{
    if ([today isEqualToString:@"雨加雪"]) {
        return @"雨加雪back.jpg";
    }
    if ([today isEqualToString:@"晴"]) {
        return @"晴bac.jpg";
    }
    if ([today isEqualToString:@"霜冻"]) {
        return @"霜冻.jpg";
    }
    NSRange rangerain = [today rangeOfString:@"雨"];
    if (rangerain.length != 0) {
        return @"雨back.jpg";
    }
    NSRange rangesnow = [today rangeOfString:@"雪"];
    if (rangesnow.length != 0) {
        return @"雪back.jpg";
    }
    NSRange rangecloud = [today rangeOfString:@"多云"];
    if (rangecloud.length != 0) {
        return @"多云ba.jpg";
    }
    NSRange rangewu = [today rangeOfString:@"雾"];
    NSRange rangemai = [today rangeOfString:@"霾"];
    if (rangewu.length != 0 || rangemai.length != 0) {
        return @"雾霾back.jpg";
    }
    return @"晴bac.jpg";
}

//底部图片的变换
//- (void)changeview:(NSString *)image
//{
//    self.rootview.image = [UIImage imageNamed:image];
//    [UIView animateWithDuration:5 animations:^{
//        self.detailButton.frame = CGRectMake(self.detailButton.frame.origin.x, self.detailButton.frame.origin.y + 0.01, self.detailButton.frame.size.width, self.detailButton.frame.size.height);
//        self.imageview.alpha = 0.1;
//    }completion:^(BOOL finished) {
//        self.imageview.image = self.rootview.image;
//        self.imageview.alpha = 1;
//    }];
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [_listview release];//后几天的信息
    [_imageview release];//北京图片
    [_listarray release];//后几天的数组信息
    [_weatherdictionary release];//总的天气信息
    [_temperature release];//温度      8~9
    [_weather release];//天气          多云
    [_cityname release];//城市名字      北京
    [_date release];//日期             2014-3-15
    [_cellone release];
    [_celltwo release];
    [_cellthree release];
    [_cellfour release];
    [_cellfive release];
    [_detailButton release];
    [_refreshButton release];
    [_muData release];
    [super dealloc];
}


@end
