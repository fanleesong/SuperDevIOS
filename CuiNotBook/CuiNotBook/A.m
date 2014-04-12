//
//  A.m
//  CuiNotBook
//
//  Created by GL on 14-4-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "A.h"

@implementation A

- (id)initWithBlock:(StringToFloat)block
{
    self = [super init];
    if (self) {
        //如果是arc模式
        _block1 = block;
        //如果是mrc模式
//        _block1 = Block_copy(block);
    }
    return self;
}

- (void)a:(NSString *)str
{
    NSLog(@"%f",_block1(str));
}


- (void)dealloc
{
    Block_release(_block1);//Block_copy先拷贝，再Block_release被释放，里面被引用的变量也会被释放
    [super dealloc];
}

@end
