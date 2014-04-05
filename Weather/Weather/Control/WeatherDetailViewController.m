//
//  WeatherDetailViewController.m
//  Weather
//
//  Created by 15 on 14-3-10.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "WeatherDetailViewController.h"

@interface WeatherDetailViewController ()
{
    long count;
}

@property(nonatomic,retain) UIImageView *bigblade;
@property(nonatomic,retain) UIImageView *smallblade;


@property(nonatomic,retain) UILabel *citylabel;//城市名字
@property(nonatomic,retain) UILabel *fl1label;//风速级别
@property(nonatomic,retain) UILabel *fx1label;//风向

@property(nonatomic,retain) UILabel *indexlabel;//穿衣指数
@property(nonatomic,retain) UILabel *index_aglabel;//过敏指数
@property(nonatomic,retain) UILabel *index_cllabel;//晨练指数
@property(nonatomic,retain) UILabel *index_colabel;//舒适指数

@property(nonatomic,retain) UILabel *index_lslabel;//晾晒指数
@property(nonatomic,retain) UILabel *index_trlabel;//旅游
@property(nonatomic,retain) UILabel *index_uvlabel;//紫外线
@property(nonatomic,retain) UILabel *index_xclabel;//洗车


@end

@implementation WeatherDetailViewController

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
    
    //背景
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.frame];
    background.image = self.backimage;
    [self.view addSubview:background];
    [background release];
    
    //添加标题栏
    UIView *titleview = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
    titleview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:titleview];
    //每日详情
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 70, 30)];
    title.textColor = [UIColor whiteColor];
    title.text = @"每日详情";
    [titleview addSubview:title];
    [title release];
    //日期
    UILabel *titlelabel = [[[UILabel alloc] initWithFrame:CGRectMake(175, 0, 100, 30)] autorelease];
    titlelabel.textColor = [UIColor whiteColor];
    NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
    [format setDateFormat:@"YYYY-MM-dd"];
    NSString *datestr = [format stringFromDate:[NSDate date]];
    titlelabel.text = datestr;
    [titleview addSubview:titlelabel];
    
    
    
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"tab_left.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    back.frame = CGRectMake(10, 0, 25, 25);
    [titleview addSubview:back];
    
    
    //风车
    UIView *wind = [[[UIView alloc] initWithFrame:CGRectMake(20, 100, 250, 80)] autorelease];
    wind.backgroundColor = [UIColor clearColor];
    [self.view addSubview:wind];
    
    UIImageView *bigpole = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 8, 50)];
    bigpole.image = [UIImage imageNamed:@"bigpole@2x~ipad.png"];
    [wind addSubview:bigpole];
    [bigpole release];
    
    UIImageView *smallpole = [[UIImageView alloc] initWithFrame:CGRectMake(80, 45, 6, 35)];
    smallpole.image = [UIImage imageNamed:@"bigpole@2x.png"];
    [wind addSubview:smallpole];
    [smallpole release];
    
    self.bigblade = [[[UIImageView alloc] initWithFrame:CGRectMake(bigpole.frame.origin.x + 4 - 30, bigpole.frame.origin.y - 30, 60, 60)] autorelease];
    self.bigblade.image = [UIImage imageNamed:@"blade_big@2x.png"];
    [wind addSubview:self.bigblade];
    
    self.smallblade = [[[UIImageView alloc] initWithFrame:CGRectMake(smallpole.frame.origin.x + 3 - 15, bigpole.frame.origin.y, 30, 30)] autorelease];
    self.smallblade.image = [UIImage imageNamed:@"blade_big@2x.png"];
    [wind addSubview:self.smallblade];
    
    //风速
    UILabel *fengsu = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 120, 30)];
    fengsu.font = [UIFont systemFontOfSize:15];
    fengsu.backgroundColor = [UIColor clearColor];
    fengsu.text = @"风速:";
    fengsu.textColor = [UIColor whiteColor];
    [wind addSubview:fengsu];
    [fengsu release];
    
    //风速级别
    self.fl1label = [[[UILabel alloc] initWithFrame:CGRectMake(160, 10, 120, 30)] autorelease];
    self.fl1label.backgroundColor = [UIColor clearColor];
    self.fl1label.textColor = [UIColor whiteColor];
    self.fl1label.font = [UIFont systemFontOfSize:15];
    self.fl1label.text = self.fl1;
    [wind addSubview:self.fl1label];
    
    
    //风向
    self.fx1label = [[[UILabel alloc] initWithFrame:CGRectMake(160, 40, 120, 30)] autorelease];
    self.fx1label.backgroundColor = [UIColor clearColor];
    self.fx1label.textColor = [UIColor whiteColor];
    self.fx1label.font = [UIFont systemFontOfSize:12];
    self.fx1label.text = self.fx1;
    [wind addSubview:self.fx1label];
    
    //城市名字
    self.citylabel = [[[UILabel alloc] initWithFrame:CGRectMake(40, 50, 200, 40)] autorelease];
    self.citylabel.font = [UIFont systemFontOfSize:25];
    self.citylabel.backgroundColor = [UIColor clearColor];
    self.citylabel.textColor = [UIColor whiteColor];
    self.citylabel.text = self.city;
    [self.view addSubview:self.citylabel];
    
    /*
    @property(nonatomic,retain) UILabel *indexlabel;//穿衣指数
    @property(nonatomic,retain) UILabel *index_aglabel;//过敏指数
    @property(nonatomic,retain) UILabel *index_cllabel;//晨练指数
    @property(nonatomic,retain) UILabel *index_colabel;//舒适指数
     
    */
    //穿衣指数
    self.indexlabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, 220, 200, 40)] autorelease];
    self.indexlabel.font = [UIFont systemFontOfSize:15];
    self.indexlabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.indexlabel.textColor = [UIColor whiteColor];
    NSString *indexstr = [NSString stringWithFormat:@"            穿衣指数：%@",self.index];
    self.indexlabel.text = indexstr;
    UIImageView *indeximage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    indeximage.image = [UIImage imageNamed:@"ct1.png"];
    [self.indexlabel addSubview:indeximage];
    [indeximage release];
    [self.view addSubview:self.indexlabel];
    
    //过敏指数
    self.index_aglabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, 265, 200, 40)] autorelease];
    self.index_aglabel.font = [UIFont systemFontOfSize:15];
    self.index_aglabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.index_aglabel.textColor = [UIColor whiteColor];
    NSString *index_agstr = [NSString stringWithFormat:@"            过敏指数：%@",self.index_ag];
    self.index_aglabel.text = index_agstr;
    UIImageView *index_agimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    index_agimage.image = [UIImage imageNamed:@"ag.png"];
    [self.index_aglabel addSubview:index_agimage];
    [index_agimage release];
    [self.view addSubview:self.index_aglabel];
    
    //晨练指数
    self.index_cllabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, 310, 200, 40)] autorelease];
    self.index_cllabel.font = [UIFont systemFontOfSize:15];
    self.index_cllabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.index_cllabel.textColor = [UIColor whiteColor];
    NSString *index_clstr = [NSString stringWithFormat:@"            晨练指数：%@",self.index_cl];
    self.index_cllabel.text = index_clstr;
    UIImageView *index_climage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    index_climage.image = [UIImage imageNamed:@"cl1.png"];
    [self.index_cllabel addSubview:index_climage];
    [index_climage release];
    [self.view addSubview:self.index_cllabel];
    
    //舒适指数
    self.index_colabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, 355, 200, 40)] autorelease];
    self.index_colabel.font = [UIFont systemFontOfSize:15];
    self.index_colabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.index_colabel.textColor = [UIColor whiteColor];
    NSString *index_costr = [NSString stringWithFormat:@"            舒适指数：%@",self.index_co];
    self.index_colabel.text = index_costr;
    UIImageView *index_coimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    index_coimage.image = [UIImage imageNamed:@"co1.png"];
    [self.index_colabel addSubview:index_coimage];
    [index_coimage release];
    [self.view addSubview:self.index_colabel];
    
    
    //晾晒指数
    self.index_lslabel = [[[UILabel alloc] initWithFrame:CGRectMake(-230, 220, 200, 40)] autorelease];
    self.index_lslabel.font = [UIFont systemFontOfSize:15];
    self.index_lslabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.index_lslabel.textColor = [UIColor whiteColor];
    NSString *index_lsstr = [NSString stringWithFormat:@"            晾晒指数：%@",self.index_ls];
    self.index_lslabel.text = index_lsstr;
    UIImageView *index_lsimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    index_lsimage.image = [UIImage imageNamed:@"ls1.png"];
    [self.index_lslabel addSubview:index_lsimage];
    [index_lsimage release];
    [self.view addSubview:self.index_lslabel];
    
    //旅游指数
    self.index_trlabel = [[[UILabel alloc] initWithFrame:CGRectMake(-230, 265, 200, 40)] autorelease];
    self.index_trlabel.font = [UIFont systemFontOfSize:15];
    self.index_trlabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.index_trlabel.textColor = [UIColor whiteColor];
    NSString *index_trstr = [NSString stringWithFormat:@"            旅游指数：%@",self.index_tr];
    self.index_trlabel.text = index_trstr;
    UIImageView *index_trimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    index_trimage.image = [UIImage imageNamed:@"tr1.png"];
    [self.index_trlabel addSubview:index_trimage];
    [index_trimage release];
    [self.view addSubview:self.index_trlabel];
    
    //紫外线值
    self.index_uvlabel = [[[UILabel alloc] initWithFrame:CGRectMake(-230, 310, 200, 40)] autorelease];
    self.index_uvlabel.font = [UIFont systemFontOfSize:15];
    self.index_uvlabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.index_uvlabel.textColor = [UIColor whiteColor];
    NSString *index_uvstr = [NSString stringWithFormat:@"            紫外线值：%@",self.index_uv];
    self.index_uvlabel.text = index_uvstr;
    UIImageView *index_uvimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    index_uvimage.image = [UIImage imageNamed:@"uv1.png"];
    [self.index_uvlabel addSubview:index_uvimage];
    [index_uvimage release];
    [self.view addSubview:self.index_uvlabel];
    
    //洗车指数
    self.index_xclabel = [[[UILabel alloc] initWithFrame:CGRectMake(-230, 355, 200, 40)] autorelease];
    self.index_xclabel.font = [UIFont systemFontOfSize:15];
    self.index_xclabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.index_xclabel.textColor = [UIColor whiteColor];
    NSString *index_xcstr = [NSString stringWithFormat:@"            洗车指数：%@",self.index_xc];
    self.index_xclabel.text = index_xcstr;
    UIImageView *index_xcimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    index_xcimage.image = [UIImage imageNamed:@"xc1.png"];
    [self.index_xclabel addSubview:index_xcimage];
    [index_xcimage release];
    [self.view addSubview:self.index_xclabel];
    
    //先把显示的label隐藏起来
    self.index_lslabel.hidden = YES;
    self.index_trlabel.hidden = YES;
    self.index_uvlabel.hidden = YES;
    self.index_xclabel.hidden = YES;
    
    
    //添加手势
    //第一组
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1)];
    [self.indexlabel addGestureRecognizer:tap1];
    self.indexlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2)];
    [self.index_aglabel addGestureRecognizer:tap2];
    self.index_aglabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction3)];
    [self.index_cllabel addGestureRecognizer:tap3];
    self.index_cllabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction4)];
    [self.index_colabel addGestureRecognizer:tap4];
    self.index_colabel.userInteractionEnabled = YES;
    //第二组
    /*
     @property(nonatomic,retain) UILabel *index_lslabel;//晾晒指数
     @property(nonatomic,retain) UILabel *index_trlabel;//旅游
     @property(nonatomic,retain) UILabel *index_uvlabel;//紫外线
     @property(nonatomic,retain) UILabel *index_xclabel;//洗车
     */
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction5)];
    [self.index_lslabel addGestureRecognizer:tap5];
    self.index_lslabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction6)];
    [self.index_trlabel addGestureRecognizer:tap6];
    self.index_trlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction7)];
    [self.index_uvlabel addGestureRecognizer:tap7];
    self.index_uvlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction8)];
    [self.index_xclabel addGestureRecognizer:tap8];
    self.index_xclabel.userInteractionEnabled = YES;
    
    
    
    
    
    
    count = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(windmillRoation) userInfo:nil repeats:YES];
    
    
	// Do any additional setup after loading the view.
}


