//
//  ViewController.m
//  GrandCentralDispatch
//
//  Created by neal on 14-2-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//perform这种方式比较繁琐，除了点击事件外，还需要额外两个方法，一个是子线程执行的方法，一个是回到主线程执行的方法。
//GCD相对比较简单，一个方法内就可以搞定。


//perform这种方式 是你人为开辟线程，方法内部需要@autoreleasepool
//GCD是系统帮你开辟线程
- (void)aa{
    @autoreleasepool {
        //在这里做你的任务  比如：建立一个同步连接
        //        NSData *data = [NSURLConnection sendSynchronousRequest:<#(NSURLRequest *)#> queue:<#(NSOperationQueue *)#> completionHandler:<#^(NSURLResponse *response, NSData *data, NSError *connectionError)handler#>];
        NSLog(@"所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
        [self performSelectorOnMainThread:@selector(bb) withObject:nil waitUntilDone:NO];
    }
}

- (void)bb{
    //页面刷新
    NSLog(@"所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
}

- (IBAction)performInBackground:(id)sender{
    [self performSelectorInBackground:@selector(aa) withObject:nil];
}

- (IBAction)GCD:(id)sender{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        //在这里做你的任务  比如：建立一个同步连接
//        NSData *data = [NSURLConnection sendAsynchronousRequest:<#(NSURLRequest *)#> queue:<#(NSOperationQueue *)#> completionHandler:<#^(NSURLResponse *response, NSData *data, NSError *connectionError)handler#>];
        NSLog(@"所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            //页面刷新
            NSLog(@"所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
        });
    });
}

