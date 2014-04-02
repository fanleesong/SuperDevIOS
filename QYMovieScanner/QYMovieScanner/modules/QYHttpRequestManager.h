//
//  QYHttpRequestManager.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-11.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import <Foundation/Foundation.h>
/***********视频*****************
  该类中目前只提供相关的
 1.视频搜索
 2.视频信息
 3.排行榜
 4.视频状态
 5.视频评论
 6.视频上传和评论<暂未开放>
 
 **************用户***************
 若后期优化时，可涉及到是网站登陆以及单个用户信息
 1.用户信息
 2.用户视频
 3.用户豆单
 4.用户视频列表
 5.用户频道搜藏列表
 6.用户频道订阅列表
 7.用户观众列表
 8.用户视频收藏操作
 9.频道订阅操作
 
 ****************工具*************
 1.URl转帖工具
 
 ##############################################
 
  频道字典说明
  索引值     频道名称
  1         娱乐
  3         乐活
  5         搞笑
  9         动画
  10        游戏
  14        音乐
  15        体育
  21        科技
 ————————————————————————————————
  22        电影
 ————————————————————————————————
  24        财富
  25        教育
  26        汽车
  27        女性
  28        纪录片
  29        热点
 ————————————————————————————————
  30        电视剧
 ————————————————————————————————
  31        综艺
  32        风尚
  99        原创
 
  **************************************/
/*****************用户授权********************
 
 https://api.tudou.com/oauth2/authorize?client_id=33b2e6eb944a6449&redirect_uri=http://www.tudou.com
 
 
 参数名称	        必选	    类型	        描述
 client_id	    true	String	申请应用时分配的AppKey
 redirect_uri	true	String	完成授权后浏览器跳转的地址
 scope	        false	String	申请scope权限所需参数，可一次申请多个scope权限，用”,”分隔
 state	        false	String	用于保持请求和回调的状态，可用于防止CSRF攻击，长度不超过128个字符
 display	    false	String	授权页面模板的终端类型：｛web:PC浏览器模板, mobile:手机浏览器模板｝
 ************************************/



//处理网络地址http的get请求
@interface QYHttpRequestManager : NSObject

//使用开源库处理网络请求
+(id)parserDataByRequest:(NSString *)requestLink;

#pragma mark--------读取接口部分-------------
//处理视频搜索链接接口 kTUDO_VIDEO_SEARCH_URL(__kKeyWord__) 
+(id)getVideoSearchList:(NSString *)keyWord;
//获取视频信息接口 kTUDO_VIDEO_INFO_URL(__kItemCodes__)
+(id)getVideoInfoList:(NSString *)itemCodes;
//获取排行榜接口 kTUDO_VIDEO_TOPLIST_URL(__kChannelId__,__PAGENO__,__PAGESIZE__)
+(id)getVideoRankTopList:(NSInteger)channelID pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize;
//获取视频状态接口 kTUDO_VIDEO_STATUS_URL(__kItemCodes__)
+(id)getVideoStatusList:(NSString *)itemCodes;
//获取视频评论接口 kTUDO_VIDEO_COMMENTLIST_URL(__kItemCodes__)
+(id)getVideoCommentList:(NSString *)itemCodes;

#pragma mark-----------用户信息--------------
+(id)getAuthorCheckUserInfo;
+(id)getAuthorVideoUserInfo:(NSString *)email;

/*
#pragma mark------------读取豆单------------------
//获取豆单搜索接口
+(id)findPlayListSearchInterface;
//获取豆单信息接口
+(id)findPlayListInfoInterface;
//获取豆单频道信息接口
+(id)findPlayListVideoInfoInterface;
//获取豆单排行
+(id)findPlayListRankTopInterface;


#pragma mark---------------写入接口--------------
//视频添加接口
+(id)inputVideoCommentAdd;
//视频挖掘
+(id)inputVideoDigBuryInfo;
//视频上传
+(id)inputVideoUploadInfo;

 */
#pragma mark------------------OAuth2认证------------------
//获取请求授权GET
/*
 
 参数名称	        必选	    类型	        描述
 client_id	    true	String	申请应用时分配的AppKey
 redirect_uri	true	String	完成授权后浏览器跳转的地址
 scope	        false	String	申请scope权限所需参数，可一次申请多个scope权限，用”,”分隔
 state	        false	String	用于保持请求和回调的状态，可用于防止CSRF攻击，长度不超过128个字符
 display	    false	String	授权页面模板的终端类型：｛web:PC浏览器模板, mobile:手机浏览器模板
 
 
 参数名称	     类型	      描述
 code	     String	   授权口令，用于调用access_token接口，过期时间10分钟。
 state	     String	   如果传递参数，会回传该参数
 */
#pragma mark--kTUDO_AUTHORIZE_REQUEST
+(id)getOauthRight;
//获取用户授权过的access_token  POST
/*
 
 参数名称      	必选	     类型	    描述
 code	        true	String	通过authorize接口返回的请求口令
 client_id	    true	String	申请应用时分配的AppKey
 client_secret	true	String	申请应用时分配的AppSecret
 
 {
     "access_token" : "授权Token",
     "expires_in" : 3600,
     "uid" : 0
 }
 
 字段	        类型及范围	       说明
 access_token	string	    授权后生成的Token，用于调用授权接口的凭证
 expires_in	    int	        授权有效期（秒）
 uid	        int	        土豆用户ID
 */
#pragma mark --kTUDO_AUTHORIZE_ACCESS_TOKEN(__CODE__)
+(id)getOauthAccessToken:(NSString *)code;
//获取access_token信息  POST
/*
 参数名称	        必选   	类型	       描述
 access_token	true	String	通过access_token接口请求到的access_token内容（授权令牌）
 
 字段	    类型及范围	说明
 uid	    int	        用户ID
 app_key	String	    应用AppKey
 scope	    String	    授予的权限项
 create_at	int	        令牌创建时间（从1970年1月1日0时0分0秒计算的秒数）
 expires_in	int	        过期时间（有效时长秒数）
 */
#pragma mark--kTUDO_AUTHORIZE_ACCESS_RESPONSE(__ACCESS_TOKEN__)
+(id)getOauthGetTokenInfo:(NSString *)access_token;
//销毁授权 POST
/*
 参数名称      	必选     类型	       描述
 access_token	true	String	通过access_token接口请求到的access_token内容（授权令牌）
 
 字段	类型及范围	 说明
 result	boolean	   销毁结果（true:成功）
 
 */
#pragma mark--kTUDO_AUTHORIZE_DESTROY_ACCESS(__ACCESS_TOKEN__)
+(id)getOauthRemoveAccessToken:(NSString *)access_token;





















@end
