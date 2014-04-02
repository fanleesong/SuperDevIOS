//
//  QYUserInfo.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-13.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import <Foundation/Foundation.h>

//用户类
@interface QYUserInfo : NSObject

@property(nonatomic,retain)NSString *userName;//用户名
@property(nonatomic,retain)NSString *userId;//用户id
@property(nonatomic,retain)NSString *gender;//性别
@property(nonatomic,retain)NSString *homeUrl;//主页链接
@property(nonatomic,retain)NSString *userPicUrl;//用户头像
@property(nonatomic,retain)NSString *nickName;//昵称

//初始化方法
-(id)initWithDictionary:(NSDictionary *)userDictionary;
+(id)userInfoWithDictionary:(NSDictionary *)userDictionary;

@end
