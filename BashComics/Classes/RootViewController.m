//
//  RootViewController.m
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "Parser.h"
#import "Bash.h";
#import "BashCell.h"
#import "ViewController.h"

@interface RootViewController (Private)
- (void)loadContentForVisibleCells;
@end

@implementation RootViewController

@synthesize favView;
@synthesize toolbar;




- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"По мотивам";

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	appDelegate = (BashComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
											 initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
											 target:self action:@selector(refresh:)];
	//self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] 
	//										  initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks 
	//										  target:self action:@selector(openFav:)];
	
	
	
}

- (void) refresh:(id)sender {
	[appDelegate showView];
	NSLog(@"refresh");
	pars = [[Parser alloc] init];
	pars.delegate = self;
	[pars myfu];
}

- (void) openFav:(id)sender {
    if (self.favView == nil)
        self.favView = [[[FavView alloc] initWithNibName:
							  NSStringFromClass([favView class]) bundle:nil] autorelease];
	
	[self presentModalViewController:self.favView animated:YES];
}

-(void)update:(Parser *)feed myError:(NSString *)errorMsg {
	
	[appDelegate hideView];
	NSLog(@"%@", errorMsg);
	[self.tableView reloadData];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:"Внимание" message:@"Проблемы с интернет подключением!"
												   delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles: nil];
	[alert show];
	[alert release];
	
}

-(void)update:(Parser *)feed successfully:(NSString *)successMsg {
	
	
	[appDelegate hideView];
	NSLog(@"%@", successMsg);
	[self.tableView reloadData];
	[self loadContentForVisibleCells]; 
	
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.tableView.rowHeight = 41.0;
	[self loadContentForVisibleCells]; 
	

	toolbar = [[UIToolbar alloc] init];
	toolbar.barStyle = UIBarStyleBlackTranslucent;

	[toolbar sizeToFit];

	CGFloat toolbarHeight = [toolbar frame].size.height;

	CGRect rootViewBounds = self.parentViewController.view.bounds;

	CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);

	CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
	
	CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
	
	[toolbar setFrame:rectArea];
	
	UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] 
								   initWithTitle:@"Info" style:UIBarButtonItemStyleBordered target:self action:@selector(openFav:)];
	
	[toolbar setItems:[NSArray arrayWithObjects:infoButton,nil]];
	
	//Add the toolbar as a subview to the navigation controller.
	[self.navigationController.view addSubview:toolbar];
	
	[self.tableView reloadData];
}

- (void)loadContentForVisibleCells
{
    NSArray *cells = [self.tableView visibleCells];
    [cells retain];
    for (int i = 0; i < [cells count]; i++) 
    { 
        // Go through each cell in the array and call its loadContent method if it responds to it.
        BashCell *bashCell = (BashCell *)[[cells objectAtIndex: i] retain];
        [bashCell loadImage];
        [bashCell release];
        bashCell = nil;
    }
    [cells release];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; 
{
    // Method is called when the decelerating comes to a stop.
    // Pass visible cells to the cell loading function. If possible change 
    // scrollView to a pointer to your table cell to avoid compiler warnings
    [self loadContentForVisibleCells]; 
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    if (!decelerate) 
    {
        [self loadContentForVisibleCells]; 
    }
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[toolbar removeFromSuperview];
}

/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.bashArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	//Get the object from the array.
	Bash *bashObj = [appDelegate.bashArray objectAtIndex:indexPath.row];
	
	//Set the coffename.
	cell.text = bashObj.bashInfo;
	
	
	
	
	//Set the accessory type.
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;*/
	
	Bash *bashObj = [appDelegate.bashArray objectAtIndex:indexPath.row];
    static NSString *identifier = @"ItemCell";
    BashCell *cell = (BashCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 75.0);
        cell = [[[BashCell alloc] initWithFrame:rect reuseIdentifier:identifier] autorelease];
        cell.delegate = self;
    }
    cell.item = bashObj;
    return cell;
	
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	

	//[toolbar removeFromSuperview];

	Bash *bashObj = [appDelegate.bashArray objectAtIndex:indexPath.row];
	
	
	viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	viewController.item = bashObj;
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
	 
	/*if(viewController == nil) 
		viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	
	Bash *bashObj = [appDelegate.bashArray objectAtIndex:indexPath.row];
	
	//Get the detail view data if it does not exists.
	//We only load the data we initially want and keep on loading as we need.
	[bashObj viewControllerData];
	
	viewController.item = bashObj;
	
	[self.navigationController pushViewController:viewController animated:YES];*/
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	if (self.favView != nil)
		[favView release];
	[pars setDelegate:nil];
	[pars release];
    [super dealloc];
}


@end