//风车旋转
- (void)windmillRoation
{
    if (count > 1000000) {
        count = 0;
    }
    self.bigblade.transform = CGAffineTransformMakeRotation((M_PI / 90) * count);
    self.smallblade.transform = CGAffineTransformMakeRotation((M_PI / 90) * count);
    count++;
    
}

//单击手势事件
- (void)tapAction1
{
    [self animateOneToFour];
}
- (void)tapAction2
{
    [self animateOneToFour];
}
- (void)tapAction3
{
    [self animateOneToFour];
}
- (void)tapAction4
{
    [self animateOneToFour];
}
- (void)tapAction5
{
    [self animateFiveToEight];
}
- (void)tapAction6
{
    [self animateFiveToEight];
}
- (void)tapAction7
{
    [self animateFiveToEight];
}
- (void)tapAction8
{
    [self animateFiveToEight];
}
//动画效果
- (void)animateOneToFour
{
    [UIView animateWithDuration:0.5 animations:^{
        self.indexlabel.frame = CGRectMake(-230, 220, 200, 40);
    }completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.8 animations:^{
        self.index_aglabel.frame = CGRectMake(-230, 265, 200, 40);
    }completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.2 animations:^{
        self.index_cllabel.frame = CGRectMake(-230, 310, 200, 40);
    }completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.6 animations:^{
        self.index_colabel.frame = CGRectMake(-230, 355, 200, 40);
    }completion:^(BOOL finished) {
        self.indexlabel.hidden = YES;
        self.index_aglabel.hidden = YES;
        self.index_cllabel.hidden = YES;
        self.index_colabel.hidden = YES;
        self.index_lslabel.hidden = NO;
        self.index_trlabel.hidden = NO;
        self.index_uvlabel.hidden = NO;
        self.index_xclabel.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.index_lslabel.frame = CGRectMake(30, 220, 200, 40);
        }];
        [UIView animateWithDuration:0.8 animations:^{
            self.index_trlabel.frame = CGRectMake(30, 265, 200, 40);
        }];
        [UIView animateWithDuration:1.2 animations:^{
            self.index_uvlabel.frame = CGRectMake(30, 310, 200, 40);
        }];
        [UIView animateWithDuration:1.6 animations:^{
            self.index_xclabel.frame = CGRectMake(30, 355, 200, 40);
        }];
    }];
}
//动画效果
- (void)animateFiveToEight
{
    [UIView animateWithDuration:0.5 animations:^{
        self.index_lslabel.frame = CGRectMake(-230, 220, 200, 40);
    }completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.8 animations:^{
        self.index_trlabel.frame = CGRectMake(-230, 265, 200, 40);
    }completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.2 animations:^{
        self.index_uvlabel.frame = CGRectMake(-230, 310, 200, 40);
    }completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.6 animations:^{
        self.index_xclabel.frame = CGRectMake(-230, 355, 200, 40);
    }completion:^(BOOL finished) {
        self.indexlabel.hidden = NO;
        self.index_aglabel.hidden = NO;
        self.index_cllabel.hidden = NO;
        self.index_colabel.hidden = NO;
        self.index_lslabel.hidden = YES;
        self.index_trlabel.hidden = YES;
        self.index_uvlabel.hidden = YES;
        self.index_xclabel.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.indexlabel.frame = CGRectMake(30, 220, 200, 40);
        }];
        [UIView animateWithDuration:0.8 animations:^{
            self.index_aglabel.frame = CGRectMake(30, 265, 200, 40);
        }];
        [UIView animateWithDuration:1.2 animations:^{
            self.index_cllabel.frame = CGRectMake(30, 310, 200, 40);
        }];
        [UIView animateWithDuration:1.6 animations:^{
            self.index_colabel.frame = CGRectMake(30, 355, 200, 40);
        }];
    }];
}


