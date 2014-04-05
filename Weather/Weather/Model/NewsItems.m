//
//  NewsItems.m
//  Weather
//
//  Created by GML on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "NewsItems.h"

@implementation NewsItems


- (void)dealloc
{
    [_newsPublishDate release];
    [_newsURL release];
    [_newTitle release];
    [_newPic release];
    [super dealloc];
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.newTitle = [dictionary objectForKey:@"title"];
        self.newsPublishDate = [dictionary objectForKey:@"ptime"];
        self.newsURL = [dictionary objectForKey:@"docid"];
        self.newPic = [dictionary objectForKey:@"img"];
        
    }
    return self;
}


@end
