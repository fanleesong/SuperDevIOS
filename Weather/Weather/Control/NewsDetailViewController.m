//
//  NewsDetailViewController.m
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
@interface NewsDetailViewController ()<UIWebViewDelegate,NSURLConnectionDataDelegate,NSXMLParserDelegate,SDWebImageDownloaderDelegate>
@property(nonatomic,retain)UITextView *textView;
@property(nonatomic,retain)UIWebView *webVeiw;
@property(nonatomic,retain)NSMutableData *URLData;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)NSMutableArray *imageArray;
@property(nonatomic,assign) NSInteger picIndex;
//@property(nonatomic,retain)NSString *startElement;
@end

@implementation NewsDetailViewController
- (void)dealloc
{
    [_imageView release];
    [_textView release];
    [_URLData release];
    [_webVeiw release];
    [_urlString release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.picIndex = 0;
	// Do any additional setup after loading the view.
    self.imageArray = [NSMutableArray array];
    self.textView = [[[UITextView alloc] initWithFrame:self.view.bounds] autorelease];
    self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(80, 30, 200, 300)] autorelease];
    [self.textView addSubview:self.imageView];
    [self.view addSubview:self.textView];
    
    NSError *error = Nil;
    
    //    for (int i = 0; i< 20; i++) {
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    string = [string stringByAppendingPathComponent:@"0.jpg"];
    if ([[NSFileManager defaultManager] removeItemAtPath:string error:&error]) {
        NSLog(@"文件移除成功");
    }else{
        NSLog(@"文件移除失败");
    }
    //    }
    
    
    
    self.webVeiw = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 40, 320, self.view.bounds.size.height - 80)] autorelease];
    self.webVeiw.delegate = self;
    self.webVeiw.scalesPageToFit = YES;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.urlString];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    //    [self.webVeiw loadRequest:request];
    [self.view addSubview:self.webVeiw];
}
#pragma mark - UIWebViewDelegateMethods -
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",300];
    [self.webVeiw stringByEvaluatingJavaScriptFromString:jsString];
    [jsString release];
    
}
#pragma mark - SDWebImageDownLoaderDelegateMethods -

#pragma mark - NSURLcConnectionDelegateMethods -
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.URLData = [NSMutableData data];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.URLData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.imageArray = Nil;
    //    NSString *emptyString = [NSString string];//拼接回车键
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.URLData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *diction = [NSDictionary dictionary];
    diction = [dic objectForKey:self.urlString];
    //设置文章图片
    NSArray *array1 = [diction objectForKey:@"img"];
    //    NSLog(@"%d",array1.count);
    //    for (int i = 0;  i< array1.count; i++) {
    //        NSDictionary *d = [array1 objectAtIndex:i];
    //        NSString *picURL = [d objectForKey:@"src"];
    //
    //        [SDWebImageDownloader downloaderWithURL:[NSURL URLWithString:picURL] delegate:self userInfo:picURL];
    //
    //    }
    //取出文章主题内容
    NSString *detailString = [diction objectForKey:@"body"];
    
    for (int i = 0; i < array1.count; i++) {
        NSDictionary *d = [array1 objectAtIndex:i];
        NSString *picURL = [d objectForKey:@"src"];
        //            NSString *str = @"http://img4.cache.netease.com/2008/2014/3/18/20140318164533cf8dd.jpg";
        detailString = [detailString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<!--IMG#%d-->",i] withString:[NSString stringWithFormat:@"<img src=\"%@\"-->",picURL]];
        
        NSLog(@"%@",detailString);
    }
    
    
    //    NSLog(@"%@\n\n\n\n\n\n\n",detailString);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *htmlString = [NSString stringWithFormat:@"<html><head>%@<body></head></html>",detailString];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [self.webVeiw loadHTMLString:htmlString baseURL:baseURL];
    
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(newsDetailBack)];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    
    
}

- (void)newsDetailBack
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
