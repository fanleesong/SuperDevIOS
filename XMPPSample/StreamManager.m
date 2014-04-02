//
//  StreamManager.m
//  XMPPSample
//
//  Created by 范林松 on 14-4-2.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "StreamManager.h"


@interface StreamManager()

//注册密码
@property(nonatomic,strong)NSString *registPwd;
//登陆密码
@property(nonatomic,strong)NSString *loginPwd;


//XMPP聊谈通道管理对象
@property(nonatomic,strong)XMPPStream *xmppStream;
//重置通道管理对象
-(void)_resetStream;
//链接通道管理对象
-(void)_linkStream;

@end


@implementation StreamManager

static StreamManager *instance = nil;

+(instancetype)defaultManager{

    static dispatch_once_t once;
    dispatch_once(&once,^{
        
        instance = [[self alloc] init];
        
    });
    return instance;

}
#pragma mark---
//重置通道管理对象
-(void)_resetStream{

    [self.xmppStream disconnect];
    self.xmppStream.myJID = nil;

}
//链接通道管理对象
-(void)_linkStream{

    [self.xmppStream connectWithTimeout:-1 error:nil];

}
#pragma mark----regist & login
-(void)loginWithName:(NSString *)name password:(NSString *)password{
    
    //重置通道管理对象
    [self _resetStream];
    //设置通道管理对象的主播方
    name = [name stringByAppendingString:@"@lin.local"];
    self.xmppStream.myJID = [XMPPJID jidWithString:name];
    self.loginPwd = password;
    //链接通道管理对象到服务器
    [self _linkStream];
}

-(void)registWithName:(NSString *)name password:(NSString *)password{

    //重置通道管理对象
    [self _resetStream];
    //设置通道管理对象的主播方
    name = [name stringByAppendingString:@"@lin.local"];
    self.xmppStream.myJID = [XMPPJID jidWithString:name];
    self.registPwd = password;
    //链接通道管理对象到服务器
    [self _linkStream];
    
}
-(void)xmppStreamWillConnect:(XMPPStream *)sender{

    NSLog(@"%s",__FUNCTION__);
    
}
-(void)xmppStreamDidConnect:(XMPPStream *)sender{

        NSLog(@"%s",__FUNCTION__);
    if (self.registPwd != nil) {
        //使用通道管理对象进行用户注册
        [self.xmppStream registerWithPassword:self.registPwd error:nil];
    }
    
    if (self.loginPwd != nil) {
        //使用通道管理对象进行用户登陆
        [self.xmppStream authenticateWithPassword:self.loginPwd error:nil];
    }
    
}
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{

        NSLog(@"%s",__FUNCTION__);

}
-(void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket{

        NSLog(@"%s",__FUNCTION__);
    
    
}
-(void)xmppStreamDidRegister:(XMPPStream *)sender{

    NSLog(@"%s",__FUNCTION__);
    
}
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"%s",__FUNCTION__);
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{

    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@",error.XMLString);
    
}
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@",error.XMLString);
    
}


-(instancetype)init{

    if (self = [super init]) {
     
        self.xmppStream = [[XMPPStream alloc] init];
        //添加通道管理对象的代理对象
        [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        //设置通道管理对象的服务器地址
        self.xmppStream.hostName = @"127.0.0.1";
        
    }
    
    return self;
    
}


@end









