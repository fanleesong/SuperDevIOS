//
//  BEAppDelegate.m
//  CuiNotBook
//
//  Created by GL on 14-4-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "BEAppDelegate.h"
#import "A.h"



@implementation BEAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}


int sum(int a,int b)
{
    return a + b;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    
    
    //block块
//    //block 在c中叫匿名函数
//    int (*p3)(int x,int y) = sum;
//    //类型 int (int,int)
//    //变量 p3
//    //初值 sum
//    int c = p3(5,6);
//    NSLog(@"%d",c);
//    
//    typedef int (*B)(int x,int y);
//    B b = sum;
//    
//    
//    int (^p)(int x,int y) = ^ int (int x,int y) {
//        return x + y;
//    };
//    //block类型 int (^)(int x,int y)
//    //block变量 p
//    //初值 暂无
//    //block值 语法格式 ^ 返回值类型 参数列表{函数体}
//    int num = p(4,9);
//    
//    float (^changeString)(NSString *) = ^(NSString *str) {
//        return [str floatValue];
//    };
//    float result = changeString(@"12.8");
//    NSLog(@"%.2f",result);
//    
//    float (^p4)() = ^(){
//        //num = 8;堆中的变量不能修改,
//        return 3.14f;
//    };
//    
//    
//    Test *test = [[Test alloc] init];
//    
//    
//    A *a = [[A alloc] initWithBlock:^float(NSString *floatstr) {
//        NSLog(@"retatin count is %d",[test retainCount]);
//        return [floatstr floatValue];
//    }];
////    [test release];
//    [a a:@"56.2"];
//    [a release];
    
    
    
    /*
     如果在block内部中引用变量，会将引用计数加一，防止block传递后引用变量不存在的情况
     如果不想让变量的引用计数加一，在外部用__block修饰一个临时变量，接收要传递的变量，在block中引用
     */

    
    
//--------------------------------------------------------------------
    
    
    //多线程
//    [self a];
    
//    [NSThread detachNewThreadSelector:@selector(a) toTarget:self withObject:Nil];
    
//    [self performSelectorInBackground:@selector(a) withObject:Nil];//内部实现用的时NSThread
    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue setMaxConcurrentOperationCount:8];//设置队列中最大的队列数
//    NSInvocationOperation *top = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(a) object:Nil];
////    [top start];
//    [queue addOperation:top];//NSOperationQueue负责开辟一个线程，将NSInvocationOperation添加进去
    
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)a
{
    NSLog(@"%@",[NSThread currentThread]);//线程num为1的是主线程
    @autoreleasepool {
        for (int i = 0; i < 10000; i++) {
            NSLog(@"%d",i);
        }
    }
    
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

@end
