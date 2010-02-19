//
//  ViewController.m
//  BashComics
//
//  Created by Sasha on 2/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Bash.h"
#import "ASIHTTPRequest.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5


@interface ViewController (UtilityMethods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end

@implementation ViewController

@synthesize item;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


- (NSString *) myDir:(NSString *)string {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	//documentsDir = [documentsDir stringByAppendingPathComponent:@"tumb/"];
	NSString *newDocumentsDir = [documentsDir stringByAppendingPathComponent:@"files/"];
	
	return [newDocumentsDir stringByAppendingPathComponent:string];
}

- (void)createView:(NSString *)patch
{
	UIImage *remoteImage = [[UIImage alloc] initWithContentsOfFile:patch];
	// set up main scroll view
    //imageScrollView = [[UIScrollView alloc] initWithFrame:[[self view] bounds]];
	imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320 , 480)];
    [imageScrollView setBackgroundColor:[UIColor blackColor]];
    [imageScrollView setDelegate:self];
    [imageScrollView setBouncesZoom:YES];
    [[self view] addSubview:imageScrollView];
    
    // add touch-sensitive image view to the scroll view
    TapDetectingImageView *imageView = [[TapDetectingImageView alloc] initWithImage:remoteImage];
    [imageView setDelegate:self];
    [imageView setTag:ZOOM_VIEW_TAG];
    [imageScrollView setContentSize:[imageView frame].size];
    [imageScrollView addSubview:imageView];
    [imageView release];
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [imageScrollView frame].size.width  / [imageView frame].size.width;
	//NSLog(@"%f %f",[imageScrollView frame].size.width, [imageScrollView frame].size.height );
    [imageScrollView setMinimumZoomScale:minimumScale];
    [imageScrollView setZoomScale:minimumScale];
	
}

- (void)requestDone:(ASIHTTPRequest *)request
{

	[appDelegate hideView];
	NSArray *listItems = [item.bashImgFull componentsSeparatedByString:@"/"];
	NSString *MybashTumb = [listItems lastObject];
	
	NSString *dbPath = [self myDir:MybashTumb];
	[self createView:dbPath];

	
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
	[appDelegate hideView];
	//NSError *error = [request error];
	

	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание" message:@"Проблемы с интернет подключением!"  delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles: nil];
	[alert show];	
	[alert release];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	[super viewDidLoad];
	
	//[self.navigationController setToolbarHidden:YES animated:YES];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
											  target:self action:@selector(add:)];
	
	appDelegate = (BashComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate showView];
	NSArray *listItems = [item.bashImgFull componentsSeparatedByString:@"/"];
	NSString *MybashTumb = [listItems lastObject];
	
	NSString *dbPath = [self myDir:MybashTumb];
	self.title = item.bashInfo;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	if(!success) {
		
	
	NSURL *url = [NSURL URLWithString:item.bashImgFull];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
	[request setDownloadDestinationPath:dbPath];
    NSOperationQueue *queue = [BashComicsAppDelegate sharedAppDelegate].downloadQueue;
    [queue addOperation:request];
    [request release];  
	}
	else {
		[self createView:dbPath];
		[appDelegate hideView];
	}

	
	}

-(IBAction)hide:(id)sender {
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(IBAction)open:(id)sender {
	
	[[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)add:(id)sender {
	if([item.bashFav isEqualToString:@"yes"]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Уже добавлено в избранное"
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	else 
		[item setValue:@"yes" forKey:@"bashFav"];
	
	
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

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [imageScrollView viewWithTag:ZOOM_VIEW_TAG];
}

/************************************** NOTE **************************************/
/* The following delegate method works around a known bug in zoomToRect:animated: */
/* In the next release after 3.0 this workaround will no longer be necessary      */
/**********************************************************************************/
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)tapDetectingImageView:(TapDetectingImageView *)view gotSingleTapAtPoint:(CGPoint)tapPoint {

	if (![[UIApplication sharedApplication] isStatusBarHidden])
		[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
	else
		[[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
	
    if (![self.navigationController isNavigationBarHidden])
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	else
		[self.navigationController setNavigationBarHidden:NO animated:YES];
	
}

- (void)tapDetectingImageView:(TapDetectingImageView *)view gotDoubleTapAtPoint:(CGPoint)tapPoint {
    // double tap zooms in
    float newScale = [imageScrollView zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:tapPoint];
    [imageScrollView zoomToRect:zoomRect animated:YES];
}

- (void)tapDetectingImageView:(TapDetectingImageView *)view gotTwoFingerTapAtPoint:(CGPoint)tapPoint {
    // two-finger tap zooms out
    float newScale = [imageScrollView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:tapPoint];
    [imageScrollView zoomToRect:zoomRect animated:YES];
}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [imageScrollView frame].size.height / scale;
    zoomRect.size.width  = [imageScrollView frame].size.width  / scale;
   // NSLog(@"%f", zoomRect.size.height);
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}



- (void)dealloc {

	[imageScrollView release];
	[item release];
    [super dealloc];
}


@end