//标题返回按钮
- (void)backAction
{
    self.indexlabel.hidden = YES;
    self.index_aglabel.hidden = YES;
    self.index_cllabel.hidden = YES;
    self.index_colabel.hidden = YES;
    self.index_lslabel.hidden = YES;
    self.index_trlabel.hidden = YES;
    self.index_uvlabel.hidden = YES;
    self.index_xclabel.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [_bigblade release];
    [_smallblade release];
    [_city release];//城市名字
    [_fl1 release];//风速级别
    [_fx1 release];//风向
    [_index release];//穿衣指数
    [_index_ag release];//过敏指数
    [_index_cl release];//晨练指数
    [_index_co release];//舒适指数
    [_index_ls release];//晾晒指数
    [_index_tr release];//旅游
    [_index_uv release];//紫外线
    [_index_xc release];//洗车
    [_citylabel release];//城市名字
    [_fl1label release];//风速级别
    [_fx1label release];//风向
    [_indexlabel release];//穿衣指数
    [_index_aglabel release];//过敏指数
    [_index_cllabel release];//晨练指数
    [_index_colabel release];//舒适指数
    [_index_lslabel release];//晾晒指数
    [_index_trlabel release];//旅游
    [_index_uvlabel release];//紫外线
    [_index_xclabel release];//洗车
    [super dealloc];
}




@end
