//
//  QYCategoryViewController.m
//  QYMovieScanner
//
//  Created by 刘峰 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYCategoryViewController.h"
#import "SBJsonParser.h"
#import "QYHttpRequestManager.h"
#import "QYHomePageCell.h"
#import "QYVideoModule.h"
#import "QYVideoDetailViewController.h"

@interface QYCategoryViewController ()<UITableViewDataSource,UITableViewDelegate,CellDelegate>

@property (nonatomic,retain)NSMutableArray * searchArray;

@end

@implementation QYCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"频道分类";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //调用初始化视图方法
    [self _initSomeTableElements];
    
    
}
#pragma mark--初始化表示图等--
-(void)_initSomeTableElements{

    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_usercenter_0.png"]];
//    tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_usercenter_1.png"]];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    RELEASE_SAFETY(tableView);
    
    //tableView上面的ToolBar
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    toolBar.barTintColor = [UIColor lightGrayColor];
    NSMutableArray *toolBarArray = [NSMutableArray array];
    NSArray *titleArray = [NSArray arrayWithObjects:@"最新",@"大陆",@"香港",@"欧美",@"韩日", nil];
    for (int i = 0; i< titleArray.count; i++) {
        NSString * title = [titleArray objectAtIndex:i];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 60, 40)];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
//        [button setBackgroundImage:[UIImage imageNamed:@"log_in.png"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"toolbaritem_background2.jpg"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"log_in.png"]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(handleItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBarArray addObject:item];
        if (i != titleArray.count - 1 ) {
            [toolBarArray addObject:spaceItem];
        }
        RELEASE_SAFETY(item);
        RELEASE_SAFETY(spaceItem);
    }
    toolBar.items = toolBarArray;
    for (int i =0; i<toolBar.items.count; i++) {
        //        NSLog(@"======%@------------",NSStringFromCGRect([[toolBar.items objectAtIndex:i] frame]));
    }
    self.tableView.tableHeaderView = toolBar;
    RELEASE_SAFETY(toolBar);
    [self handleItemAction:[[toolBarArray objectAtIndex:0] customView]];

}

#pragma mark--实现handleItemAction方法--
- (void)handleItemAction:(id)sender{
    UIToolbar * toolBar = (UIToolbar *) self.tableView.tableHeaderView;
    //    NSLog(@"--------%@-------",toolBar);
    for (id object in toolBar.items) {
        if ([object isKindOfClass:[UIBarButtonItem class]]) {
            UIBarButtonItem * item = (UIBarButtonItem *)object;
            if (item.customView) {
                UIButton * aButton =(UIButton *) item.customView;
                if (aButton.selected) {
                    aButton.selected = NO;
                }
            }
        }
    }
    UIButton * button = (UIButton *)sender;
    button.selected = !button.selected;//让按钮停止为不选中状态
    SBJsonParser *parser = [[SBJsonParser alloc] init];//请求网络数据
    NSDictionary * dic = [parser objectWithString:[QYHttpRequestManager getVideoSearchList:[button titleForState:UIControlStateNormal]]];//根据按钮title对接keyword搜索
    NSArray * array = [dic objectForKey:@"results"];
    NSMutableArray * searchArray = [NSMutableArray array];
    for (int i = 0; i< array.count; i++) {
        NSDictionary * tempDic = [array objectAtIndex:i];
        QYVideoModule * aVideoModule = [[QYVideoModule alloc] initWithVideoInfos:tempDic];
        [searchArray addObject:aVideoModule];
        RELEASE_SAFETY(aVideoModule);
    }
    self.searchArray = searchArray;
    [self.tableView reloadData];
}

#pragma mark---tableDelegate--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (NSInteger)self.searchArray.count/3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellIdentifier = @"Cell";
    QYHomePageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[QYHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    QYVideoModule * videoModule1 = [self.searchArray objectAtIndex:indexPath.row *3];
    QYVideoModule * videoModule2 = [self.searchArray objectAtIndex:indexPath.row *3 +1];
    QYVideoModule * videoModule3 = [self.searchArray objectAtIndex:indexPath.row *3 +2];
    cell.dataForCellArray = [NSMutableArray arrayWithObjects:videoModule1,videoModule2,videoModule3, nil];
    
    cell.delegate = self;
    [cell setCellForDataArray];
    
    return cell;


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}
- (void)imageWithVideoModule:(QYVideoModule *)video didClick:(id)sender
{
    QYVideoDetailViewController * detaiVC = [[QYVideoDetailViewController alloc] init];
    detaiVC.picUrl = [video valueForKey:@"playUrl"];
    [self.navigationController pushViewController:detaiVC animated:YES];
    RELEASE_SAFETY(detaiVC);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    RELEASE_SAFETY(_searchArray);
    RELEASE_SAFETY(_tableView);
    [super dealloc];
}

@end
