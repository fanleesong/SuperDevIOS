//
//  Test.m
//  CuiNotBook
//
//  Created by GL on 14-4-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "Test.h"

@implementation Test


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [_name release];
    [super dealloc];
}


@end
