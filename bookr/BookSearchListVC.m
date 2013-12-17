//
//  FirstViewCont.m
//  bookr
//
//  Created by Steve Maahs on 11.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import "BookSearchListVC.h"
#import "BookDetailListVC.h"

#import "Author.h"

@implementation BookSearchListVC

@synthesize bookArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        conn = [BookrConnection sharedInstance];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setTitle:@"bookr"];
    [self setTitle:@"bookr"];
    
    [conn setDelegate:self];
    
    bookArray = [NSMutableArray array];
    
    [_searchBarView becomeFirstResponder];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [bookArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    SuperBook *book = [bookArray objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[book title]];
    
    NSMutableString * authors = [NSMutableString string];
    for (Author *author in [book authors]) {
        [authors appendFormat:@"%@, ",author.name];
    }
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ (%@)",authors,[book year]]];
    
    return cell;
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


 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 BookDetailListVC *detailViewController = [[BookDetailListVC alloc] initWithNibName:@"BookDetailListVC" bundle:nil];
     [detailViewController setSuperBook:[bookArray objectAtIndex:indexPath.row]];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 

//SearchBarDelegates

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchstring = [[searchBar text] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [conn makeSuperBookRequest:searchstring];
    [searchBar resignFirstResponder];
}

//Bookr Delegate

-(void)objectDidLoad:(NSArray *)array
{
    bookArray = [NSMutableArray arrayWithArray:array];
    //NSLog(@"%@",bookArray);
    [self.tableView reloadData];
}

@end
