//
//  QYHomeViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYHttpRequestManager.h"
#import "QYVideoDetailViewController.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "Reachability.h"
#import "QYVideoModule.h"
#import "QYHomePageCell.h"
#import "UIUtils.h"
#import "JSON.h"



@interface QYHomeViewController ()<CellDelegate>

@property (nonatomic, assign) int pageSize;   //允许请求页码的最大值
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView; //下拉刷新
@property (nonatomic, retain) EGORefreshTableFooterView *refreshFooterView; //上拉加载
@property (nonatomic, assign) BOOL reloading; //是否正在加载数据
@property (nonatomic, assign) EGORefreshPos requestPosition;//判断是哪个刷新数据
@property (nonatomic, retain) Reachability *reachability;//判断
@property (nonatomic, assign) BOOL flag;//页面已经加载数据标志


@end

@implementation QYHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"推荐首页";
        self.tableSectionElementsArray = [NSMutableArray array];
        self.imageURLArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];

    [self _loadVideoArrayData:nil pageNo:1 pageSize:20];//根据频道获取数据
    [self _initTableView]; //初始化tableView
    [self setupViews:self.imageURLArray titlesChanels:nil];//表示图初始化后待用该方法{此处放置网络图片轮播}
    [self createHeaderView];//添加下拉刷新
    [self createFooterView];//添加上拉加载
    
}

#pragma mark-------------- 初始化字典数据 根据频道获取 --------------------
-(void)_loadVideoArrayData:(NSArray *)channelIDArray pageNo:(NSInteger)currentPage pageSize:(NSInteger)pageSize{
    
/***************************获取值*****************************/
    SBJsonParser* parser = [[SBJsonParser alloc] init];//JSON解析
    NSDictionary *movieDic = [parser objectWithString:[QYHttpRequestManager getVideoRankTopList:CHANNEL_MOVIES pageNo:currentPage pageSize:pageSize]];
    NSArray *movie = [movieDic objectForKey:@"results"];//获取结果数组
    NSLog(@"%@",movie);
    for (int i=0; i<(NSInteger)movie.count-1; i++) {
        NSDictionary *oneDic = movie[i];
        if ([oneDic objectForKey:@"picUrl"] == [NSNull null]) {
            continue;
        }
        NSLog(@"%@",[oneDic objectForKey:@"bigPicUrl"]);
        if ([oneDic objectForKey:@"bigPicUrl"] == [NSNull null]) {
            continue;
        }
/*************************截取轮播图片**************************/
        //放置轮播图片
        if (_requestPosition == EGORefreshHeader){
            if (i<6) {
                QYVideoModule *imageMovie = [[QYVideoModule alloc] initWithVideoInfos:oneDic];
                [self.imageURLArray addObject:imageMovie];
                RELEASE_SAFETY(imageMovie);
            }
        }else if(_requestPosition == EGORefreshFooter){
        
        }else{
        
            if (i<6) {
                QYVideoModule *imageMovie = [[QYVideoModule alloc] initWithVideoInfos:oneDic];
                [self.imageURLArray addObject:imageMovie];
                RELEASE_SAFETY(imageMovie);
            }
            
        }
        QYVideoModule *addMoives = [[QYVideoModule alloc] initWithVideoInfos:oneDic];
        if (![[[[QYVideoModule alloc] initWithVideoInfos:movie[i]]autorelease ] isEqual:[[[QYVideoModule alloc] initWithVideoInfos:movie[i+1]] autorelease]]) {//筛选出不同的视频对象
            if (addMoives && addMoives.title != nil) {
                [self.tableSectionElementsArray addObject:addMoives];
                RELEASE_SAFETY(addMoives);
            }
        }
    }
    QYVideoModule *lastMovie = [[QYVideoModule alloc] initWithVideoInfos:[movie lastObject]];
    [self.tableSectionElementsArray addObject:lastMovie];
    RELEASE_SAFETY(lastMovie);
    [self.tableView reloadData];//更新tableView
    [self tableViewFinishedLoadData]; //数据请求结束
    RELEASE_SAFETY(parser);
}
#pragma mark-------------- 表示图头部图片轮播数据初始化工作 --------------------
- (void)setupViews:(NSMutableArray *)imagesURLS titlesChanels:(NSMutableArray *)titlesChanels{//传入图片地址
    
    //循环得出存入数组的视频对象获取对应图片地址
    NSMutableArray *imageUrl = [NSMutableArray arrayWithCapacity:imagesURLS.count];
    for (int i = 0; i<imagesURLS.count;i++) {
        QYVideoModule *url = imagesURLS[i];
        if (url.bigPicUrl) {
            [imageUrl addObject:url.bigPicUrl];
        }
    }
    EScrollerView *scroller;
    NSLog(@"%@",imageUrl);
    scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 20, 320, 160)
                                           ImageArray:imageUrl
                                           TitleArray:titlesChanels];//设置轮播图片
    scroller.delegate=self;
    self.tableView.tableHeaderView = scroller;//添加到表示图HeaderTableView上
    [scroller release];
    
}
-(void)EScrollerViewDidClicked:(NSUInteger)index{
    
    if (index<self.imageURLArray.count+1) {
        QYVideoModule *pic = [self.imageURLArray objectAtIndex:index-1];
        QYVideoDetailViewController *detailVC = [[QYVideoDetailViewController alloc] init];
        detailVC.picUrl = pic.playUrl;
        [self.navigationController pushViewController:detailVC animated:YES];
        RELEASE_SAFETY(detailVC);
    }else{
        //当index大于图片数组的长度+1-->此时为下一轮图片轮播开始
        QYVideoModule *pic = [self.imageURLArray objectAtIndex:0];
        QYVideoDetailViewController *detailVC = [[QYVideoDetailViewController alloc] init];
        detailVC.picUrl = pic.playUrl;
        [self.navigationController pushViewController:detailVC animated:YES];
        RELEASE_SAFETY(detailVC);
    }
    
}

