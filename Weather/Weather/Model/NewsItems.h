//
//  NewsItems.h
//  Weather
//
//  Created by GML on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItems : NSObject

@property (nonatomic,retain) NSString *newTitle;
@property (nonatomic,retain) NSString *newsPublishDate;
@property (nonatomic,retain) NSString *newsURL;
@property (nonatomic,retain) NSString *newPic;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
