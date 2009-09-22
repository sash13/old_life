//
//  SeasonsController.m
//  Southpark
//
//  Created by Sasha on 9/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SeasonsController.h"
#define NEWS_FEED_URL @"http://openidev.ru/smotri/demo.php"
#import "RSS.h"
#import "SeasonItem.h"
#import "SeasonCell.h"
#import "SouthparkAppDelegate.h"
#import "Reachability.h"
#import "FlickrController.h"
@interface SeasonsController (Private)
- (void)loadContentForVisibleCells;
@end


@implementation SeasonsController

//@synthesize navigationController;




- (void)viewDidLoad {
	
	//self.title = @"Flickr RSS Feed";
	rss = [[RSS alloc] init];
	rss.delegate = self;
	NSURL *url = [[NSURL alloc] initWithString:@"http://api.flickr.com/services/feeds/photos_public.gne?format=rss2"];
	rss.url = url;
	[url release];
	//UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
	////target:self 
	//action:@selector(reloadFeed)];
	//self.navigationItem.rightBarButtonItem = reloadButton;
	//[reloadButton release];
	[self reloadFeed];
	[super viewDidLoad];
}

- (void)dealloc 
{
	// [navigationController release];
    [seasonItems release];
    [rss setDelegate:nil];
    [rss release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)reloadFeed
{
	//[self reloadFeed];
	NSLog(@"test");
	
    // Check if the remote server is available
    Reachability *reachManager = [Reachability sharedReachability];
    SouthparkAppDelegate *appDelegate = [SouthparkAppDelegate sharedAppDelegate];
    [reachManager setHostName:@"openidev.ru"];
    NetworkStatus remoteHostStatus = [reachManager remoteHostStatus];
    if (remoteHostStatus == NotReachable)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        NSString *msg = @"Flickr is not reachable! This requires Internet connectivity.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Problem" 
                                                        message:msg 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    else if (remoteHostStatus == ReachableViaWiFiNetwork)
    {
        [appDelegate.downloadQueue setMaxConcurrentOperationCount:4];
    }
    else if (remoteHostStatus == ReachableViaCarrierDataNetwork)
    {
        [appDelegate.downloadQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
    [appDelegate showLoadingView];
	
	//[self.tableView reloadData];
	
	[rss fetch];
}

#pragma mark -
#pragma mark RSSDelegate methods

- (void)feed:(RSS *)feed didFindItems:(NSArray *)items
{
    [seasonItems release];
    seasonItems = [items retain];
    [self.tableView reloadData];
   // [self loadContentForVisibleCells]; 
    [[SouthparkAppDelegate sharedAppDelegate] hideLoadingView];
}

- (void)feed:(RSS *)feed didFailWithError:(NSString *)errorMsg
{
	//[self.tableView reloadData];
    [[SouthparkAppDelegate sharedAppDelegate] hideLoadingView];
}

#pragma mark -
#pragma mark FlickrCellDelegate methods


#pragma mark -
#pragma mark UIScrollViewDelegate methods

// These methods are adapted from
// http://idevkit.com/forums/tutorials-code-samples-sdk/2-dynamic-content-loading-uitableview.html



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; 
{
    // Method is called when the decelerating comes to a stop.
    // Pass visible cells to the cell loading function. If possible change 
    // scrollView to a pointer to your table cell to avoid compiler warnings
   // [self loadContentForVisibleCells]; 
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    if (!decelerate) 
    {
       // [self loadContentForVisibleCells]; 
    }
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	//NSLog(@"%f", [flickrItems count]);
    return [seasonItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    SeasonItem *item = [seasonItems objectAtIndex:indexPath.row];
    static NSString *identifier = @"SeasonItemCell";
    SeasonCell *cell = (SeasonCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 75.0);
        cell = [[[SeasonCell alloc] initWithFrame:rect reuseIdentifier:identifier] autorelease];
        cell.delegate = self;
    }
    cell.item = item;
    return cell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    FlickrCell *flickrCell = (FlickrCell *)cell;
//    [flickrCell loadImage];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
   // FlickrCell *cell = (FlickrCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	// FlickrItemController *controller = [[FlickrItemController alloc] init];
    //controller.item = item;
    //controller.title = item.title;
    //[self.navigationController pushViewController:controller animated:YES];
    //[controller release];  
	NSString *selected = [seasonItems objectAtIndex:indexPath.row];
	FlickrController *dvController = [[FlickrController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
	dvController.selectedSeas = selected;
	NSLog(@"%@", selected);
	[self.navigationController pushViewController:dvController animated:YES];
	[dvController release];
}

#pragma mark -
#pragma mark UIViewController methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return NO;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated 
{
    self.tableView.rowHeight = 76.0;
	
	[self.tableView reloadData];
	
	
    // Unselect the selected row if any
    // http://forums.macrumors.com/showthread.php?t=577677
    NSIndexPath* selection = [self.tableView indexPathForSelectedRow];
    if (selection)
    {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

@end
