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

/**
 * Dieser Klasse entspricht dem Controller fuer die
 * Suchliste und das anzeigen der Superbuecher
 */
@implementation BookSearchListVC

@synthesize bookArray;

/**
 * UIViewController
 */
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
        lookForMore = NO;
    }
    return self;
}
/**
 * UIViewController Methode
 * setzt hier zusaetzlich den Title
 * und die BookrConnection delegate neu
 */
-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setTitle:@"bookr"];
    [self setTitle:@"bookr"];
    
    [conn setDelegate:self];
    
    bookArray = [NSMutableArray array];
    
    [_searchBarView becomeFirstResponder];
    [self.tableView reloadData];
}
/**
 * UIViewController Methode
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/**
 * UITableView-Methode
 * Gibt die Anzahl der Sektion wieder
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
/**
 * UITableView-Methode
 * Gibt die Anzahl an Zeilen in einer Sektion wieder
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSInteger count = [bookArray count];
    // fuer die Zeile "more" - falls nach mehr gesucht werden soll
    count += lookForMore ? 1 : 0;
    return  count;
}
/**
 * UITableView-Methode
 * Gibt die Anzahl an Zeilen in einer Sektion wieder
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if ([indexPath row] == [bookArray count]) {
        [[cell textLabel] setText:@"more ..."];
        [[cell detailTextLabel] setText:@""];
    } else {
    // Configure the cell...
    SuperBook *book = [bookArray objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[book title]];
    
    NSMutableString * authors = [NSMutableString string];
    for (Author *author in [book authors]) {
        [authors appendFormat:@"%@, ",author.name];
    }
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ (%@)",authors,[book year]]];
    }
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
/**
 * UITableView-Methode
 * Wenn eine Zeile in der Listenelement angeklickt wird, 
 * wird diese Methode mit der Zeile und deren IndexPath
 * aufgerufen
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [bookArray count]) {
        NSString *searchstring = [[_searchBarView text] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        [conn makeSuperBookRequest:searchstring more:YES];
        [_searchBarView resignFirstResponder];
        lookForMore = NO;
    } else {
        // Navigation logic may go here, for example:
        // Create the next view controller.
        BookDetailListVC *detailViewController = [[BookDetailListVC alloc] initWithNibName:@"BookDetailListVC" bundle:nil];
        [detailViewController setSuperBook:[bookArray objectAtIndex:indexPath.row]];
        
        // Pass the selected object to the new view controller.
        
        // Push the view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}
 

#pragma mark - SearchBarDelegates
/**
 * Delegate des Searchbarviews
 * wird aufgerufen wenn der Suchen/Search-Button 
 * betaetigt wurde
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchstring = [[searchBar text] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [conn makeSuperBookRequest:searchstring more:NO];
    lookForMore = YES;
    [searchBar resignFirstResponder];
}

#pragma mark - BookrConnection Delegate
/**
 * Delegate der BookrConnection
 * Wenn die Suche ein Ergebnis zurückgibt wird
 * diese Funktion aufgerufen
 */
-(void)objectDidLoad:(NSArray *)array
{
    
    //NSLog(@"%@",[bookArray count] != 0 ? [[bookArray objectAtIndex:0] class] : NULL);
    if (([array count] != 0 ? [[array objectAtIndex:0] class] : NULL) == [SuperBook class]) {
        bookArray = [NSMutableArray arrayWithArray:array];
    }
    
    [self.tableView reloadData];
}

@end