#pragma mark-------------- 初始化标示图 --------------------
-(void)_initTableView{
    
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];//表视图
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_usercenter_0.png"]];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

#pragma mark--TableViewController  Delegate--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (NSInteger)_tableSectionElementsArray.count/3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIndetifier = @"cell";
    QYHomePageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (cell == nil) {
        cell = [[[QYHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier] autorelease];
    }
    cell.delegate = self;
    QYVideoModule * movieModul1 = [_tableSectionElementsArray objectAtIndex:indexPath.row * 3];
    QYVideoModule * movieModul2 = [_tableSectionElementsArray objectAtIndex:(indexPath.row * 3 +1)];
    QYVideoModule * movieModul3 = [_tableSectionElementsArray objectAtIndex:(indexPath.row * 3 +2)];
    cell.dataForCellArray = [NSMutableArray arrayWithObjects:movieModul1,movieModul2,movieModul3, nil];
    [cell setCellForDataArray];
    return cell;
    
}
#pragma mark - CellDelegate Method -
- (void)imageWithVideoModule:(QYVideoModule *)video didClick:(id)sender{
    
    self.playUrl = video.playUrl;
    QYVideoDetailViewController *detailVC = [[QYVideoDetailViewController alloc] init];
    detailVC.picUrl = self.playUrl;
    [self.navigationController pushViewController:detailVC animated:YES];
    RELEASE_SAFETY(detailVC);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return KEYWORD_CHANNEL_MOVIES;
}

#pragma mark -------Refresh Data Source Loading / Reloading Methods-----------
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];//刷新下拉刷新的状态
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];//刷新上拉加载的状态
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];//刷新下拉刷新的状态
    [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];//刷新上拉加载的状态
    
}
#pragma methods ---------------初始化刷新视图--------------
#pragma methods for creating and removing the header view
-(void)createHeaderView{
    
    self.refreshHeaderView = [[[EGORefreshTableHeaderView alloc] initWithFrame:
                              CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                         self.view.frame.size.width, self.view.bounds.size.height)] autorelease];
    self.refreshHeaderView.delegate = self;
    [self.tableView addSubview:self.refreshHeaderView];//追加下拉刷新视图到tableView
    [self.refreshHeaderView refreshLastUpdatedDate];//更新刷新时间
    
}

