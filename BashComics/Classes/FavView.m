//
//  FavView.m
//  BashComics
//
//  Created by Sasha on 2/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FavView.h"
#import "Bash.h";
#import "BashCell.h"

@implementation FavView
@synthesize filteredListContent, tableView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	appDelegate = (BashComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
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
	//NSLog(@"%f",[appDelegate.favArray count]);
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)dismissAction:(id)sender
{
	
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.favArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*static NSString *CellIdentifier = @"Cell";
	 
	 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 if (cell == nil) {
	 cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	 }
	 Bash *bashObj = [filteredListContent objectAtIndex:indexPath.row];
	 
	 
	 
	 //Set the accessory type.
	 cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	 
	 return cell;*/
	
	Bash *bashObj = [appDelegate.favArray objectAtIndex:indexPath.row];
    static NSString *identifier = @"FlickrItemCell";
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
	
    // Navigation logic may go here -- for example, create and push another view controller.
	//Bash *bashObj = [appDelegate.bashArray objectAtIndex:indexPath.row];
	
	
	//viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	//viewController.item = bashObj;
	//[self.navigationController pushViewController:viewController animated:YES];
	//[viewController release];
	
	/*if(viewController == nil) 
	 viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	 
	 Bash *bashObj = [appDelegate.bashArray objectAtIndex:indexPath.row];
	 
	 //Get the detail view data if it does not exists.
	 //We only load the data we initially want and keep on loading as we need.
	 [bashObj viewControllerData];
	 
	 viewController.item = bashObj;
	 
	 [self.navigationController pushViewController:viewController animated:YES];*/
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


- (void)dealloc {
	[tableView release];
	[filteredListContent release];
    [super dealloc];
}


@end
