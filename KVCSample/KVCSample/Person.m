//
//  Person.m
//  KVCSample
//
//  Created by 范林松 on 14-4-14.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import "Person.h"

@implementation Person

//检测键值是否出现错误
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    NSLog(@"%@",key);
    
}
-(id)valueForUndefinedKey:(NSString *)key{

    return nil;
}

@end
