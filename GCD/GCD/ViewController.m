//
//  ViewController.m
//  GCD
//
//  Created by 范林松 on 14-4-12.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
}
-(IBAction)didClickSerialQueue:(id)sender{

    
    //串行队列，2种方式；
    //1.获得主队列<mainQueue>
    //主队列特点：queue中的任务是在主线程中执行
//    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //2.自定义创建线程 serial队列--------一个队列就是一个线程
    //DISPATCH_QUEUE_SERIAL----串行队列
    //DISPATCH_QUEUE_CONCURRENT-----并行队列
    dispatch_queue_t queue = dispatch_queue_create("com.class15.serialQueue", DISPATCH_QUEUE_SERIAL);
    
    
    
    //添加异步任务
    dispatch_async(queue, ^{
        
        NSLog(@"task01 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task02 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task03 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    NSLog(@"-------------------------------------------------");
    
  

    
}

-(IBAction)didClickConCurrentQueue:(id)sender{
    
    //并行队列的两种方式
    //获取 系统的globalQueue
    /*--不同的priority优先级 --->抢占优先创建队里的机会
     #define DISPATCH_QUEUE_PRIORITY_HIGH 2
     #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
     #define DISPATCH_QUEUE_PRIORITY_LOW (-2)
     #define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
     */
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    //创建自己的队列
    dispatch_queue_t queue = dispatch_queue_create("com.class15.conCurrenQueue",DISPATCH_QUEUE_CONCURRENT);
    
    //添加异步任务
    dispatch_async(queue, ^{
        
        NSLog(@"task01 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task02 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task03 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task04 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task05 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task06 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });

    dispatch_async(queue, ^{
        
        NSLog(@"task07 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task08 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"task09 %@ ,%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
        
    });

    NSLog(@"------------------------------------------------------");
    

}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





















