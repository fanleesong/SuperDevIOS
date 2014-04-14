//
//  Person.h
//  KVCSample
//
//  Created by 范林松 on 14-4-14.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *score;

@end
