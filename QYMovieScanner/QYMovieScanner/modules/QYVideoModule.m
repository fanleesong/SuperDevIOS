//
//  QYVideoModule.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-11.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYVideoModule.h"
#import "UIUtils.h"

@implementation QYVideoModule
//初始化方法
-(id)initWithVideoInfos:(NSDictionary *)dictionary{
    
    if (self = [super init]) {
        /*
        self.bigPicUrl = [dictionary objectForKey:@"bigPicUrl"];
        self.channelId = (NSInteger)[dictionary objectForKey:@"channelId"];
        self.pubDate = [dictionary objectForKey:@"pubDate"];
        self.title = [dictionary objectForKey:@"title"];
        self.tags = [dictionary objectForKey:@"tags"];
        self.description = [dictionary objectForKey:@"description"];
        self.picUrl = [dictionary objectForKey:@"picUrl"];
        self.totalTime = [dictionary objectForKey:@"totalTime"];
        self.playUrl = [dictionary objectForKey:@"playUrl"];
        */
        self.itemCode = [dictionary objectForKey:@"itemCode"];
        self.downEnable = (NSInteger)[dictionary objectForKey:@"downEnable"];
        self.commentCount = (NSInteger)[dictionary objectForKey:@"commentCount"];
        //使用KVC模式设置属性
        NSArray *keyArray = [dictionary allKeys];
        for (NSString *key in keyArray) {
            if ([key isEqualToString:@"itemCode"]) {
                [self setValue:[dictionary objectForKey:@"itemCode"] forKey:@"itemCode"];
                continue;
            }
            else if ([key isEqualToString:@"title"]){
                [self setValue:[dictionary objectForKey:@"title"] forKey:@"title"];
                continue;
            }
            else if ([key isEqualToString:@"tags"]){
                [self setValue:[dictionary objectForKey:@"tags"] forKey:@"tags"];
                continue;
            }
            else if ([key isEqualToString:@"description"]){
                [self setValue:[dictionary objectForKey:@"description"] forKey:@"description"];
                continue;
            }
            else if ([key isEqualToString:@"picUrl"]){
                [self setValue:[dictionary objectForKey:@"picUrl"] forKey:@"picUrl"];
                continue;
            }
            else if ([key isEqualToString:@"totalTime"]){//转化时间
                NSString * string = [dictionary objectForKey:@"totalTime"];
                NSString * timeString = [UIUtils totalTimeFromString:string];
                [self setValue:timeString forKey:@"totalTime"];
                continue;
            }
            else if ([key isEqualToString:@"pubDate"]){
                [self setValue:[dictionary objectForKey:@"pubDate"] forKey:@"pubDate"];
                continue;
            }
            else if ([key isEqualToString:@"channelId"]){
                [self setValue:[dictionary objectForKey:@"channelId"] forKey:@"channelId"];
                continue;
            }
            else if ([key isEqualToString:@"playUrl"]){
                [self setValue:[dictionary objectForKey:@"playUrl"] forKey:@"playUrl"];
                continue;
            }
            else if ([key isEqualToString:@"bigPicUrl"]){
                [self setValue:[dictionary objectForKey:@"bigPicUrl"] forKey:@"bigPicUrl"];
                continue;
            }
            else if ([key isEqualToString:@"downEnable"]){
                [self setValue:[dictionary objectForKey:@"downEnable"] forKey:@"downEnable"];
                continue;
            }
            else if ([key isEqualToString:@"commentCount"]){
                [self setValue:[dictionary objectForKey:@"commentCount"] forKey:@"commentCount"];
                continue;
            }
        }
    }

    return self;

}
//遍历构造器
+(id)videoModuleWithInfo:(NSDictionary *)dictionary{

    QYVideoModule *videoModules = [[[QYVideoModule alloc] initWithVideoInfos:dictionary] autorelease];
    
    return videoModules;

}

-(void)dealloc{

    RELEASE_SAFETY(_bigPicUrl);
    RELEASE_SAFETY(_picUrl);
    RELEASE_SAFETY(_playUrl);
    RELEASE_SAFETY(_itemCode);
    RELEASE_SAFETY(_title);
    RELEASE_SAFETY(_tags);
    RELEASE_SAFETY(_description);
    RELEASE_SAFETY(_totalTime);
    RELEASE_SAFETY(_pubDate);
    [super dealloc];
}

@end
