//
//  FaviView.m
//  BashComics
//
//  Created by Sasha on 2/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FaviView.h"
#import "Bash.h";
#import "BashCell.h"
#import "ViewController.h"

@implementation FaviView

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Любимые";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	appDelegate = (BashComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate.favArray removeAllObjects]; // First clear the filtered array.
	NSString *mytext = @"yes";
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (Bash *product in appDelegate.bashArray)
	{
		
		NSComparisonResult result = [product.bashFav compare:mytext options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [mytext length])];
		if (result == NSOrderedSame)
		{
			[appDelegate.favArray addObject:product];
			//NSLog(@"%@",product);
		}
		
	}
	
	[self.tableView reloadData];
	self.tableView.rowHeight = 41.0;
	[self loadContentForVisibleCells];
	[self leaveEditMode];
	
}

-(void)enterEditMode 
{ 
	// Add the done button 
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithTitle:@"Done" 
											   style:UIBarButtonItemStylePlain 
											   target:self 
											   action:@selector(leaveEditMode)] autorelease]; 
	[self.tableView setEditing:YES animated:YES]; 
	[self.tableView beginUpdates]; 
} 

-(void)leaveEditMode 
{ 
	// Add the edit button 
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithTitle:@"Edit" 
											   style:UIBarButtonItemStylePlain 
											   target:self 
											   action:@selector(enterEditMode)] autorelease]; 
	[self.tableView endUpdates]; 
	[self.tableView setEditing:NO animated:YES]; 
} 

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
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


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.favArray count];;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   /* static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	
    return cell;*/
	Bash *bashObj = [appDelegate.favArray objectAtIndex:indexPath.row];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	Bash *bashObj = [appDelegate.favArray objectAtIndex:indexPath.row];
	//NSLog(@"open %@", bashObj.bashInfo);
	
	viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	viewController.item = bashObj;
	[self.navigationController pushViewController:viewController animated:YES];
	//[self presentModalViewController:viewController animated:YES];
	[viewController release];
	
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



// Override to support editing the table view.
/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		Bash *bashObj = [appDelegate.favArray objectAtIndex:indexPath.row];
		//NSLog(@"%@", bashObj.bashInfo);
		[bashObj setValue:@"no" forKey:@"bashFav"];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		

		Bash *bashObj = [appDelegate.favArray objectAtIndex:indexPath.row];
		//NSLog(@"%@", bashObj.bashInfo);
		[bashObj setValue:@"no" forKey:@"bashFav"];
		
		//[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];

		[appDelegate.favArray removeObject:bashObj];
		[self.tableView reloadData];
	}
}

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
    [super dealloc];
}


@end

