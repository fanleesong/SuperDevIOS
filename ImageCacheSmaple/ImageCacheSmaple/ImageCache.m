//
//  ImageCache.m
//  ImageCacheSmaple
//
//  Created by 范林松 on 14-4-10.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import "ImageCache.h"
#import <CommonCrypto/CommonDigest.h>


@interface ImageCache ()

-(NSString *)md5URL:(NSString *)url;
-(NSString *)pathForURL:(NSString *)url;

@end


@implementation ImageCache

+(instancetype)sharedCache{
    
    //同步锁，保护线程安全
    @synchronized(self){
        static ImageCache *instance = nil;
        if (instance == nil) {
            instance = [[ImageCache alloc] init];
        }
        return instance;
    }

}
-(void)imageWithURL:(NSString *)url{

    
    

}
-(void)imageWithURL:(NSString *)url completed:(completionBlock)completion failed:(failedBlock)failed{
    
    //使用GCD异步调度
    //DISPATCH_QUEUE_PRIORITY_DEFAULT 都是子线程队列<只是优先级不同>
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = nil;
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self pathForURL:url]]) {
        
            data = [NSData dataWithContentsOfFile:[self pathForURL:url]];
            
        }else{
        
            //url对象
            NSURL *urls = [NSURL URLWithString:url];
            //reque 对象
            NSURLRequest *request = [NSURLRequest requestWithURL:urls];
            //1.同步下载的方式
            data = [NSData dataWithContentsOfURL:urls];
            //2.
//            NSData *connectData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            //存储数据
            [data writeToFile:[self pathForURL:url] atomically:YES];
        
        }
  
        
        //异步调度到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            completion([UIImage imageWithData:data]);
        });
        
    });
    


}
-(NSString *)md5URL:(NSString *)url{

    const char *original_str = [url UTF8String];

    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(original_str, strlen(original_str), result);

    NSMutableString *hash = [NSMutableString string];

    for (int i = 0; i < 16; i++) {

        [hash appendFormat:@"%02X", result[i]];

    }

    return [hash lowercaseString];



    return nil;
}
-(NSString *)pathForURL:(NSString *)url{

    NSString *urlString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [urlString stringByAppendingFormat:@"/%@.png",[self md5URL:url]];
    
}

@end
























