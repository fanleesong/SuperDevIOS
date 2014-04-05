//
//  SortViewController.m
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "SortViewController.h"
#import "SqlManager.h"
#import "CitySort.h"
#import "CityAirSort.h"
#import "CitySortCell.h"

@interface SortViewController ()
{
    NSInteger number;//记录城市数组的下标
    NSInteger isAir;//记录当前选择是排行的类型（空气，温度，pm）对应的标记(1,2,3)
}
@property(nonatomic,retain) UITableView *tableview;

//选择排列类型
@property(nonatomic,retain) UIView *listview;
//城市列表
@property(nonatomic,retain) NSMutableArray *cityarray;//不加省
@property(nonatomic,retain) NSArray *cityarray2;//城市加上省
//网络结果数据
@property(nonatomic,retain) NSMutableData *mudata;
//城市和解析地址的对应
@property(nonatomic,retain) NSMutableDictionary *citydictionary;
//存放结果
@property(nonatomic,retain) NSMutableArray *resultarray;//温度结果
@property(nonatomic,retain) NSMutableArray *airarray;//空气结果
@property(nonatomic,retain) NSMutableArray *tableArray;//列表的展示结果
//刷新标志
@property(nonatomic,retain) UIActivityIndicatorView *activity;
//网络连接
@property(nonatomic,retain) NSURLConnection *connection;





@end

