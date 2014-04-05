//
//  CategoryNewsViewController.h
//  Weather
//
//  Created by 刘国靖 on 14-3-17.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol categoryDelegate <NSObject>

- (void)chooseCategory:(NSString *)url number:(NSString *)num newstitle:(NSString *)title;

@end


@interface CategoryNewsViewController : UITableViewController

@property(nonatomic,assign) id<categoryDelegate> delegate;


@end
