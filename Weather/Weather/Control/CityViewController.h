//
//  CityViewController.h
//  Weather
//
//  Created by 15 on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cityViewDelegate <NSObject>

- (void)chooseCity:(NSString *)city;

@end

@interface CityViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSInteger province;

@property(nonatomic,assign) id<cityViewDelegate> delegate;

@end