@implementation SortViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8C%97%E4%BA%AC&token=D3pAujQVDyWsqvHtyxXh&stations=no
        self.cityarray = [NSMutableArray arrayWithObjects:@"北京",@"天津",@"上海",@"重庆",@"石家庄",@"哈尔滨",@"长春",@"沈阳",@"呼和浩特",@"乌鲁木齐",@"兰州",@"西宁",@"西安",@"银川",@"郑州",@"济南",@"太原",@"合肥",@"武汉",@"南京",@"成都",@"贵阳",@"昆明",@"南宁",@"拉萨",@"杭州",@"南昌",@"广州",@"福州",@"海口",@"台北",@"香港",@"澳门", nil];
        self.cityarray2 = [NSArray arrayWithObjects:@"北京",@"天津",@"上海",@"重庆",@"石家庄(河北省)",@"哈尔滨(黑龙江省)",@"长春(吉林省)",@"沈阳(辽宁省)",@"呼和浩特(内蒙古)",@"乌鲁木齐(新疆)",@"兰州(甘肃省)",@"西宁(青海省)",@"西安(陕西省)",@"银川(宁夏)",@"郑州(河南省)",@"济南(山东省)",@"太原(山西省)",@"合肥(安徽省)",@"武汉(湖北省)",@"南京(江苏省)",@"成都(四川省)",@"贵阳(贵州省)",@"昆明(云南省)",@"南宁(广西省)",@"拉萨(西藏)",@"杭州(浙江省)",@"南昌(江西省)",@"广州(广东省)",@"福州(福建省)",@"海口(海南省)",@"台北(台湾省)",@"香港",@"澳门", nil];
        /*
        //北京  http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8C%97%E4%BA%AC&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //天津  http://www.pm25.in/api/querys/pm2_5.json?city=%E5%A4%A9%E6%B4%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //上海  http://www.pm25.in/api/querys/pm2_5.json?city=%E4%B8%8A%E6%B5%B7&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //重庆  http://www.pm25.in/api/querys/pm2_5.json?city=%E9%87%8D%E5%BA%86&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //石家庄http://www.pm25.in/api/querys/pm2_5.json?city=%E7%9F%B3%E5%AE%B6%E5%BA%84&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //哈尔滨http://www.pm25.in/api/querys/pm2_5.json?city=%E5%93%88%E5%B0%94%E6%BB%A8&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //长春http://www.pm25.in/api/querys/pm2_5.json?city=%E9%95%BF%E6%98%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //沈阳http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B2%88%E9%98%B3&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //呼和浩特http://www.pm25.in/api/querys/pm2_5.json?city=%E5%91%BC%E5%92%8C%E6%B5%A9%E7%89%B9&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //乌鲁木齐http://www.pm25.in/api/querys/pm2_5.json?city=%E4%B9%8C%E9%B2%81%E6%9C%A8%E9%BD%90&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //兰州http://www.pm25.in/api/querys/pm2_5.json?city=%E5%85%B0%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //西宁http://www.pm25.in/api/querys/pm2_5.json?city=%E8%A5%BF%E5%AE%81&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //西安  http://www.pm25.in/api/querys/pm2_5.json?city=%E8%A5%BF%E5%AE%89&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //银川   http://www.pm25.in/api/querys/pm2_5.json?city=%E9%93%B6%E5%B7%9D&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //郑州  http://www.pm25.in/api/querys/pm2_5.json?city=%E9%83%91%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //济南  http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B5%8E%E5%8D%97&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //太原   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%A4%AA%E5%8E%9F&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //合肥   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%90%88%E8%82%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //武汉   http://www.pm25.in/api/querys/pm2_5.json?city=%E6%AD%A6%E6%B1%89&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //南京   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E4%BA%AC&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //成都   http://www.pm25.in/api/querys/pm2_5.json?city=%E6%88%90%E9%83%BD&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //贵阳  http://www.pm25.in/api/querys/pm2_5.json?city=%E8%B4%B5%E9%98%B3&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //昆明   http://www.pm25.in/api/querys/pm2_5.json?city=%E6%98%86%E6%98%8E&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //南宁   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E5%AE%81&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //拉萨  http://www.pm25.in/api/querys/pm2_5.json?city=%E6%8B%89%E8%90%A8&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //杭州  http://www.pm25.in/api/querys/pm2_5.json?city=%E6%9D%AD%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //南昌   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E6%98%8C&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //广州    http://www.pm25.in/api/querys/pm2_5.json?city=%E5%B9%BF%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //福州   http://www.pm25.in/api/querys/pm2_5.json?city=%E7%A6%8F%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
        //@"海口",http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B5%B7%E5%8F%A3&token=D3pAujQVDyWsqvHtyxXh&stations=no
         */
        
        number = 0;
        isAir = 1;
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageview.image = [UIImage imageNamed:@"airsort.jpg"];
    [self.view addSubview:imageview];
    [imageview release];
    
    //请求地址和城市的对应
    self.citydictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    self.resultarray = [NSMutableArray arrayWithCapacity:1];
    
    self.airarray = [NSMutableArray arrayWithCapacity:1];
    self.tableArray = [NSMutableArray arrayWithCapacity:1];
    
    /*
    //北京  http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8C%97%E4%BA%AC&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //天津  http://www.pm25.in/api/querys/pm2_5.json?city=%E5%A4%A9%E6%B4%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //上海  http://www.pm25.in/api/querys/pm2_5.json?city=%E4%B8%8A%E6%B5%B7&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //重庆  http://www.pm25.in/api/querys/pm2_5.json?city=%E9%87%8D%E5%BA%86&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //石家庄http://www.pm25.in/api/querys/pm2_5.json?city=%E7%9F%B3%E5%AE%B6%E5%BA%84&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //哈尔滨http://www.pm25.in/api/querys/pm2_5.json?city=%E5%93%88%E5%B0%94%E6%BB%A8&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //长春http://www.pm25.in/api/querys/pm2_5.json?city=%E9%95%BF%E6%98%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //沈阳http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B2%88%E9%98%B3&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //呼和浩特http://www.pm25.in/api/querys/pm2_5.json?city=%E5%91%BC%E5%92%8C%E6%B5%A9%E7%89%B9&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //乌鲁木齐http://www.pm25.in/api/querys/pm2_5.json?city=%E4%B9%8C%E9%B2%81%E6%9C%A8%E9%BD%90&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //兰州http://www.pm25.in/api/querys/pm2_5.json?city=%E5%85%B0%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //西宁http://www.pm25.in/api/querys/pm2_5.json?city=%E8%A5%BF%E5%AE%81&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //西安  http://www.pm25.in/api/querys/pm2_5.json?city=%E8%A5%BF%E5%AE%89&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //银川   http://www.pm25.in/api/querys/pm2_5.json?city=%E9%93%B6%E5%B7%9D&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //郑州  http://www.pm25.in/api/querys/pm2_5.json?city=%E9%83%91%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //济南  http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B5%8E%E5%8D%97&token=D3pAujQVDyWsqvHtyxXh&stations=no
    //太原   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%A4%AA%E5%8E%9F&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //合肥   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%90%88%E8%82%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //武汉   http://www.pm25.in/api/querys/pm2_5.json?city=%E6%AD%A6%E6%B1%89&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //南京   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E4%BA%AC&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //成都   http://www.pm25.in/api/querys/pm2_5.json?city=%E6%88%90%E9%83%BD&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //贵阳  http://www.pm25.in/api/querys/pm2_5.json?city=%E8%B4%B5%E9%98%B3&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //昆明   http://www.pm25.in/api/querys/pm2_5.json?city=%E6%98%86%E6%98%8E&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //南宁   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E5%AE%81&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //拉萨  http://www.pm25.in/api/querys/pm2_5.json?city=%E6%8B%89%E8%90%A8&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //杭州  http://www.pm25.in/api/querys/pm2_5.json?city=%E6%9D%AD%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //南昌   http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E6%98%8C&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //广州    http://www.pm25.in/api/querys/pm2_5.json?city=%E5%B9%BF%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //福州   http://www.pm25.in/api/querys/pm2_5.json?city=%E7%A6%8F%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no
     //@"海口",http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B5%B7%E5%8F%A3&token=D3pAujQVDyWsqvHtyxXh&stations=no
    */
    
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8C%97%E4%BA%AC&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"北京"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%A4%A9%E6%B4%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"天津"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E4%B8%8A%E6%B5%B7&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"上海"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E9%87%8D%E5%BA%86&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"重庆"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E7%9F%B3%E5%AE%B6%E5%BA%84&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"石家庄"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%93%88%E5%B0%94%E6%BB%A8&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"哈尔滨"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E9%95%BF%E6%98%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"长春"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B2%88%E9%98%B3&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"沈阳"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%91%BC%E5%92%8C%E6%B5%A9%E7%89%B9&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"呼和浩特"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E4%B9%8C%E9%B2%81%E6%9C%A8%E9%BD%90&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"乌鲁木齐"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%85%B0%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"兰州"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E8%A5%BF%E5%AE%81&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"西宁"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E8%A5%BF%E5%AE%89&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"西安"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E9%93%B6%E5%B7%9D&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"银川"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E9%83%91%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"郑州"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B5%8E%E5%8D%97&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"济南"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%A4%AA%E5%8E%9F&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"太原"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%90%88%E8%82%A5&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"合肥"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E6%AD%A6%E6%B1%89&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"武汉"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E4%BA%AC&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"南京"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E6%88%90%E9%83%BD&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"成都"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E8%B4%B5%E9%98%B3&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"贵阳"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E6%98%86%E6%98%8E&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"昆明"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E5%AE" forKey:@"南宁"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E6%8B%89%E8%90%A8&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"拉萨"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E6%9D%AD%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"杭州"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%8D%97%E6%98%8C&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"南昌"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E5%B9%BF%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"广州"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E7%A6%8F%E5%B7%9E&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"福州"];
    [self.citydictionary setObject:@"http://www.pm25.in/api/querys/pm2_5.json?city=%E6%B5%B7%E5%8F%A3&token=D3pAujQVDyWsqvHtyxXh&stations=no" forKey:@"海口"];
    
    
    
    self.navigationItem.title = @"省市排行";
    
    //刷新标志
    self.activity = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
    self.activity.frame = CGRectMake(200, 7, 30, 30);
    [self.navigationController.navigationBar addSubview:self.activity];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //列表的实例化
    self.tableview = [[[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 49 - 44) style:UITableViewStylePlain] autorelease];
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.allowsSelection = NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    
    //列表按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_more_01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(listAction)];
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    
    
    //选择列表
    self.listview = [[[UIView alloc] initWithFrame:CGRectMake(320, 50, 70, 120)] autorelease];
    self.listview.backgroundColor = [UIColor colorWithRed:220.0 green:220.0 blue:220.0 alpha:0.6];
    [self.view addSubview:self.listview];
    //选择按钮
    UIButton *temperaturebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    temperaturebutton.titleLabel.font = [UIFont systemFontOfSize:15];
    temperaturebutton.frame = CGRectMake(0, 0, 70, 40);
    [temperaturebutton setTitle:@"温度排行" forState:UIControlStateNormal];
    [temperaturebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    temperaturebutton.backgroundColor = [UIColor clearColor];
    [temperaturebutton addTarget:self action:@selector(temperatureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.listview addSubview:temperaturebutton];
    //
    UIButton *airbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    airbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    airbutton.frame = CGRectMake(0, 40, 70, 40);
    [airbutton setTitle:@"空气排行" forState:UIControlStateNormal];
    airbutton.backgroundColor = [UIColor clearColor];
    [airbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [airbutton addTarget:self action:@selector(airAction) forControlEvents:UIControlEventTouchUpInside];
    [self.listview addSubview:airbutton];
    //
    UIButton *pmbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    pmbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    pmbutton.frame = CGRectMake(0, 80, 70, 40);
    [pmbutton setTitle:@"PM排行" forState:UIControlStateNormal];
    pmbutton.backgroundColor = [UIColor clearColor];
    [pmbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pmbutton addTarget:self action:@selector(pmAction) forControlEvents:UIControlEventTouchUpInside];
    [self.listview addSubview:pmbutton];
    
    //温度请求
    //空气请求
    [self getConnectionMessage];
    [self.activity startAnimating];
    
    
    
    
    
	// Do any additional setup after loading the view.
}

//网络请求
- (void)getConnectionMessage
{
    [self.activity startAnimating];
    if (isAir == 1) {//温度请求
        
        SqlManager *manager = [[SqlManager alloc] init];
        NSString *city = [self.cityarray objectAtIndex:number++];
        NSString *citynumber = [manager getcityid:city];
        [manager release];
        NSString *urlstr = [NSString stringWithFormat:@"http://weatherapi.market.xiaomi.com/wtr-v2/temp/forecast?cityId=%@",citynumber];
        NSURL *url = [NSURL URLWithString:urlstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }else {//空气和PM质量请求
        
        NSString *name = [self.cityarray objectAtIndex:number++];
        NSString *urlstr = [self.citydictionary objectForKey:name];
        NSURL *url = [NSURL URLWithString:urlstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}


//排列按钮的响应方法
- (void)temperatureAction
{
    [self.connection cancel];//停止当前连接
    [self.activity stopAnimating];//停止刷新
    isAir = 1;
//    if (self.resultarray.count == 0) {
//        
//        [self.activity startAnimating];
//        number = 0;
//        [self getConnectionMessage];
//    }else {
//        [self citysort];
//        self.tableArray = self.resultarray;
//        [self.tableview reloadData];
//    }
    
    number = 0;
    [self.resultarray removeAllObjects];
    [self.tableArray removeAllObjects];
    [self.tableview reloadData];
    [self getConnectionMessage];
    
    [self listAction];
}
- (void)airAction
{
    [self.connection cancel];
    [self.activity stopAnimating];//停止刷新
    isAir = 2;
//    if (self.airarray.count == 0) {
//        
//        [self.activity startAnimating];
//        number = 0;
//        [self getConnectionMessage];
//    }else {
//        [self airsort];
//        [self.tableArray removeAllObjects];
//        [self.tableArray addObjectsFromArray:self.airarray];
////        self.tableArray = self.airarray;
//        [self.tableview reloadData];
//    }
    
    number = 0;
    [self.airarray removeAllObjects];
    [self.tableArray removeAllObjects];
    [self.tableview reloadData];
    [self getConnectionMessage];
    
    [self listAction];
}
- (void)pmAction
{
    [self.connection cancel];
    [self.activity stopAnimating];//停止刷新
    isAir = 3;
//    if (self.airarray.count == 0) {
//        
//        [self.activity startAnimating];
//        number = 0;
//        [self getConnectionMessage];
//    }else {
//        [self pmsort];
//        self.tableArray = self.airarray;
//        [self.tableview reloadData];
//    }
    
    number = 0;
    [self.airarray removeAllObjects];
    [self.tableArray removeAllObjects];
    [self.tableview reloadData];
    [self getConnectionMessage];
    
    [self listAction];
}
//选项列表
- (void)listAction
{//(240, 50, 70, 120)
    if (self.listview.frame.origin.x == 240) {
        [UIView animateWithDuration:0.7 animations:^{
            self.listview.frame = CGRectMake(320, 50, 70, 120);
        }];
    }else if(self.listview.frame.origin.x == 320) {
        [UIView animateWithDuration:0.7 animations:^{
            self.listview.frame = CGRectMake(240, 50, 70, 120);
        }];
    }
}


//温度排列方法
- (void)citysort
{
    for (int i = 0; i < self.resultarray.count; i++) {
        for (int j = 0; j < self.resultarray.count - i - 1; j++) {
            
            CitySort *temp1 = [self.resultarray objectAtIndex:j];
            CitySort *temp2 = [self.resultarray objectAtIndex:j + 1];
            if ([temp1 getMax] < [temp2 getMax]) {
                NSString *temp3 = temp2.cityname;
                NSString *temp4 = temp2.temperature;
                temp2.cityname = temp1.cityname;
                temp2.temperature = temp1.temperature;
                temp1.cityname = temp3;
                temp1.temperature = temp4;
            }
            
        }
    }
}

//aqi的排行结果
- (void)airsort
{
    for (int i = 0; i < self.airarray.count; i++) {
        for (int j = 0; j < self.airarray.count - i - 1; j++) {
            
            CityAirSort *temp1 = [self.airarray objectAtIndex:j];
            CityAirSort *temp2 = [self.airarray objectAtIndex:j + 1];
            if ([temp1 aqiInt] < [temp2 aqiInt]) {
                NSString *tempname = temp2.cityname;
                NSString *tempaqi = temp2.aqi;
                NSString *tempquality = temp2.quality;
                NSString *temppm = temp2.pm;
                
                temp2.cityname = temp1.cityname;
                temp2.aqi = temp1.aqi;
                temp2.quality = temp1.quality;
                temp2.pm = temp1.pm;
                
                temp1.cityname = tempname;
                temp1.aqi = tempaqi;
                temp1.quality = tempquality;
                temp1.pm = temppm;
            }
            
        }
    }
}


//pm排行的结果
- (void)pmsort
{
    for (int i = 0; i < self.airarray.count; i++) {
        for (int j = 0; j < self.airarray.count - i - 1; j++) {
            
            CityAirSort *temp1 = [self.airarray objectAtIndex:j];
            CityAirSort *temp2 = [self.airarray objectAtIndex:j + 1];
            if ([temp1 pmInt] < [temp2 pmInt]) {
                NSString *tempname = temp2.cityname;
                NSString *tempaqi = temp2.aqi;
                NSString *tempquality = temp2.quality;
                NSString *temppm = temp2.pm;
                
                temp2.cityname = temp1.cityname;
                temp2.aqi = temp1.aqi;
                temp2.quality = temp1.quality;
                temp2.pm = temp1.pm;
                
                temp1.cityname = tempname;
                temp1.aqi = tempaqi;
                temp1.quality = tempquality;
                temp1.pm = temppm;
            }
            
        }
    }
}




//网络连接代理方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.mudata = [[[NSMutableData alloc] init] autorelease];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mudata appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (isAir == 1) {
        
        NSDictionary *dictionarytemp = [NSJSONSerialization JSONObjectWithData:self.mudata options:NSJSONReadingMutableContainers error:Nil];
        NSDictionary *weatherinfo = [dictionarytemp valueForKey:@"weatherinfo"];
        
        NSString *tempname = [weatherinfo valueForKey:@"city"];
        NSString *temperature = [weatherinfo valueForKey:@"temp1"];
        CitySort *sort = [CitySort initWithCityname:tempname temperature:temperature];
        [self.resultarray addObject:sort];
        //每次得到数据就进行排列刷新
        [self citysort];
        self.tableArray = self.resultarray;
        [self.tableview reloadData];
        
        if (number < self.cityarray.count) {
            SqlManager *manager = [[SqlManager alloc] init];
            NSString *city = [self.cityarray objectAtIndex:number++];
            NSString *citynumber = [manager getcityid:city];
            [manager release];
            NSString *urlstr = [NSString stringWithFormat:@"http://weatherapi.market.xiaomi.com/wtr-v2/temp/forecast?cityId=%@",citynumber];
            NSURL *url = [NSURL URLWithString:urlstr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
        }else {
            [self.activity stopAnimating];
        }
        
    }else if(isAir == 2) {
        NSDictionary *tempdic = [NSJSONSerialization JSONObjectWithData:self.mudata options:NSJSONReadingMutableContainers error:Nil];
        if ([tempdic isKindOfClass:[NSArray class]]) {
            //请求成功返回数组
            NSArray *arraytemp = [NSJSONSerialization JSONObjectWithData:self.mudata options:NSJSONReadingMutableContainers error:Nil];
            NSDictionary *dcitionary = [arraytemp objectAtIndex:0];
            NSNumber *pm2_5 = [dcitionary objectForKey:@"pm2_5"];
            NSNumber *aqi = [dcitionary objectForKey:@"aqi"];
            NSString *quality = [dcitionary objectForKey:@"quality"];
            NSString *sortname = [self.cityarray objectAtIndex:number];
            
            NSString *pm2_5str = [NSString stringWithFormat:@"%d",[pm2_5 integerValue]];
            NSString *aqistr = [NSString stringWithFormat:@"%d",[aqi integerValue]];
            CityAirSort *sort = [CityAirSort initWityCityname:sortname aqi:aqistr quality:quality pm:pm2_5str];
            [self.airarray addObject:sort];
//            NSLog(@"-pm2.5:%@--aqi:%@--quality:%@---number:%d",sort.pm,sort.aqi,sort.quality,number);
        }else {
            //请求失败返回字典
            NSString *error = [tempdic objectForKey:@"error"];
            NSLog(@"%@",error);
        }
        [self airsort];
        self.tableArray = self.airarray;
        [self.tableview reloadData];
        
        if (number < self.cityarray.count) {
            NSString *name = [self.cityarray objectAtIndex:number++];
            NSString *urlstr = [self.citydictionary objectForKey:name];
            NSURL *url = [NSURL URLWithString:urlstr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
        }else {
            [self.activity stopAnimating];
        }
        
    }else if (isAir == 3) {
        
        NSDictionary *tempdic = [NSJSONSerialization JSONObjectWithData:self.mudata options:NSJSONReadingMutableContainers error:Nil];
        if ([tempdic isKindOfClass:[NSArray class]]) {
            //请求成功返回数组
            NSArray *arraytemp = [NSJSONSerialization JSONObjectWithData:self.mudata options:NSJSONReadingMutableContainers error:Nil];
            NSDictionary *dcitionary = [arraytemp objectAtIndex:0];
            NSNumber *pm2_5 = [dcitionary objectForKey:@"pm2_5"];
            NSNumber *aqi = [dcitionary objectForKey:@"aqi"];
            NSString *quality = [dcitionary objectForKey:@"quality"];
            NSString *sortname = [self.cityarray objectAtIndex:number];
            
            NSString *pm2_5str = [NSString stringWithFormat:@"%d",[pm2_5 integerValue]];
            NSString *aqistr = [NSString stringWithFormat:@"%d",[aqi integerValue]];
            CityAirSort *sort = [CityAirSort initWityCityname:sortname aqi:aqistr quality:quality pm:pm2_5str];
            [self.airarray addObject:sort];
//            NSLog(@"-pm2.5:%@--aqi:%@--quality:%@---number:%d",pm2_5,aqi,quality,number);
        }else {
            //请求失败返回字典
            NSString *error = [tempdic objectForKey:@"error"];
            NSLog(@"%@",error);
        }
        [self pmsort];
        self.tableArray = self.airarray;
        [self.tableview reloadData];
        
        
        if (number < self.cityarray.count) {
            NSString *name = [self.cityarray objectAtIndex:number++];
            NSString *urlstr = [self.citydictionary objectForKey:name];
            NSURL *url = [NSURL URLWithString:urlstr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
        }else {
            [self.activity stopAnimating];
        }
        
    }


    

    
    
    
    self.mudata = Nil;
    
    
    
}






//tableview的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mark = @"sortmaikid";
    CitySortCell *cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (cell == nil) {
        cell = [[[CitySortCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mark] autorelease];
    }
    if (isAir == 1) {
        CitySort *temp = [self.tableArray objectAtIndex:indexPath.row];
        NSInteger citynumber = [self.cityarray indexOfObject:temp.cityname];
        cell.city = [self.cityarray2 objectAtIndex:citynumber];
        cell.content = [NSString stringWithFormat:@"最高温度%d度",[temp getMax]];
        cell.sub = @"";
        [cell setMessage];
    }else if (isAir == 2){
        CityAirSort *temp = [self.tableArray objectAtIndex:indexPath.row];
        NSInteger citynumber = [self.cityarray indexOfObject:temp.cityname];
        cell.city = [self.cityarray2 objectAtIndex:citynumber];
        cell.content = [NSString stringWithFormat:@"污染指数%@",temp.aqi];
        cell.sub = [NSString stringWithFormat:@"空气质量%@",temp.quality];
        [cell setMessage];
    }else if (isAir == 3){
        CityAirSort *temp = [self.tableArray objectAtIndex:indexPath.row];
        NSInteger citynumber = [self.cityarray indexOfObject:temp.cityname];
        cell.city = [self.cityarray2 objectAtIndex:citynumber];
        cell.content = [NSString stringWithFormat:@"PM2.5:%@",temp.pm];
        cell.sub = @"";
        [cell setMessage];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


- (void)dealloc
{
    [_tableview release];
    [_listview release];
    [_cityarray release];//不加省
    [_cityarray2 release];//城市加上省
    [_mudata release];
    [_citydictionary release];
    [_resultarray release];//温度结果
    [_airarray release];//空气结果
    [_tableArray release];//列表的展示结果
    [_activity release];
    [_connection release];
    [super dealloc];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
