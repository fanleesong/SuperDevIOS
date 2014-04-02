//
//  QYUserInfo.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-13.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYUserInfo.h"

@implementation QYUserInfo

-(id)initWithDictionary:(NSDictionary *)userDictionary{
    
    if (self = [super init]) {
        self.userId = [userDictionary objectForKey:@"userId"];
        self.userName = [userDictionary objectForKey:@"userName"];
        self.userPicUrl = [userDictionary objectForKey:@"userPicUrl"];
        self.nickName = [userDictionary objectForKey:@"nickName"];
        self.homeUrl = [userDictionary objectForKey:@"homeUrl"];
        self.gender = [userDictionary objectForKey:@"gender"];
        
    }
    
    return self;
}
+(id)userInfoWithDictionary:(NSDictionary *)userDictionary{

    QYUserInfo *userInfo = [[[QYUserInfo alloc] initWithDictionary:userDictionary] autorelease];
    return userInfo;

}

-(void)dealloc{

    RELEASE_SAFETY(_nickName);
    RELEASE_SAFETY(_userId);
    RELEASE_SAFETY(_userPicUrl);
    RELEASE_SAFETY(_homeUrl);
    RELEASE_SAFETY(_gender);
    RELEASE_SAFETY(_userName);
    [super dealloc];

}

@end
