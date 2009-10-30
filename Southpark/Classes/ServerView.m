//
//  ServerView.m
//  Southpark
//
//  Created by Sasha on 10/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ServerView.h"
#import "SouthparkAppDelegate.h"
#import <mach/mach.h>
#import <mach/mach_host.h>
@implementation ServerView

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
	
	SouthparkAppDelegate *appDelegate = (SouthparkAppDelegate *)[[UIApplication sharedApplication] delegate];
	if([appDelegate myIPAddress] == nil)
	{
		info.text = @"Connect to wi-fi network";
	}
	else {
		NSString *serverURL = [NSString stringWithFormat:@"http://%@:8080/", [appDelegate myIPAddress]];
		info.text = serverURL;
	}

	//NSString *serverURL = [NSString stringWithFormat:@"http://%@:8080/", [appDelegate myIPAddress]];
	//info.text = serverURL;
	//self.navigationItem.title = @"Selected Country";
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[info release];
    [super dealloc];
}


@end
