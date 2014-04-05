//
//  WeatherDetailViewController.h
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailViewController : UIViewController

//背景图片
@property(nonatomic,retain) UIImage *backimage;

@property(nonatomic,retain) NSString *city;//城市名字
@property(nonatomic,retain) NSString *fl1;//风速级别
@property(nonatomic,retain) NSString *fx1;//风向

@property(nonatomic,retain) NSString *index;//穿衣指数
@property(nonatomic,retain) NSString *index_ag;//过敏指数
@property(nonatomic,retain) NSString *index_cl;//晨练指数
@property(nonatomic,retain) NSString *index_co;//舒适指数

@property(nonatomic,retain) NSString *index_ls;//晾晒指数
@property(nonatomic,retain) NSString *index_tr;//旅游
@property(nonatomic,retain) NSString *index_uv;//紫外线
@property(nonatomic,retain) NSString *index_xc;//洗车





@end
