//
//  QYMainViewController.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYHomeViewController.h"
#import "QYSearchViewController.h"
#import "QYCategoryViewController.h"
#import "QYProfileViewController.h"


@interface QYMainViewController : UITabBarController{
    
    UIView *_tabbarView;
    UIImageView *_sliderView;
    
}


@property (nonatomic,retain) QYHomeViewController *homeViewController;
@property (nonatomic,retain) QYSearchViewController *searchViewController;
@property (nonatomic,retain) QYCategoryViewController *categoryViewController;
@property (nonatomic,retain) QYProfileViewController *profileViewController;


@end