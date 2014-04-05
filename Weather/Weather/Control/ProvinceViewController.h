//
//  ProvinceViewController.h
//  Weather
//
//  Created by 15 on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityViewController.h"

@protocol provinceViewDelegate <NSObject>

- (void)cityNumber:(NSString *)number;

@end

@interface ProvinceViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,cityViewDelegate,UISearchDisplayDelegate>

@property(nonatomic,assign) id<provinceViewDelegate> delegate;

@end
