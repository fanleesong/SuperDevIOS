//
//  GRQNetwork.h
//  TestWeb
//
//  Created by lanou on 14-2-10.
//  Copyright (c) 2014年 All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GRQNetworkDatadidLoading;
@interface GRQNetwork : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, retain)NSURL *url;//请求数据的url
@property (nonatomic, assign) id<GRQNetworkDatadidLoading>delegate;//代理对象
//初始化方法
- (instancetype)initWithURL:(NSURL *)url;
//便利构造器
+ (instancetype)networkWithURL:(NSURL *)url;
//get请求数据
- (void)get;
//post请求数据
- (void)post:(NSData *)postData;
//取消数据请求
- (void)cancel;
@end

//网络请求封装类协议
@protocol GRQNetworkDatadidLoading <NSObject>

@optional
//网络请求数据成功时调用代理对象的该方法
- (void)network:(GRQNetwork *)network loadSuccess:(NSMutableData *)data;

@end
