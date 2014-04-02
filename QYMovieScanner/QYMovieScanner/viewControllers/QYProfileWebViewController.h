//
//  QYProfileWebViewController.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-13.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseViewController.h"

@interface QYProfileWebViewController : QYBaseViewController<UIWebViewDelegate>

@property(nonatomic,retain)UIWebView *userLoginView;
@property(nonatomic,retain)NSString *userLoginURL;

@end
