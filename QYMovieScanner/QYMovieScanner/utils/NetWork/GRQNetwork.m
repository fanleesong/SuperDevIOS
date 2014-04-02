//
//  GRQNetwork.m
//  TestWeb
//
//  Created by lanou on 14-2-10.
//  Copyright (c) 2014年  All rights reserved.
//

#import "GRQNetwork.h"

@interface GRQNetwork ()

@property (nonatomic, retain)NSMutableData *downData;    //接收请求到的数据
@property (nonatomic, retain)NSURLConnection *connection;//网络连接

@end

@implementation GRQNetwork

- (void)dealloc
{
    //释放对象的拥有权
    [_url        release];
    [_downData   release];
    [_connection release];
    
    [super dealloc];
}

//初始化方法
- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        self.url = url;
    }
    
    return self;
}

//便利构造器
+ (instancetype)networkWithURL:(NSURL *)url
{
    GRQNetwork *network = [[GRQNetwork alloc] initWithURL:url];
    return [network autorelease];
}

//get请求数据
- (void)get
{
    //初始化NSData对象用于存放接收到的数据
    self.downData = [NSMutableData data];
    //创建网络请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    //进行网络连接
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

//post请求数据
- (void)post:(NSData *)postData
{
    //初始化NSData对象用于存放接收到的数据
    self.downData = [NSMutableData data];
    //创建可变网络请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    //设置请求为POST方式
    [request setHTTPMethod:@"POST"];
    //设置请求体
    [request setHTTPBody:postData];
    //进行网络连接
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

//取消数据请求
- (void)cancel
{
    [self.connection cancel];
}

#pragma mark - delegate

//接收到响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

//接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //把接收到的数据追加到数据包中
    [self.downData appendData:data];
}

//请求发生错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //打印错误信息
    NSLog(@"网络请求数据错误: %@",[error localizedDescription]);
}

//网络数据请求完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //调用代理对象对接收到的数据进行处理
    if ([self.delegate respondsToSelector:@selector(network:loadSuccess:)])
    {
        [self.delegate network:self loadSuccess:self.downData];
    }
}

@end
