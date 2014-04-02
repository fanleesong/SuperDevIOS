//
//  QYSearchViewController.h
//  QYMovieScanner
//
//  Created by 张宝龙 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseViewController.h"
//搜索视图
@interface QYSearchViewController : QYBaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,retain)NSDictionary *movieDataDic;//保存接受的数据.
@property(nonatomic,retain)NSDictionary *movieFilterDataDic;//保存帅选的数据
@property(nonatomic,retain)UISearchBar *searchBar;//搜索框
@property(nonatomic,retain)UISearchDisplayController *searchDisplayCon;//搜索控制器
@property(nonatomic,retain)NSArray *filterArray;//用来保存搜索后匹配的数据对应的对象.
@property(nonatomic,retain)NSMutableArray *filterTitleArray;//保存视频标题的数组
@property(nonatomic,retain)UITableView *tableView;//显示数据
@property(nonatomic,retain)NSMutableArray *imageURLArray;


@end
