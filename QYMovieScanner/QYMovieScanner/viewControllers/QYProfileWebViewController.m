//
//  QYProfileWebViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-13.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYProfileWebViewController.h"

@interface QYProfileWebViewController ()

@end

@implementation QYProfileWebViewController

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
	// Do any additional setup after loading the view.
    self.userLoginView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
    self.userLoginView.delegate = self;
    self.userLoginView.scalesPageToFit = YES;//设置网页页面适配
    
    
    NSURL *url = [NSURL URLWithString:self.userLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.userLoginView loadRequest:request];
    
    
    //    NSURL *url = [NSURL URLWithString:self.detailURL];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    
    [self.view addSubview:self.userLoginView];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    NSLog(@"%@",error);
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
//    NSLog(@"%s",__FUNCTION__);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSLog(@"%s",__FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    RELEASE_SAFETY(_userLoginURL);
    RELEASE_SAFETY(_userLoginView);
    [super dealloc];
}

@end
