//
//  StreamManager.h
//  XMPPSample
//
//  Created by 范林松 on 14-4-2.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"

@interface StreamManager : NSObject<XMPPStreamDelegate>


+(instancetype)defaultManager;
-(void)registWithName:(NSString *)name
               password:(NSString *)password;
-(void)loginWithName:(NSString *)name
            password:(NSString *)password;


@end
