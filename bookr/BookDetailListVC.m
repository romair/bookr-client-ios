//
//  BookDetailListVC.m
//  bookr
//
//  Created by Steve Maahs on 16.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import "BookDetailListVC.h"

@implementation BookDetailListVC

@synthesize superBook;
@synthesize versions;

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
        // Custom initialization
        
        _conn = [BookrConnection sharedInstance];
        versions = [NSMutableArray array];
        preView = [[VersionDetailPreView alloc] initWithFrame:(CGRect){CGPointZero,{320,564}}];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        [_conn setDelegate:self];
    for (ISBN * isbn in [superBook isbns]) {
            [_conn makeVersionRequest:[NSString stringWithFormat:@"%@-%@",isbn.isbn10,isbn.isbn13]];
            NSLog(@"%@ %@",isbn.isbn10,isbn.isbn13);
        }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //dispatch_queue_t myqueue = dispatch_queue_create("async", NULL);
    //dispatch_async(myqueue, ^{

    //});
}

-(void)viewWillAppear:(BOOL)animated
{

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
    return 1+[versions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (indexPath.row == 0) {
        UITableViewCell *detailCell = [[UITableViewCell alloc] initWithFrame:(CGRect){{0,0},{320,88}}];
        //[detailCell setBackgroundColor:[UIColor yellowColor]];
        
        [self prepareDetailCell:detailCell];
        
        //[[detailCell textLabel] setText:superBook.title];
        
        return detailCell;
    } else {
        
        
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        Book * bookVersion = (Book *)[versions objectAtIndex:[indexPath row]-1];
        [[cell textLabel] setText:[bookVersion title]];
        NSString *detailString;
        if (bookVersion.publisher.length != 0) {
            detailString = [NSString stringWithFormat:@"%@, isbn13: %@",bookVersion.publisher,[[bookVersion isbn] isbn13]];
        } else {
            detailString = [NSString stringWithFormat:@"isbn13: %@ isbn10: %@",[[bookVersion isbn] isbn13],[[bookVersion isbn] isbn10]];
        }
        [[cell detailTextLabel] setText:detailString];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }else{
    
    VersionDetailVC *detailViewController = [[VersionDetailVC alloc] initWithNibName:@"VersionDetailVC" bundle:nil];

    // Pass the selected object to the new view controller.
    [detailViewController setBook:(Book *)[versions objectAtIndex: indexPath.row-1]];
    
    [preView changeBook:(Book *)[versions objectAtIndex: indexPath.row-1]];
    
    [[[self view] superview] addSubview:preView];
    
    // Push the view controller.
    //[self.navigationController pushViewController:detailViewController animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float rowHeight;
    
    if (indexPath.row == 0) {
        rowHeight = 88;
    } else {
        rowHeight = 44;
    }
    
    return rowHeight;
}

-(void)objectDidLoad:(NSArray *)array
{
    Book *book = [array objectAtIndex:0];
    if ([[book quality] intValue] > 0) {
        [versions addObject:book];
    
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"quality" ascending:NO];
        [versions sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[versions indexOfObject:book]+1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    }
    
}

/** Erstellung des DetailCellViews */

-(void)prepareDetailCell:(UITableViewCell *)cellView
{
    UILabel * title = [[UILabel alloc] init];
    UILabel * subTitle = [[UILabel alloc] init];
    UILabel * authors = [[UILabel alloc] init];
    
    [title setText:[superBook title]];
    [title setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [title setFrame:(CGRect){{15,10},[[title text] sizeWithFont:[title font]]}];
    
    [subTitle setText:[superBook subtitle]];
    [subTitle setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [subTitle setFrame:(CGRect){{15,35},[[subTitle text] sizeWithFont:[subTitle font]]}];
    
    NSMutableString * authorString = [NSMutableString string];
    for (Author *author in superBook.authors) {
        [authorString appendFormat:@"%@, ",author.name];
    }
    
    [authors setText:authorString];
    [authors setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [authors setFrame:(CGRect){{15,55},[[authors text] sizeWithFont:[authors font]]}];
    
    [cellView addSubview:title];
    [cellView addSubview:subTitle];
    [cellView addSubview:authors];
}

@end
