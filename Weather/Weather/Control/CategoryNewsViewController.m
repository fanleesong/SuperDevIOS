//
//  CategoryNewsViewController.m
//  Weather
//
//  Created by 刘国靖 on 14-3-17.
//  Copyright (c) 2014年 G. All rights reserved.
//

#import "CategoryNewsViewController.h"
#import "NewsViewController.h"
@interface CategoryNewsViewController ()

@property(nonatomic,retain) NSArray *categoryList;

@property(nonatomic,retain) NSArray *urlArray;
@property(nonatomic,retain) NSArray *numberArray;

@end

@implementation CategoryNewsViewController
- (void)dealloc
{
    [_categoryList release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.categoryList = [NSArray arrayWithObjects:@"娱乐新闻",@"科技新闻",@"体育新闻",@"财经新闻",@"军事新闻",@"历史新闻", nil];
    self.urlArray = [NSArray arrayWithObjects:@"http://c.m.163.com/nc/article/list/T1348648517839/0-20.html",@"http://c.m.163.com/nc/article/list/T1348649580692/0-20.html",@"http://c.m.163.com/nc/article/list/T1348649079062/0-20.html",@"http://c.m.163.com/nc/article/list/T1348648756099/0-20.html",@"http://c.m.163.com/nc/article/list/T1348648141035/0-20.html",@"http://c.m.163.com/nc/article/list/T1368497029546/0-20.html", nil];
    self.numberArray = [NSArray arrayWithObjects:@"T1348648517839",@"T1348649580692",@"T1348649079062",@"T1348648756099",@"T1348648141035",@"T1368497029546", nil];
    
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(newsBack)];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    
    
    
}


- (void)newsBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.categoryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == Nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [self.categoryList objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *urlstr = [self.urlArray objectAtIndex:indexPath.row];
    NSString *num = [self.numberArray objectAtIndex:indexPath.row];
    NSString *title = [self.categoryList objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseCategory:number:newstitle:)]) {
        [self.delegate chooseCategory:urlstr number:num newstitle:title];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
