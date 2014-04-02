//
//  QYHttpRequestManager.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-11.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYHttpRequestManager.h"
#import "ASIHTTPRequest.h"


@implementation QYHttpRequestManager

+(id)parserDataByRequest:(NSString *)requestLink{

    //实例化ASI
    ASIHTTPRequest* requestString = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:requestLink]];
    [requestString startSynchronous];//开启异步
    NSString* string = [requestString responseString];
    RELEASE_SAFETY(requestString);
    return string;
    
}
#pragma mark------+视频部分------
//视频搜索
+(id)getVideoSearchList:(NSString *)keyWord{

    NSString *link = kTUDO_VIDEO_SEARCH_URL(keyWord);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
    
}
//视频信息
+(id)getVideoInfoList:(NSString *)itemCodes{

    NSString *link = kTUDO_VIDEO_INFO_URL(itemCodes);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视屏排行榜
+(id)getVideoRankTopList:(NSInteger)channelID pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize{

    NSString *link = kTUDO_VIDEO_TOPLIST_URL(channelID,pageNo,pageSize);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视频评论
+(id)getVideoCommentList:(NSString *)itemCodes{

    NSString *link = kTUDO_VIDEO_COMMENTLIST_URL(itemCodes);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视屏状态列表
+(id)getVideoStatusList:(NSString *)itemCodes{

    NSString *link = kTUDO_VIDEO_STATUS_URL(itemCodes);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
}
#pragma mark--------------用户部分--------------

//用户信息
+(id)getAuthorCheckUserInfo{

    NSString *link = kTUDO_AUTHORIZE_INFO;
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
+(id)getAuthorVideoUserInfo:(NSString *)email{

    NSString *link = kTUDO_AUTHORIZE_USERINFO(email);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
}
#pragma mark----------Author2授权-----------
+(id)getOauthRight{

    NSString *link = kTUDO_AUTHORIZE_REQUEST;
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
    
}
+(id)getOauthGetTokenInfo:(NSString *)access_token{

    NSString *link = kTUDO_AUTHORIZE_ACCESS_RESPONSE(access_token);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
    
}
+(id)getOauthAccessToken:(NSString *)code{

    NSString *link = kTUDO_AUTHORIZE_ACCESS_TOKEN(code);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
+(id)getOauthRemoveAccessToken:(NSString *)access_token{

    NSString *link = kTUDO_AUTHORIZE_DESTROY_ACCESS(access_token);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
    
}




@end