#pragma methods ---------------初始化上提加载视图-----------
#pragma methods for creating and removing the header view
-(void)createFooterView{
    
    CGFloat height = MAX(self.tableView.contentSize.height, self.tableView.frame.size.height);
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, height, self.tableView.frame.size.width, self.view.bounds.size.height)];
    _refreshFooterView.delegate = self;
    [self.tableView addSubview:_refreshFooterView];//追加下拉刷新视图到tableView
    [_refreshFooterView refreshLastUpdatedDate];//更新刷新时间
    
}

#pragma mark --EGORefreshTableDelegate Methods--
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
	
	[self beginToReloadData:aRefreshPos];//开始刷新数据
    
}
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	return _reloading; // should return if data source model is reloading
}
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark data reloading methods that must be overide by the subclass
/*---------------------------------------------------
 *刷新视图的代理方法会调用该方法来实现数据的刷新或者加载
 *--------------------------------------------------*/
-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	_reloading = YES;//  should be calling your tableviews data source model to reload
    if (aRefreshPos == EGORefreshHeader){
        [self refreshTableData];//下拉刷新数据
    }
    if(aRefreshPos == EGORefreshFooter){
        [self reloadTableViewDataSource];//上提加载数据，从第2页请求
    }
	
}
#pragma mark----------refreshTableData-----------
-(void)refreshTableData{
    
    [self.imageURLArray removeAllObjects];
    [self.tableSectionElementsArray removeAllObjects];
    [self _loadVideoArrayData:nil pageNo:1 pageSize:20];
    _reloading = NO;
    [self.tableView reloadData];
    
}

#pragma mark -------Data Source Loading / Reloading Methods-----------
- (void)reloadTableViewDataSource{//开始重新加载时调用的方法
    //开始刷新后执行后台线程，在此之前可以开启HUD或其他对UI进行阻塞
    [NSThread detachNewThreadSelector:@selector(doInBackground) toTarget:self withObject:nil];
}
#pragma mark --------Background operation------------------------------
-(void)doInBackground{//这个方法运行于子线程中，完成获取刷新数据的操作
    
    //获取新的网络加载页码---第一次上提时加载请求第二页数据
    int currentPage = self.tableSectionElementsArray.count/20+1;
    [self _loadVideoArrayData:nil pageNo:currentPage pageSize:20];
    [NSThread sleepForTimeInterval:3];
    //后台操作线程执行完后，到主线程更新UI
    [self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:YES];
    [self.tableView reloadData];
    
}

- (void)doneLoadingTableViewData{//完成加载时调用的方法
    
    _reloading = NO;
    [self.refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self.tableView reloadData];//刷新表格内容
    
}

#pragma mark method that should be called when the refreshing is finished
-(void)tableViewFinishedLoadData{//tableView请求完数据后调用
    
    _reloading = NO;//加载标志复位
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self setFooterView];//重新设置footView
}

-(void)setFooterView{//加载了数据后需要重新设置上拉加载视图的位置
    
    CGFloat height = MAX(self.tableView.contentSize.height, self.tableView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]){
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              self.tableView.frame.size.width,
                                              self.view.bounds.size.height);
    }else{
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         self.tableView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [_tableView addSubview:_refreshFooterView];
        
    }
    if (_refreshFooterView){//刷新更新时间
        [_refreshFooterView refreshLastUpdatedDate];
    }
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    RELEASE_SAFETY(_refreshFooterView);
    RELEASE_SAFETY(_refreshHeaderView);
    RELEASE_SAFETY(_tableSectionElementsArray);
    RELEASE_SAFETY(_imageURLArray);
    RELEASE_SAFETY(_playUrl);
    [super dealloc];
}
@end
