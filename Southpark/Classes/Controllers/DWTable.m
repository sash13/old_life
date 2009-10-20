//
//  DWTable.m
//  Southpark
//
//  Created by Sasha on 10/6/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DWTable.h"
#import "Coffee.h";
#import "DWCell.h"


@implementation DWTable



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.coffeeArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    static NSString *ClassCellIdentifier = @"ClassCellIdentifier";
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   // if (cell == nil) {
   //     cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
   // }
	
	//Get the object from the array.
	/*Coffee *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
	
	//Set the coffename.
	//cell.text = coffeeObj.coffeeName;
	
	//Set the accessory type.
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	DWCell *cell = (DWCell *)[tableView dequeueReusableCellWithIdentifier:ClassCellIdentifier];
	if(cell == nil) {
		cell = (DWCell *)[[[NSBundle mainBundle] loadNibNamed:nil owner:self options:nil] lastObject];
	}
	
	// Set up the cell

	cell.label.text = coffeeObj.coffeeName;
	//cell.label.text = coffeeObj.Nname;
	cell.link.text = coffeeObj.Link;
	//cell.sizes.text = [NSString stringWithFormat:@"%@", coffeeObj.sizes];
	cell.sizes.text =  [coffeeObj.Sizes stringValue];
	
	//cell.sizes.text = coffeeObj.Sizes;
	 */
	Coffee *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
    static NSString *identifier = @"DWCell";
    DWCell *cell = (DWCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 75.0);
        cell = [[[DWCell alloc] initWithFrame:rect reuseIdentifier:identifier] autorelease];
        //cell.delegate = self;
    }
    cell.item = coffeeObj;
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Set up the cell
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegate = (SouthparkAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//self.title = @"Coffee List";
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		
		//Get the object to delete from the array.
		Coffee *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
		[appDelegate removeCoffee:coffeeObj];
		
		//Delete the object from the table.
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	 self.tableView.rowHeight = 44.0;
	[self.tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
	[super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
	
	//Do not let the user add if the app is in edit mode.
	if(editing)
		self.navigationItem.leftBarButtonItem.enabled = NO;
	else
		self.navigationItem.leftBarButtonItem.enabled = YES;
}	


- (void)dealloc {
    [super dealloc];
}


@end

