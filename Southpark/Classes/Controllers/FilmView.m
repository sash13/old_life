//
//  FilmView.m
//  Southpark
//
//  Created by Sasha on 9/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FilmView.h"
#import "FlickrItem.h"


@implementation FilmView

@synthesize item;



- (void)dealloc {
	[textLabel release];
	[item setDelegate:nil];
    [item release];
    [super dealloc];
}



- (void)setItem:(FlickrItem *)newItem
{
    if (item != newItem)
    {
        [item setDelegate:nil];
        [item release];
        item = nil;
        item = [newItem retain];
        
        if (item != nil)
        {
            item.delegate = self;
        }
    }
}

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
	playView.image = item.thumbnail;
	textLabel.text = item.title;
	
    [super viewDidLoad];
}


-(IBAction)play:(id)sender
{
	NSLog(@"play");
	
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


@end
