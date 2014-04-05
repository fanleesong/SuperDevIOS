//
//  MoodViewController.h
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectDateView.h"
#import "MoodAddView.h"

#import "WeiboApi.h"

@interface MoodViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,Datedelegate,MoodAddViewDelegate>

{
    WeiboApi                    *wbapi;
}

@property (nonatomic , retain) WeiboApi                    *wbapi;




@end
