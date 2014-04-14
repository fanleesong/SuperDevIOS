//
//  ViewController.m
//  KVOSample
//
//  Created by 范林松 on 14-4-11.
//  Copyright (c) 2014年 leesong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

-(void)_changeTheme:(NSNotification *)sender;

//默认
-(void)_defaultTheme:(NSNumber *)theme;
//红色
-(void)_redTheme:(NSNumber *)theme;
//蓝色
-(void)_blueTheme:(NSNumber *)theme;


@end

@implementation ViewController

-(id)init{

    if (self = [super init]) {
        ;
    }
    return self;
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self = [super init]) {
        ;
    }
    return self;

}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_changeTheme:) name:@"ThemeChangeNotifaction" object:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didClickChangeTheme:(id)sender{

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更改主题" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"默认",@"红色",@"蓝色",nil];
    
    [actionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0://默认
            [ThemeManager defaultManager].themeType = ThemeDefault;
            break;
        case 1:
            [ThemeManager defaultManager].themeType = ThemeRed;
            break;
        case 2:
            [ThemeManager defaultManager].themeType = ThemeBlue;
            break;
    }

}

-(void)_changeTheme:(NSNotification *)sender{

    NSLog(@"%@",sender.object);
    NSLog(@"%@",sender.name);
    NSLog(@"%@",sender.userInfo);

    [self _defaultTheme:sender.object];
    [self _redTheme:sender.object];
    [self _blueTheme:sender.object];


}

-(void)_defaultTheme:(NSNumber *)theme{

    if (![theme isEqualToNumber:@0]) {
        return;
    }
    self.title = @"默认";
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)_redTheme:(NSNumber *)theme{

    if (![theme isEqualToNumber:@1]) {
        return;
    }
    self.title = @"红色";
    self.view.backgroundColor = [UIColor redColor];

}
-(void)_blueTheme:(NSNumber *)theme{

    if (![theme isEqualToNumber:@2]) {
        return;
    }
    self.title = @"蓝色";
    self.view.backgroundColor = [UIColor blueColor];
}

@end







