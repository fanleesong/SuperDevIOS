//
//  CityViewController.m
//  Weather
//
//  Created by 15 on 14-3-13.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "CityViewController.h"
#import "SqlManager.h"

@interface CityViewController ()

@property(nonatomic,retain) NSArray *array;
@property(nonatomic,retain) UITableView *tableview;

@end

@implementation CityViewController

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
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageview.image = [UIImage imageNamed:@"chosecity2.jpg"];
    [self.view addSubview:imageview];
    [imageview release];
    
    
    self.tableview = [[[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain] autorelease];
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    
    SqlManager *manager = [[SqlManager alloc] init];
    self.array = [manager getProvinceCity:self.province];
    [manager release];
    [self.tableview reloadData];
    
    
    
    
    
    self.navigationItem.title = @"市级列表";
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    NSString *temp = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.text = temp;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseCity:)]) {
        SqlManager *manager = [[SqlManager alloc] init];
        NSString *cityname = [self.array objectAtIndex:indexPath.row];
        NSString *temp = [manager getcityid:cityname];
        [manager release];
        NSLog(@"%@",temp);
        [self.delegate chooseCity:temp];
    }
}


- (void)dealloc
{
    [_array release];
    [_tableview release];
    [super dealloc];
}



@end
