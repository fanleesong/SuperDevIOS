////
////  NewsView.m
////  Weather
////
////  Created by 15 on 14-3-19.
////  Copyright (c) 2014年 G. All rights reserved.
////
//
//#import "NewsView.h"
//#import "NewsDetailViewController.h"
//#import "NewsItemCell.h"
//#import "NewsItems.h"
//
//
//@interface NewsView ()
//
//@property(nonatomic,retain) UITableView *tableView;
//
//@property(nonatomic,retain)NSMutableArray *titleArray;
//@property(nonatomic,retain)NSMutableData *receiveData;
//@property (nonatomic,assign) BOOL isRefreshing; // 刷新标志
//@property (nonatomic,assign) NSInteger pageIndex; // 记录当前加载的是第几个分页的数据
//@property (nonatomic,retain) UIRefreshControl *refresh;
//
//@property(nonatomic,retain) NSString *urlstr;
//@property(nonatomic,retain) NSString *numberstr;
//
//@end
//
//@implementation NewsView
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        
//        // Custom initialization
//        self.urlstr = @"http://c.m.163.com/nc/article/list/T1348648517839/0-20.html";
//        self.numberstr = @"T1348648517839";
//        
//        
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    
//    
//    int  no = arc4random_uniform(12);
//    NSString *imageName = [NSString stringWithFormat:@"bg%d.jpg",no];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
//    self.navigationItem.title = @"娱乐资讯";
//    
//    
//    //右边的选择按钮
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleDone target:self action:@selector(chooseNews)];
//    self.navigationItem.rightBarButtonItem = right;
//    [right release];
//    
//    self.tableView.refreshControl = [[[UIRefreshControl alloc] init] autorelease];
//    
//    [self.tableView.refreshControl addTarget:self action:@selector(connection:didReceiveData:) forControlEvents:UIControlEventValueChanged];
//    
//    
//    // 开始刷新
//    [self setbeginRefreshing];
//    
//    
//    //    NSString * string = @"http://c.m.163.com/nc/article/list/T1348648517839/0-20.html";
//    NSURL *urlString = [NSURL URLWithString:self.urlstr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
//    [NSURLConnection connectionWithRequest:request delegate:self];
//    
//    
//    
//	// Do any additional setup after loading the view.
//}
//
////选择分类按钮
//- (void)chooseNews
//{
//    CategoryNewsViewController *category = [[CategoryNewsViewController alloc] init];
//    category.delegate = self;
//    [self.navigationController pushViewController:category animated:YES];
//    [category release];
//}
//
//
//
//- (void)setbeginRefreshing
//{
//    
//    self.refresh = [[[UIRefreshControl alloc]init] autorelease];
//    
//    //刷新图形颜色
//    _refresh.tintColor = [UIColor lightGrayColor];
//    
//    //刷新的标题
//    _refresh.attributedTitle = [[[NSAttributedString alloc] initWithString:@"下拉刷新"] autorelease];
//    
//    // UIRefreshControl 会触发一个UIControlEventValueChanged事件，通过监听这个事件，我们就可以进行类似数据请求的操作了
//    [_refresh addTarget:self action:@selector(refreshTableviewAction:) forControlEvents:UIControlEventValueChanged];
//    
//    self.refreshControl =_refresh;
//    
//    self.titleArray = [NSMutableArray array];
//    
//}
//
//
//-(void)refreshTableviewAction:(UIRefreshControl *)refresh
//{
//    if (refresh.refreshing) {
//        
//        refresh.attributedTitle = [[[NSAttributedString alloc]initWithString:@"正在刷新"] autorelease];
//        
//        [self performSelector:@selector(startRefreshWbeData) withObject:nil afterDelay:2];
//    }
//}
//
//
//#pragma mark 开始刷新startRefreshWbeData
//-(void)startRefreshWbeData
//{
//    
//    self.receiveData = nil;
//    
//    NSURL *urlString = [NSURL URLWithString:self.urlstr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
//    [NSURLConnection connectionWithRequest:request delegate:self];
//    
//    /*
//     //    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.receiveData options:NSJSONReadingMutableContainers error:nil];
//     //        NSArray *newsList = [dic objectForKey:@"T1348648517839"];
//     //    // 如果不存在 则实例化
//     //    if (!self.titleArray) {
//     //        self.titleArray = [NSMutableArray array];
//     //    }
//     //
//     //    if (_refresh) {
//     //        [self.titleArray removeAllObjects];
//     //        NSLog(@"刷新移除了哇 啊啊 ");
//     //    }
//     //
//     //    // 得到的newsList数组里粗不出的一条条新闻 将字典实例化为对应的NewsItem类实例化的对象
//     //
//     //    for (int i = 0; i < newsList.count; i++) {
//     //
//     //        NewsItems *item = [[NewsItems alloc] initWithDictionary:[newsList objectAtIndex:i]];
//     //
//     //        [self.titleArray addObject:item];
//     //
//     //        [item release],item = nil;
//     //
//     //        _refresh = NO;
//     //        [self.tableView reloadData];
//     //
//     //    }
//     //    NSLog(@"重新加载数据；额");
//     */
//    
//    
//}
//
//
//
//#pragma mark - NSURLConnectionDataSourceDelegateMethod -
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    self.receiveData = Nil;
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    // 显示更新时间
//    //    NSString *syseTiem = nil;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"HH:mm:ss"]; //创建的时间格式
//    //    syseTiem = [formatter stringFromDate:[NSDate date]];
//    NSString *lastUpdated = [NSString stringWithFormat:@"更新于:%@", [formatter stringFromDate:[NSDate date]]];
//    self.refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:lastUpdated] autorelease];
//    self.refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:lastUpdated] autorelease];
//    [formatter release];
//    
//    
//    // 收到数据 停止刷新
//    
//    [_refresh endRefreshing];
//    
//    
//    if (!self.receiveData) {
//        self.receiveData = [NSMutableData data];
//    }
//    
//    [self.receiveData appendData:data];
//}
//
//
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.receiveData options:NSJSONReadingMutableContainers error:nil];
//    
//    self.titleArray = [dic objectForKey:self.numberstr];
//    
//    [self.tableView reloadData];
//    
//    //随即图片
//    int  no = arc4random_uniform(12);
//    NSString *imageName = [NSString stringWithFormat:@"bg%d.jpg",no];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
//    
//}
//
////接收失败
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    [self.refresh endRefreshing];
//    UILabel *faillabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 300, 180, 25)];
//    faillabel.backgroundColor = [UIColor blackColor];
//    faillabel.layer.cornerRadius = 10;
//    [self.view addSubview:faillabel];
//    [faillabel release];
//    
//}
//
//
//
//
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//
//
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    //    return self.titleArray.count + 1 ;
//    return self.titleArray.count ;
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    static NSString *indetify = @"CELL";
//    NewsItemCell  * cell = [tableView dequeueReusableCellWithIdentifier:indetify];
//    if (cell == nil) {
//        cell = [[[NewsItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetify] autorelease];
//    }
//    
//    cell.backgroundColor = [UIColor clearColor];
//    
//    
//    NewsItems *item = [[NewsItems alloc] initWithDictionary:[self.titleArray objectAtIndex:indexPath.row]];
//    
//    cell.newsTitleLabel.text = item.newTitle;
//    cell.newsTitleLabel.font = [UIFont systemFontOfSize:18];
//    cell.newsTitleLabel.numberOfLines = 0;
//    cell.newsPublishDateLabel.text =item.newsPublishDate;
//    cell.newsPublishDateLabel.font = [UIFont systemFontOfSize:10];
//    
//    [item release];
//    
//    //    cell.textLabel.text = [[self.titleArray objectAtIndex:indexPath.row] objectForKey:@"title"];
//    
//    return cell;
//    
//    
//    
//    
//    
//}
//
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//
//
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NewsDetailViewController *newsVC = [[NewsDetailViewController alloc] init];
//    newsVC.urlString = [[self.titleArray objectAtIndex:indexPath.row] objectForKey:@"docid"];
//    
//    [self.navigationController pushViewController:newsVC animated:YES];
//    [newsVC release], newsVC = nil;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65;
//}
//
//
//- (void)chooseCategory:(NSString *)url number:(NSString *)num
//{
//    self.urlstr = url;
//    self.numberstr = num;
//    [self startRefreshWbeData];
//}
//
///*
// // Override to support conditional editing of the table view.
// - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
// {
// // Return NO if you do not want the specified item to be editable.
// return YES;
// }
// */
//
///*
// // Override to support editing the table view.
// - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
// {
// if (editingStyle == UITableViewCellEditingStyleDelete) {
// // Delete the row from the data source
// [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
// }
// else if (editingStyle == UITableViewCellEditingStyleInsert) {
// // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
// }
// }
// */
//
///*
// // Override to support rearranging the table view.
// - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
// {
// }
// */
//
///*
// // Override to support conditional rearranging of the table view.
// - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
// {
// // Return NO if you do not want the item to be re-orderable.
// return YES;
// }
// */
//
///*
// #pragma mark - Navigation
// 
// // In a story board-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
// {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// 
// */
//
//
//- (void)dealloc
//{
//    [_titleArray release];
//    [_receiveData release];
//    [_refresh release];
//    [super dealloc];
//}@end
