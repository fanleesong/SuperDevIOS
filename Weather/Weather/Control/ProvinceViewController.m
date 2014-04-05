//
//  ProvinceViewController.m
//  Weather
//
//  Created by 15 on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "ProvinceViewController.h"
#import "SqlManager.h"

@interface ProvinceViewController ()

@property(nonatomic,retain) NSMutableArray *array;
@property(nonatomic,retain) UITableView *tableview;
@property(nonatomic,retain) NSDictionary *dictionary;

//搜索栏
@property(nonatomic,retain) UISearchBar *search;
@property(nonatomic,retain) UISearchDisplayController *display;
//搜索结果
@property(nonatomic,retain) NSArray *searcharray;

@end

@implementation ProvinceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        self.array = [NSMutableArray arrayWithObjects:@"北京市（京）",@"天津市（津）",@"上海市（沪）",@"重庆市（渝）",@"河北省（冀）",@"河南省（豫）",@"云南省（云）",@"辽宁省（辽）",@"黑龙江省（黑）",@"湖南省（湘）",@"安徽省（皖）",@"山东省（鲁）",@"新疆维吾尔（新）",@"江苏省（苏）",@"浙江省（浙）",@"江西省（赣）",@"湖北省（鄂）",@"广西壮族（桂）",@"甘肃省（甘）",@"山西省（晋）",@"内蒙古（蒙）",@"陕西省（陕）",@"吉林省（吉）",@"福建省（闽）",@"贵州省（贵）",@"广东省（粤）",@"青海省（青）",@"西藏（藏）",@"四川省（川）",@"宁夏回族（宁）",@"海南省（琼）",@"台湾省（台）",@"香港特别行政区",@"澳门特别行政区", nil];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        self.dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        self.array = (NSMutableArray *)[self.dictionary allKeys];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"省级列表";
    
    self.searcharray = [NSArray array];
    
    //背景
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageview.image = [UIImage imageNamed:@"chosecity2.jpg"];
    [self.view addSubview:imageview];
    [imageview release];
    
    
    //tableview实例化
    self.tableview = [[[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain] autorelease];
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    
    //搜索栏的实例化
    self.search = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 36)] autorelease];
    self.tableview.tableHeaderView = self.search;
    self.search.placeholder = @"搜索城市";
    self.search.backgroundColor = [UIColor clearColor];
    //展示搜索结果
    self.display = [[[UISearchDisplayController alloc] initWithSearchBar:self.search contentsController:self]autorelease];
    self.display.searchResultsDataSource = self;
    self.display.searchResultsDelegate = self;
    self.display.delegate = self;
//    self.display.searchResultsTableView.backgroundColor = [UIColor grayColor];
    
    
    
    //返回按钮
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = back;
    [back release];
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//模态退出
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断tableview
    if (tableView == self.tableview) {
        return self.array.count;
        
    }
    NSString *temp = self.search.text;
    SqlManager *manager = [[SqlManager alloc] init];
    self.searcharray = [manager getCity:temp];
    [manager release];
    return self.searcharray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        //选中单元格时的背景颜色
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    if (tableView == self.tableview) {
        NSString *title = [self.array objectAtIndex:indexPath.row];
        cell.textLabel.text = title;
    }else {
        NSString *title = [self.searcharray objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.text = title;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableview) {
        CityViewController *city = [[CityViewController alloc] init];
        NSString *key = [self.array objectAtIndex:indexPath.row];
        NSString *number = [self.dictionary objectForKey:key];
        city.province = [number integerValue];
        city.delegate = self;
        [self.navigationController pushViewController:city animated:YES];
        [city release];
    }else {
        NSString *city = [self.searcharray objectAtIndex:indexPath.row];
        SqlManager *manager = [[SqlManager alloc] init];
        NSString *citynumber = [manager getcityid:city];
        [manager release];
        [self chooseCity:citynumber];
    }
    
}

//cityView的代理方法
- (void)chooseCity:(NSString *)city
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cityNumber:)]) {
        [self.delegate cityNumber:city];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)dealloc
{
    [_tableview release];
    [_dictionary release];
    //搜索栏
    [_search release];
    [_display release];
    //搜索结果
    [_searcharray release];
    [_array release];
    [super dealloc];
}



@end
