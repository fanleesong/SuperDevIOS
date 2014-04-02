//
//  QYVodeoDetailViewController.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-12.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseViewController.h"

@interface QYVideoDetailViewController : QYBaseViewController<UIWebViewDelegate>

@property(nonatomic,retain)UIWebView *picView;
@property(nonatomic,retain)NSString *picUrl;

@end
