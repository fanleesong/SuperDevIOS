//
//  SelectDateView.h
//  CreateSqliteTable
//
//  Created by 刘国靖 on 14-3-10.
//  Copyright (c) 2014年 欧兰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Datedelegate <NSObject>

- (void)passValueOfDate:(NSDate *)date;

@end

@interface SelectDateView : UIView
@property(nonatomic,retain)NSDate *date;
@property(nonatomic,assign)id<Datedelegate>delegate;

@property(nonatomic,retain) UIView *selectView;
//@property(nonatomic,retain)NSMutableDictionary *citydictionary;
//- (void)createView;
@end
