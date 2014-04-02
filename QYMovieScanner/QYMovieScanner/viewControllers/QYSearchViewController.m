//
//  QYSearchViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYSearchViewController.h"
#import "SBJsonParser.h"
#import "QYHttpRequestManager.h"
#import "QYVideoModule.h"
#import "UIImageView+WebCache.h"
#import "QYVideoDetailViewController.h"
#include "QYVideoModule.h"

@interface QYSearchViewController (){

    BOOL isBool;
    NSString *requestName;
    int number;
    NSInteger integer;
    UIBarButtonItem *barButtonItem;
    
}

@end

@implementation QYSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"搜索相关";
        number = 2000;
        integer = 0;
        isBool = NO;
        self.filterTitleArray = [NSMutableArray array];//初始化数组
        self.imageURLArray = [NSMutableArray array];

    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self _initSomeSearchBarAndDisplay];
}
#pragma mark-----_initSomeSearchBarAndDisplay-------
-(void)_initSomeSearchBarAndDisplay{
    //初始化searchBar
    self.searchBar = [[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 1)]autorelease];
    self.searchBar.delegate = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [view addSubview:self.searchBar];
    [self.navigationItem.titleView addSubview: view];
    [view release];
    [self.searchBar sizeToFit];
    self.navigationItem.leftBarButtonItem =nil;
//[self.navigationController.navigationBar addSubview:self.searchBar];
    //初始化tableView
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.bounds.size.height ) style:UITableViewStylePlain]autorelease];
    self.tableView.rowHeight = 38;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.searchBar;//这里要加addsubview也不行,显示不了数据,加载导航条也显示不了.只有用等号才能显示.
    [self.view addSubview:self.tableView];
    //初始化UISearchDisplayController
    //self是指定被所搜的当前视图控制器
    self.searchDisplayCon = [[[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self]autorelease];
    self.searchDisplayCon.searchResultsDataSource = self;//要借用tableView的协议方法来展示数据
    self.searchDisplayCon.searchResultsDelegate = self; //要借用tableView的协议方法来展示数据
    requestName = KEYWORD_CHANNEL_MOVIES;//调用封装方法请求初始化数据
    self.filterTitleArray = [self requestDataAction:requestName];
    [self cateGoryAction];


}
#pragma mark----------cateGoryAction-------------
-(void)cateGoryAction{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50,320,480)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_search01.png"]];
    
    view.tag = 3004;
    //女性  搞笑  音乐 财富  电影  汽车  游戏  热点 记录篇
    NSArray *array = [NSArray arrayWithObjects:KEYWORD_CHANNEL_CUSTOMSTYLE,KEYWORD_CHANNEL_ENTERTANMENTS,
                      KEYWORD_CHANNEL_MUSICS,KEYWORD_CHANNEL_RICHERS,
                      KEYWORD_CHANNEL_MOVIES,KEYWORD_CHANNEL_CARSMOTIONS,
                      KEYWORD_CHANNEL_GAMES,KEYWORD_CHANNEL_HOTNEWS,
                      KEYWORD_CHANNEL_RECORDS,
                      KEYWORD_CHANNEL_ORIGINCREATE,
                      KEYWORD_CHANNEL_WOMEN,
                      KEYWORD_CHANNEL_PHYSICS,nil];
    /*
    NSArray *searchButtonBgNormalArray = @[@"channel_women.png",@"channel_funny.png",
                                           @"channel_music.png",@"channel_wealth.png",
                                           @"channel_movie.png",@"channel_car.png",
                                           @"channel_game.png",@"channel_amusementic.png",
                                           @"channel_tv.png"];
    NSArray *searchButtonBgSelectArray = @[@"channel_women_selected.png",
                                           @"channel_funny_selected.png",
                                           @"channel_music_selected.png",
                                           @"channel_wealth_selected.png",
                                           @"channel_movie_selected.png",
                                           @"channel_car_selected.png",
                                           @"channel_game_selected.png",
                                           @"channel_amusementic_selected.png",
                                           @"channel_tv_selected.png"];
   
    }*/

    NSInteger index = 0;
    for(int i = 1; i <=4; i++){
        for(int j = 1; j <4 ; j++){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(30+(j-1)*100, 20+(i-1)*95, 65, 60);
//            button.frame = CGRectMake(30+(j-1)*95, 20+(i-1)*120, 65, 60);
            NSString *imageName = [NSString stringWithFormat:@"searchCategory%d%d.png",i,j];
//            NSLog(@"i=%d,j=%d",i,j);
            NSString *selectimageName = [NSString stringWithFormat:@"searchCategory_selected%d%d.png",i,j];
            [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:selectimageName] forState:UIControlStateHighlighted];
            button.tag = 2000+index;
//            NSLog(@"%d",button.tag);
            [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30+(j-1)*100, 83+(i-1)*95, 65, 12)];
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30+(j-1)*95, 83+(i-1)*120, 65, 12)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.text = array[index];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            [label release];
            index++;
        }
    }
    [self.view addSubview:view];
}
#pragma mark -tableViewDataSource Method-封装请求数据的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.tableView == tableView && isBool == NO){
        return self.filterTitleArray.count;
    }
    
    if(isBool == YES && integer == 0){
        return self.filterArray.count;
    }else{
        self.filterArray = [self requestDataAction:self.searchBar.text];
        return self.filterArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    NSArray *orderArray = (tableView == self.tableView)&& isBool == NO?self.filterTitleArray:self.filterArray;
    QYVideoModule *video = [orderArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [video valueForKey:@"title"];
    cell.textLabel.textColor = [UIColor grayColor];
    if(indexPath.row == self.filterArray.count-1){
        isBool = NO;
        integer = 1;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *orderArray = (tableView == self.tableView)&& isBool == NO?self.filterTitleArray:self.filterArray;
    QYVideoModule *pic = [orderArray objectAtIndex:indexPath.row];
    QYVideoDetailViewController *detailVC = [[QYVideoDetailViewController alloc] init];
    detailVC.picUrl = [pic valueForKey:@"playUrl"];
    [self.navigationController pushViewController:detailVC animated:YES];
    RELEASE_SAFETY(detailVC);
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    isBool = YES;
    UIView *categoryView=(UIView*)[self.view viewWithTag:3004];
    [categoryView removeFromSuperview];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self cateGoryAction];
    UIView *categoryView=(UIView*)[self.view viewWithTag:3004];
    [categoryView removeFromSuperview];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self cateGoryAction];
}

