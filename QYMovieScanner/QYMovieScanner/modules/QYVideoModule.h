//
//  QYVideoModule.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-11.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//
/*
 {
 results: [
 {
 itemCode: "aAyQskHtQxI",
 title: "饶舌神童MattyB新单My First Girlfriend高清mv",
 tags: "饶舌,神童",
 description: "饶舌神童MattyB新单My First Girlfriend高清mv",
 picUrl: "http://i1.tdimg.com/173/164/478/p.jpg",
 totalTime: 208400,
 pubDate: "2013-07-23",
 ownerId: 120815386,
 ownerName: "cuuuuute",
 ownerNickname: "卖萌得天下",
 ownerPic: "http://u3.tdimg.com/6/202/247/14239103207869706505964063207834977886.jpg",
 ownerURL: "http://www.tudou.com/home/cuuuuute",
 channelId: 29,
 outerPlayerUrl: "http://www.tudou.com/v/aAyQskHtQxI/v.swf",
 playUrl: "http://www.tudou.com/programs/view/aAyQskHtQxI/",
 mediaType: "视频",
 secret: false,
 hdType: "2",
 playTimes: 0,
 commentCount: 0,
 bigPicUrl: "http://i1.tdimg.com/173/164/478/w.jpg",
 alias: "",
 downEnable: true,
 location: "",
 favorCount: 84,
 outerGPlayerUrl: "http://www.tudou.com/programs/view/html5embed.action?code=aAyQskHtQxI"
 }
 ],
 page: {
 pageNo: 1,
 pageSize: 1,
 totalCount: 67633,
 pageCount: 67633
 }
 }
 
 字段	       类型及范围	说明
 itemCode	   string	视频编码。11位字符型编码,视频唯一标识
 title	       string	视频名字
 tags	       string	视频标签
 description   string	视频描述
 picUrl	       string	视频截图
 totalTime	   int	    视频时长
 pubDate	   string	视频发布时间
 ownerId	   int	    播客id
 ownerName	   string	播客名
 ownerNickname	string	播客昵称
 ownerPic	   string	播客头像地址
 ownerURL	   string	播客地址
 channelId	   int	    所属频道ID
 outerPlayerUrl	string	站外播放器Url
 playUrl	   string	播放页Url
 mediaType	   string	媒体类型
 secret	       bool	    私密
 hdType	       string	视频清晰度。
                 2：256P，流畅
                 3：360P，高清
                 4：480P，超清
                 5：720P，超清
                 99：原画
 playTimes	    int	播放次数
 commentCount	int	评论次数
 bigPicUrl	    string	视频大图
 alias	        string	别名
 downEnable	    bool	是否可以下载
 location	    string	视频位置
 favorCount	    int	收藏次数
 outerGPlayerUrl	string	站外通用播放器Url
                           支持IOS、安卓等移动设备的HTML5播放
 
 
 **************************必备参数***********************************
 
 字段	        必选	    类型及范围	说明
 app_key	    true	string	    应用APP_KEY
 format	        false	string	    返回值格式，json(默认)：json格式、xml：xml格式
 kw	            true    string	    搜索关键字。例如：爱土豆
 pageNo	        false	int	        页码。默认：1
 pageSize	    false	int	        页大小，最大100。默认：20
 orderBy	    false	string	    默认：按相关度倒排序
 viewed_all：                       按pv量倒排序
 createTime：                       按发布时间倒排序
 
 ********************************************************************
 http://api.tudou.com/v6/video/search?app_key=YOUR_APP_KEY&format=json&kw=关键字&pageNo=1&pageSize=20&orderBy=createTime
 */

#import <Foundation/Foundation.h>

@interface QYVideoModule : NSObject


@property (nonatomic,retain) NSString *title;//视频标题
@property (nonatomic,retain) NSString *description;//视频秒速
@property (nonatomic,retain) NSString *picUrl;//视频截图地址
@property (nonatomic,retain) NSString *totalTime;//总时长
@property (nonatomic,retain) NSString *pubDate;//视频发布时间
@property (nonatomic,assign) NSInteger channelId;//所属频道id
@property (nonatomic,retain) NSString *playUrl;//播放页Url
@property (nonatomic,retain) NSString *bigPicUrl;//视频大图地址
@property (nonatomic,assign) NSInteger commentCount;//评论次数
@property (nonatomic,retain) NSString *tags;//视频标签
@property (nonatomic,retain) NSString *itemCode;//视频编码
@property (nonatomic,assign) BOOL downEnable;//是否支持下载

//初始化
- (id)initWithVideoInfos:(NSDictionary *)dictionary;
+ (id)videoModuleWithInfo:(NSDictionary *)dictionary;













@end
