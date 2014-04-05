//
//  BEAppDelegate.m
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "BEAppDelegate.h"
#import "WeatherViewController.h"
#import "SortViewController.h"
#import "MoodViewController.h"
#import "NewsViewController.h"
#import "SqlManager.h"
#import "BeginView.h"

#import "WeiboApi.h"


@implementation BEAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    
    
    //天气页面
    WeatherViewController *weather = [[WeatherViewController alloc] init];
    UINavigationController *weatherVC = [[UINavigationController alloc] initWithRootViewController:weather];
    weatherVC.navigationBarHidden = YES;
    weatherVC.tabBarItem.title = @"天气";
    weatherVC.tabBarItem.image = [UIImage imageNamed:@"tabbarWeather.png"];
    [weather release];
    
    //排行页面
    SortViewController *sort = [[SortViewController alloc] init];
    UINavigationController *sortVC = [[UINavigationController alloc] initWithRootViewController:sort];
    sortVC.tabBarItem.title = @"排行";
    sortVC.tabBarItem.image = [UIImage imageNamed:@"tabBarSort.png"];
    [sort release];
    
    //心情页面
    MoodViewController *mood = [[MoodViewController alloc] init];
    mood.tabBarItem.image = [UIImage imageNamed:@"tabbarAir.png"];
    
    
    //资讯页面
    NewsViewController *news = [[NewsViewController alloc] init];
    UINavigationController *newsVC = [[UINavigationController alloc] initWithRootViewController:news];
    newsVC.tabBarItem.title = @"资讯";
    newsVC.tabBarItem.image = [UIImage imageNamed:@"tabBarNews.png"];
    [news release];
    
    
    
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.tabBar.backgroundImage = [UIImage imageNamed:@"diy_tabbar.png"];
    
    tabBar.viewControllers =  [NSArray arrayWithObjects:weatherVC,sortVC,mood,newsVC, nil];
    tabBar.tabBar.barTintColor = [UIColor grayColor];
    [weatherVC release];
    [sortVC release];
    [mood release];
    [newsVC release];
    
    //-self.window.frame.size.height + 49
    BeginView *begin = [[BeginView alloc] initWithFrame:self.window.frame];
    [self.window addSubview:begin];
//    [begin beginview];

    
    [UIView animateWithDuration:4 animations:^{
        begin.frame = CGRectMake(0, 0, begin.frame.size.width, begin.frame.size.height - 0.001);
    }completion:^(BOOL finished) {
        [begin removeFromSuperview];
        self.window.rootViewController = tabBar;
    }];
    
    [begin release];
    [tabBar release];
    

    //初始化数据
//    SqlManager *manager = [[SqlManager alloc] init];
//    BOOL result = [manager addCity];
//    NSLog(@"%@",result?@"yes":@"no");
    
    
    
    
    

    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





//#pragma mark - sso
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return [self.viewController.wbapi handleOpenURL:url];
//}
//
////Available in iOS 4.2 and later.
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [self.viewController.wbapi handleOpenURL:url];
//}




@end
