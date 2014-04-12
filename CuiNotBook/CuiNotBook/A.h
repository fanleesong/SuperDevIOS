//
//  A.h
//  CuiNotBook
//
//  Created by GL on 14-4-12.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef float (^StringToFloat)(NSString *floatstr);
//原类型 float(^)(NSString *floatStr)
//新类型 StringToFloat
//

@interface A : NSObject
{
    StringToFloat _block1;
}

- (id)initWithBlock:(StringToFloat)block;
- (void)a:(NSString *)str;


@end
