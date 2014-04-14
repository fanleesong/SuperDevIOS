//
//  ViewController.h
//  QQLoginDemo
//
//  Created by Otherplayer on 14-4-4.
//  Copyright (c) 2014年 Guole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface ViewController : UIViewController<TencentSessionDelegate>//代理

@property (strong, nonatomic)TencentOAuth *tencentOAuth;

@end