//在iOS里实现多线程的技术有很多，使用起来最简单的是GCD，执行效率最高的也是GCD，是相对底层的API，都是C的函数。GCD是苹果最推荐的多线程技术，GCD的核心是往dispatch queue里添加要执行的任务，由queue管理任务的执行。
- (IBAction)Serial:(UIButton *)sender {
    //dispatch queue有两种：serial queue（串行）和concurrent queue（并行）；无论哪种queue都是FIFO
    //serial queue的特点：执行完queue中第一个任务，执行第二个任务，执行完第二个任务，执行第三个任务，以此类推，任何一个任务的执行，必须等到上个任务执行完毕。
    
//    //获得serial queue的方式有2种：
//    //1、获得mainQueue。mainQueue会在主线程中执行，即：主线程中执行队列中的各个任务
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_async(mainQueue, ^{
//        NSLog(@"第1个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(mainQueue, ^{
//        NSLog(@"第2个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(mainQueue, ^{
//        NSLog(@"第3个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(mainQueue, ^{
//        NSLog(@"第4个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(mainQueue, ^{
//        NSLog(@"第5个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
    
    
    //2、自己创建serial queue。//自己创建的serial queue不会在主线程中执行，queue会开辟一个子线程，在子线程中执行队列中的各个任务
    dispatch_queue_t mySerialQueue = dispatch_queue_create("com.lanou3g.GCD.mySerialQueue", DISPATCH_QUEUE_SERIAL);//给queue起名字的时候，苹果推荐使用反向域名格式。
    dispatch_async(mySerialQueue, ^{
        NSLog(@"第1个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(mySerialQueue, ^{
        NSLog(@"第2个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(mySerialQueue, ^{
        NSLog(@"第3个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(mySerialQueue, ^{
        NSLog(@"第4个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(mySerialQueue, ^{
        NSLog(@"第5个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    
    
}

- (IBAction)Concurrent:(UIButton *)sender {
    //concurrent（并行）queue是另外一种队列。其特点：队列中的任务，第一个先执行，不等第一个执行完毕，第二个就开始执行了，不等第二个任务执行完毕，第三个就开始执行了，以此类推。后面的任务执行的晚，但是不会等前面的执行完才执行。
    
//    //获得concurrent queue的方法有2种：
//    //1、获得global queue。
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//第一个参数控制globalQueue的优先级，一共有4个优先级DISPATCH_QUEUE_PRIORITY_HIGH、DISPATCH_QUEUE_PRIORITY_DEFAULT、DISPATCH_QUEUE_PRIORITY_LOW、DISPATCH_QUEUE_PRIORITY_BACKGROUND。第二个参数是苹果预留参数，未来会用，目前填写为0.
//    //global queue会根据需要开辟若干个线程，并行执行队列中的任务（开始较晚的任务未必最后结束，开始较早的任务未必最先完成），开辟的线程数量取决于多方面因素，比如：任务的数量，系统的内存资源等等，会以最优的方式开辟线程---根据需要开辟适当的线程。
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第1个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第2个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第3个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第4个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第5个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第6个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第7个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第8个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第9个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
//    dispatch_async(globalQueue, ^{
//        NSLog(@"第10个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
//    });//在block里写要执行的任务（代码）
    
    
    
    //2、自己创建concurrent queue。
    //自己创建的concurrent queue会根据需要开辟若干个线程，并行执行队列中的任务（开始较晚的任务未必最后结束，开始较早的任务未必最先完成），开辟的线程数量取决于多方面因素，比如：任务的数量，系统的内存资源等等，会以最优的方式开辟线程---根据需要开辟适当的线程。
    dispatch_queue_t myConcurrentQueue = dispatch_queue_create("com.lanou3g.GCD.myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第1个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第2个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第3个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第4个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第5个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第6个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第7个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第8个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第9个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"第10个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//在block里写要执行的任务（代码）
}

- (IBAction)after:(UIButton *)sender {
    
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Hello");
    });//dispatch_after函数是延迟执行某个任务，任务既可以在mainQueue中进行也可以在其他queue中进行.既可以在serial队列里执行也可以在concurrent队列里执行。
    
//    dispatch_queue_t myConcurrentQueue = dispatch_queue_create("com.lanou3g.GCD.myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_after(popTime, myConcurrentQueue, ^(void){
//        NSLog(@"world");
//    });
}

- (IBAction)group:(UIButton *)sender {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t myConcurrentQueue = dispatch_queue_create("com.lanou3g.GCD.myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //dispatch_group_async用于把不同的任务归为一组
    //dispatch_group_notify当指定组的任务执行完毕之后，执行给定的任务
    dispatch_group_async(group, myConcurrentQueue, ^{
        NSLog(@"第1个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_group_async(group, myConcurrentQueue, ^{
        NSLog(@"第2个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_group_async(group, myConcurrentQueue, ^{
        NSLog(@"第3个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_group_async(group, myConcurrentQueue, ^{
        NSLog(@"第4个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_group_notify(group, myConcurrentQueue, ^{
        NSLog(@"group中的任务都执行完毕之后，执行此任务。所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_group_async(group, myConcurrentQueue, ^{
        NSLog(@"第5个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_group_async(group, myConcurrentQueue, ^{
        NSLog(@"第6个任务,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    
}

- (IBAction)barrier:(UIButton *)sender {
    //为了保证访问同一个数据时，数据的安全，我们可以使用serial queue解决数据安全访问的问题。
    //serial queue的缺陷是：后面的任务 必须等待 前面的任务 执行完毕 才能执行
    //对于往数据库写入数据 使用serial queue无疑能保证数据的安全。
    //对于从数据库中读取数据，使用serial queue就不太合适了，效率比较低。使用concurrent queue无疑是最合适的。
    //真实的项目中，通常既有对数据库的写入，又有数据库的读取。如何处理才最合适呢？
    
    //下面给出了 既有数据库数据读取，又有数据库数据写入的处理方法dispatch_barrier_async
    dispatch_queue_t myConcurrentQueue = dispatch_queue_create("com.lanou3g.GCD.myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"读取一些数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"读取另外一些数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"读取这些数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"读取那些数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    
    
    
    dispatch_barrier_async(myConcurrentQueue, ^{
        NSLog(@"写入某些数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });//dispatch_barrier_async就像一道墙，之前的任务都并行执行，执行完毕之后，执行barrier中的任务，之后的任务也是并行执行。
    
    
    
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"读取XXX数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"读取OOXX数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"读取aaa数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"读取bbb数据,所在线程%@,是否是主线程:%d",[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
}

- (IBAction)apply:(UIButton *)sender {
    //GCD中提供了API让某个任务执行若干次。
    NSArray *array = [NSArray arrayWithObjects:@"红楼梦",@"水浒传",@"三国演义",@"西游记", nil];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply([array count], queue, ^(size_t index) {
        NSLog(@"%@所在线程%@,是否是主线程:%d",[array objectAtIndex:index],[NSThread currentThread],[[NSThread currentThread] isMainThread]);
    });
}


- (IBAction)once:(UIButton *)sender {
    //dispatch_once 用于定义那些只需要执行一次的代码，比如单例的创建
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只执行一次");
        //这个block里的代码，在程序执行过程中只会执行一次。
        //比如在这里些单例的初始化
//        static YourClass *instance = nil;
//        instance = [[YourClass alloc] init];
    });
}


- (IBAction)syn:(id)sender {
    //我们一直在用  dispatch_async,GCD里有一些API是dispatch_sync，二者有什么区别呢？
    //dispatch_async无需等block执行完，继续执行dispatch_async后面的代码
    //dispatch_sync必须等block执行完，才继续执行dispatch_sync后面的代码
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

//    dispatch_sync(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"%d",i);
//        }
//    });
//    NSLog(@"haha");
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"%d",i);
        }
    });
    NSLog(@"haha");
}


- (IBAction)functionPoint:(id)sender {
    
    //dispatch_async_f往队列里放函数指针，队列控制相应函数的执行，不在是控制block的执行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async_f(queue, @"你好", function);//函数指针对应的函数类型：必须没有返回值，参数必须是void *。函数指针对应的参数，由dispatch_async_f第二个参数提供，可以是任意对象类型。
}

void function(void *context)
{
    NSLog(@"%@ 所在线程%@,是否是主线程:%d",context,[NSThread currentThread],[[NSThread currentThread] isMainThread]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
