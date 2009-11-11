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
	//NSURL *url = [[NSURL alloc] initWithString:@"http://zefir.kiev.ua/spark/demo1.php"];
	NSURL *url = [[NSURL alloc] initWithString:@"http://openidev.ru/smotri/demo1.php"];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if (section == 0) return 1;
	//NSLog(@"%f", [flickrItems count]);
    if (section == 1) return [seasonItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *MyIdentifier = @"MyIdentifier";
	NSInteger section = indexPath.section;
	if (section == 0) {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		// Request an AdMob ad for this table view cell
		[cell.contentView addSubview:[AdMobView requestAdWithDelegate:self]];
	}
		return cell;
	}
	
	if (section == 1) {
    SeasonItem *item = [seasonItems objectAtIndex:indexPath.row];
    static NSString *identifier = @"SeasonItemCell";
    SeasonCell *cell = (SeasonCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 43.0);
        cell = [[[SeasonCell alloc] initWithFrame:rect reuseIdentifier:identifier] autorelease];
        cell.delegate = self;
    }
    cell.item = item;
    return cell;
	}
	return nil;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    FlickrCell *flickrCell = (FlickrCell *)cell;
//    [flickrCell loadImage];
//}
#pragma mark -
#pragma mark AdMobDelegate methods

- (NSString *)publisherId {
	return @"a14aaba25b0e13b"; // this should be prefilled; if not, get it from www.admob.com
}

- (UIColor *)adBackgroundColor {
	return [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; // this should be prefilled; if not, provide a UIColor
}


- (UIColor *)primaryTextColor {
	return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)secondaryTextColor {
	return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (BOOL)mayAskForLocation {
	return YES; // this should be prefilled; if not, see AdMobProtocolDelegate.h for instructions
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSInteger section = indexPath.section;
	if (section == 1) {
   // FlickrCell *cell = (FlickrCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	// FlickrItemController *controller = [[FlickrItemController alloc] init];
    //controller.item = item;
    //controller.title = item.title;
    //[self.navigationController pushViewController:controller animated:YES];
    //[controller release];  
	//NSString *selecteds = [seasonItems objectAtIndex:indexPath.row];
	SeasonItem *itemk = [seasonItems objectAtIndex:indexPath.row];
   // FlickrController *controller = [[FlickrController alloc] init];
	//controller.selecteds = selecteds;
   // controller.itemk = itemk;
   // controller.title = itemk.title;
    //[self.navigationController pushViewController:controller animated:YES];
   // [controller release];    
	
	//NSString *selecteds = itemk.title;
	NSString * selectedst = [NSString trim:itemk.title];
	//Initialize the detail view controller and display it.
	FlickrController *dvController = [[FlickrController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
	dvController.selecteds = selectedst;
	[self.navigationController pushViewController:dvController animated:YES];
	[dvController release];
	dvController = nil;
	}
	//controller = nil;
	//NSLog(@"%@", selected);

}

- (void)didReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did receive ad");
}

- (void)didFailToReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did fail to receive ad");
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if((indexPath.section == 0) && (indexPath.row == 0)) {
		return 48.0; // this is the height of the AdMob ad
	}
	
	return 50.0; // this is the generic cell height
}


- (void)viewWillAppear:(BOOL)animated 
{
	//NSInteger section = indexPath.section;
	//if(section == 0) {
	//	self.tableView.rowHeight = 48.0; // this is the height of the AdMob ad
	//}
	//else{
   // self.tableView.rowHeight = 44.0;
	//}
	[self.tableView reloadData];
	
	
    // Unselect the selected row if any
    // http://forums.macrumors.com/showthread.php?t=577677
    NSIndexPath* selection = [self.tableView indexPathForSelectedRow];
    if (selection)
    {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

/*- (BOOL)useTestAd {
	return YES;
}

*/
@end
