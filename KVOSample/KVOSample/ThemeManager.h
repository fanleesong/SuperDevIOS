//
//  ThemeManager.h
//  KVOSample
//
//  Created by 范林松 on 14-4-11.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {

    ThemeDefault = 0,
    ThemeRed = 1,
    ThemeBlue = 2,

}ThemeType;

@interface ThemeManager : NSObject

@property(nonatomic,assign)ThemeType themeType;

+(instancetype)defaultManager;

@end
