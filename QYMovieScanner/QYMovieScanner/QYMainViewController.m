//
//  QYMainViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYMainViewController.h"
#import "QYBaseNavigationController.h"
#import "UIViewExt.h"

@interface QYMainViewController ()

-(void)_initCustomTabbarView;//初始化自定义Tabbar
-(void)_initShowViewControllers;//初始化视图

@end

@implementation QYMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.tabBar setHidden:YES];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //调用初始化view
    [self _initShowViewControllers];
    //调用自定义tabbar
    [self _initCustomTabbarView];
    
        

}
#pragma mark-初始化界面视图方法-
-(void)_initShowViewControllers{

    //实例化首页、分类、搜索、个人设置界面
    self.homeViewController = [[[QYHomeViewController alloc] init] autorelease];
    self.categoryViewController = [[[QYCategoryViewController alloc] init] autorelease];
    self.searchViewController = [[[QYSearchViewController alloc] init] autorelease];
    self.profileViewController = [[[QYProfileViewController alloc] init] autorelease];
    //放入数组中
    NSArray *viewsArray = @[self.homeViewController,self.categoryViewController,self.searchViewController,self.profileViewController];
    //声明数组
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:viewsArray.count];
    //循环添加视图
    for (id obj in viewsArray) {
        //将视图控制器添加到导航视图
        if ([obj isKindOfClass:[UIViewController class]]) {
            QYBaseNavigationController *baseNavigation = [[QYBaseNavigationController alloc] initWithRootViewController:(UIViewController *)obj];
            [viewControllers addObject:baseNavigation];
            RELEASE_SAFETY(baseNavigation);
        }
    }
    //将所有视图添加到该视图上
    self.viewControllers = viewControllers;

}

#pragma mark-自定义tabBar-
-(void)_initCustomTabbarView{
    
    //初始化自定义tabbar视图
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49, 320, 49)];
    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    //添加自定义视图
    [self.view addSubview:_tabbarView];
    
    //存储按钮图片
    NSArray *bgNormal = @[@"tabbar_home.png",@"tabbar_more.png",@"tabbar_discover.png",@"tabbar_profile.png"];
    NSArray *bghightligth = @[@"tabbar_home_highlighted.png",@"tabbar_more_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_profile_highlighted.png"];
    //循环放置按钮图标
    for (int i= 0; i<bgNormal.count; i++) {
        
        NSString *backImage = bgNormal[i];
        NSString *heighImage = bghightligth[i];
        //初始化自定义按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((78-70)/2+i*78,(49-27)/2 ,70,27);
        button.tag = i;//设置按钮tag
        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:heighImage] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        //添加自定义按钮
        [_tabbarView addSubview:button];
        
    }
    
    //初始化自定义tabbar下滑条
    _sliderView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_slider.png"]] autorelease];
    _sliderView.backgroundColor = [UIColor clearColor];
    _sliderView.frame = CGRectMake((78-15)/2, 5, 15, 44);
    [_tabbarView addSubview:_sliderView];

}
#pragma mark-实现按钮点选-
-(void)selectedTab:(UIButton *)sender{
    //获取Button值，赋给tabbar选中
    self.selectedIndex = sender.tag;
    //滑动条随点击事件按钮变化
    float x = sender.left + (sender.width-_sliderView.width)/2;
    //调用系统回调函数
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left = x;
    }];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    RELEASE_SAFETY(_homeViewController);
    RELEASE_SAFETY(_categoryViewController);
    RELEASE_SAFETY(_profileViewController);
    RELEASE_SAFETY(_searchViewController);
    [super dealloc];
}

@end
