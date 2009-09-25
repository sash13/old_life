//
//  FilmView.m
//  Southpark
//
//  Created by Sasha on 9/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FilmView.h"
#import "FlickrItem.h"
#import "NSString+trim.h"
#import "ASIHTTPRequest.h"

#import "ASINetworkQueue.h"

@implementation FilmView

@synthesize item;
@synthesize jsonItem;


- (void)dealloc {
	//[goView dealloc];
	[downloadQueue release];
	[textLabel release];
	[item setDelegate:nil];
    [item release];
    [super dealloc];
}

- (id)init
{
    if (self = [super initWithNibName:@"FilmView" bundle:nil]) 
    {
        downloadQueue = [[ASINetworkQueue alloc] init];
    }
    return self;
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
	
	NSURL *jsonURL = [NSURL URLWithString:@"http://openidev.ru/jdi.php"];
	
	NSString *jsonData = [[NSString alloc] initWithContentsOfURL:jsonURL];

	

	
	if (jsonData == nil) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Webservice Down" message:@"The webservice of reclam you are accessing is down. Please try again later."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];	
		[alert release];
	}
	else {
		self.jsonItem = [jsonData JSONValue]; 
		
		// setting up the title
		//self.jsonLabel.text = [self.jsonItem objectForKey:@"title"];
		
		// setting up the image now
		//self.goView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: [self.jsonItem objectForKey:@"img"]]]];
	}
	
	
    [super viewDidLoad];
}

-(IBAction)go:(id)sender
{
	NSLog(@"%@  utu", [self.jsonItem objectForKey:@"title"]);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.jsonItem objectForKey:@"title"]]]; 
}

-(IBAction)play:(id)sender
{
	NSString * trimmed = [NSString trim:item.link];
	NSString * urlMovi = [NSString stringWithFormat:@"http://zefir.kiev.ua/spark/%@.M4V", trimmed];
	//NSString * trimmed = [NSString trim:urlMovi];
	
	NSLog(@"play %@", urlMovi);
	

		NSURL *movieURL = [NSURL URLWithString:urlMovi];
		if (movieURL)
		{
			if ([movieURL scheme])	// sanity check on the URL
			{
				SouthparkAppDelegate *appDelegate = (SouthparkAppDelegate *)[[UIApplication sharedApplication] delegate];
				
				// initialize a new MPMoviePlayerController object with the specified URL, and
				// play the movie
				[appDelegate initAndPlayMovie:movieURL];
				[appDelegate showPlayView];
			}
		}
	
	
}

- (void)viewWillAppear:(BOOL)animated 
{
	progressView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 20, 25, 25)];  
	progressView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;  
	progressView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |  
									 UIViewAutoresizingFlexibleRightMargin |  
									 UIViewAutoresizingFlexibleTopMargin |  
									 UIViewAutoresizingFlexibleBottomMargin);  
	[self.view addSubview:progressView];  
	[progressView startAnimating]; 
	
	if ([self.jsonItem objectForKey:@"img"] == nil) {
		NSLog(@"бля");
	}
	else {
		


	
	NSURL *url = [NSURL URLWithString:[self.jsonItem objectForKey:@"img"]];
		//NSURL *url = [NSURL URLWithString:@"http://img9.imageshack.us/img9/8882/iconnormal.png"];
   // NSLog(@"%@", [self.jsonItem objectForKey:@"img"]);
    // Somehow, updating the progress view cannot be properly done
    // without a queue (thread issues?), so here we use a local
    // queue which updates the UIProgressView instance.
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:url] autorelease];
    [downloadQueue setDelegate:self];
    [downloadQueue setRequestDidFinishSelector:@selector(requestDone:)];
    [downloadQueue setRequestDidFailSelector:@selector(requestWentWrong:)];
    [downloadQueue addOperation:request];
    [downloadQueue go];
	}
}

- (void)requestDone:(ASIHTTPRequest *)request
{
	
	[[UIApplication sharedApplication] endIgnoringInteractionEvents]; 
	[progressView removeFromSuperview];  
	[progressView release]; 
 
	
	NSData *data = [request responseData];

    UIImage *remoteImage = [[UIImage alloc] initWithData:data];
	if (remoteImage) {
		NSLog(@"test");
	}
    goView.image = remoteImage;
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
	[[UIApplication sharedApplication] endIgnoringInteractionEvents]; 
	[progressView removeFromSuperview];  
	[progressView release]; 

	
	NSError *error = [request error];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.goView.image = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
