//
//  ThemeManager.m
//  KVOSample
//
//  Created by 范林松 on 14-4-11.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager



+(instancetype)defaultManager{

    static ThemeManager *instance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }

    });

    return instance;

}

-(id)init{

    if (self = [super init]) {
        
        //设置themeType默认值
        self.themeType = ThemeDefault;
        //对主题对象的主题类型属性进行自我检测
        [self addObserver:self forKeyPath:@"themeType" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    NSLog(@"%@",keyPath);
    NSLog(@"%@",object);
    NSLog(@"%@",change);
    
    //获取通知中心单例对象发送消息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ThemeChangeNotifaction" object:[change objectForKey:@"new"]];
    

}



@end











