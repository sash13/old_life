//
//  FlickrController.m
//  AsyncTable
//
//  Created by Adrian on 3/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
//#define NEWS_FEED_URL @"http://api.flickr.com/services/feeds/photos_public.gne?format=rss2"
#define NEWS_FEED_URL @"http://openidev.ru/smotri/demo.php"
#import "FlickrController.h"
#import "RSS.h"
//#import "Definitions.h"
#import "FlickrItem.h"
#import "FlickrCell.h"
//#import "FlickrItemController.h"
#import "SouthparkAppDelegate.h"
#import "Reachability.h"
//#import "SeasonItem.h"
#import "FilmView.h"
#import "NSString+trim.h"

@interface FlickrController (Private)
- (void)loadContentForVisibleCells;
@end


@implementation FlickrController

//@synthesize navigationController;
//@synthesize itemk;
@synthesize selecteds;


- (void)viewDidLoad {
//NSString * trimmed = selecteds;
	NSLog(selecteds);
 self.title = selecteds;
	//NSLog(@"%@",trimmed);
	/*rss = [[RSS alloc] init];
	rss.delegate = self;
	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://zefir.kiev.ua/spark/southpgodnew.php?status=%@",selecteds]];
	rss.url = url;
	[url release];*/
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
	[selecteds release];
    [flickrItems release];
	//[itemk setDelegate:nil];
    //[itemk release];
	
    [rss setDelegate:nil];
    [rss release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods


- (void)reloadFeed
{
//[self reloadFeed];
	rss = [[RSS alloc] init];
	rss.delegate = self;
	//NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://zefir.kiev.ua/spark/southpgodnew.php?status=%@",selecteds]];
	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://openidev.ru/southpgodnew.php?status=%@",selecteds]];
	rss.url = url;
	[url release];
	NSLog(@"test");

    // Check if the remote server is available
    Reachability *reachManager = [Reachability sharedReachability];
    SouthparkAppDelegate *appDelegate = [SouthparkAppDelegate sharedAppDelegate];
    [reachManager setHostName:@"openidev.ru"];
    NetworkStatus remoteHostStatus = [reachManager remoteHostStatus];
    if (remoteHostStatus == NotReachable)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Problem" 
                                                        message:@"Check your internet connections" 
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


- (void)feed:(RSS *)feed didFindItems:(NSArray *)items
{
    [flickrItems release];
    flickrItems = [items retain];
    [self.tableView reloadData];
    [self loadContentForVisibleCells]; 
    [[SouthparkAppDelegate sharedAppDelegate] hideLoadingView];
}
/*- (void)setItem:(SeasonItem *)newItem
{
    if (itemk != newItem)
    {
       // [itemk setDelegate:nil];
        [itemk release];
        itemk = nil;
        itemk = [newItem retain];
    }
}
*/
- (void)feed:(RSS *)feed didFailWithError:(NSString *)errorMsg
{
	//[self.tableView reloadData];
    [[SouthparkAppDelegate sharedAppDelegate] hideLoadingView];
}


- (void)flickrCellAnimationFinished:(FlickrCell *)cell
{

   // FlickrItemController *controller = [[FlickrItemController alloc] init];
    //controller.item = item;
    //controller.title = item.title;
    //[self.navigationController pushViewController:controller animated:YES];
    //[controller release];    
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

// These methods are adapted from
// http://idevkit.com/forums/tutorials-code-samples-sdk/2-dynamic-content-loading-uitableview.html

- (void)loadContentForVisibleCells
{
    NSArray *cells = [self.tableView visibleCells];
    [cells retain];
    for (int i = 0; i < [cells count]; i++) 
    { 
        // Go through each cell in the array and call its loadContent method if it responds to it.
        FlickrCell *flickrCell = (FlickrCell *)[[cells objectAtIndex: i] retain];
        [flickrCell loadImage];
        [flickrCell release];
        flickrCell = nil;
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

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	//NSLog(@"%f", [flickrItems count]);
    return [flickrItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    FlickrItem *item = [flickrItems objectAtIndex:indexPath.row];
    static NSString *identifier = @"FlickrItemCell";
    FlickrCell *cell = (FlickrCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 75.0);
        cell = [[[FlickrCell alloc] initWithFrame:rect reuseIdentifier:identifier] autorelease];
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
    FlickrCell *cell = (FlickrCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell toggleImage];
	
	FlickrItem *item = [flickrItems objectAtIndex:indexPath.row];
    FilmView *controllers = [[FilmView alloc] init];
    controllers.item = item;
    controllers.title = item.title;
    [self.navigationController pushViewController:controllers animated:YES];
    [controllers release]; 
	
}

#pragma mark -
#pragma mark UIViewController methods


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
