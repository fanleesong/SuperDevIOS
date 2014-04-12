//
//  BEAppDelegate.h
//  CuiNotBook
//
//  Created by GL on 14-4-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test.h"


@protocol Delegate <NSObject>

@property(nonatomic,retain) NSString *hello;

@end

@interface BEAppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (nonatomic,retain) Test *test;

@end
