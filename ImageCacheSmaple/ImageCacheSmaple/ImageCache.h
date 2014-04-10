//
//  ImageCache.h
//  ImageCacheSmaple
//
//  Created by 范林松 on 14-4-10.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^completionBlock)(UIImage *image);
typedef void(^failedBlock)(NSError *error);

@interface ImageCache : NSObject

+(instancetype)sharedCache;

-(void)imageWithURL:(NSString *)url;

-(void)imageWithURL:(NSString *)url
          completed:(completionBlock)completion
             failed:(failedBlock)failed;



@end