#pragma mark----------CellDelegate-------------
-(NSMutableArray*)requestDataAction:(NSString*)requestActionName{
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    self.movieDataDic = [parser objectWithString:[QYHttpRequestManager getVideoSearchList:requestActionName]];//不能参数名和全局变量名一样,如果一样系统不知道执行哪个.
    self.filterArray = [self.movieDataDic objectForKey:@"results"];
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0; i < self.filterArray.count; i++){
        self.movieFilterDataDic = self.filterArray[i];
        QYVideoModule *imageMovie = [[QYVideoModule alloc] initWithVideoInfos:self.movieFilterDataDic]; //取出标题对象
//        [array addObject: [imageMovie valueForKey:@"title"]];
        [array addObject:imageMovie];
    }
    return [[array retain]autorelease] ;
    
}
#pragma mark----------handleAction:-------------
-(void)handleAction:(id)sender{
    UIView *categoryView=(UIView*)[self.view viewWithTag:3004];
    [categoryView removeFromSuperview];
    UIButton *button = (UIButton*)sender;
    NSInteger currentButton = button.tag;
//    NSLog(@"%@",self.navigationController.navigationBar.items);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(buttonForwardAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release];
    switch (currentButton) {
        case 2000:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_CUSTOMSTYLE];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2001:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_ENTERTANMENTS];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2002:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_MUSICS];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2003:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_RICHERS];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2004:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_MOVIES];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2005:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_CARSMOTIONS];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2006:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_GAMES];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2007:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_HOTNEWS];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2008:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_RECORDS];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2009:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_ORIGINCREATE];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2010:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_WOMEN];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
        case 2011:
            self.filterArray = [self requestDataAction:KEYWORD_CHANNEL_PHYSICS];
            isBool = YES;
            integer = 0;
            [self.tableView reloadData];
            break;
#warning mark--------
            
    }
    
}
-(void)buttonForwardAction:(id)sender{
    [self cateGoryAction];
    self.navigationItem.leftBarButtonItem = nil;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    
    RELEASE_SAFETY(_tableView);
    RELEASE_SAFETY(_searchBar);
    RELEASE_SAFETY(_tableView);
    RELEASE_SAFETY(_filterArray);
    RELEASE_SAFETY(_movieDataDic);
    RELEASE_SAFETY(_imageURLArray);
    RELEASE_SAFETY(_filterTitleArray);
    RELEASE_SAFETY(_searchDisplayCon);
    RELEASE_SAFETY(_movieFilterDataDic);
    [super dealloc];
    
}

@end
