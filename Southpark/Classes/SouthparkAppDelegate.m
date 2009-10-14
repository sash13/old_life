//
//  SouthparkAppDelegate.m
//  Southpark
//
//  Created by Sasha on 9/12/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SouthparkAppDelegate.h"
#import "FlickrController.h"
#import "RSS.h"
#import "Coffee.h"


@implementation SouthparkAppDelegate

//@synthesize window;
//@synthesize tabBarController;
@synthesize downloadQueue;
@synthesize moviePlayer;
@synthesize coffeeArray;
@synthesize downloadArray;

+ (SouthparkAppDelegate *)sharedAppDelegate
{
    return (SouthparkAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    downloadQueue = [[NSOperationQueue alloc] init];
	controller = [[FlickrController alloc] init];
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
	//[window makeKeyAndVisible];
   // [controller reloadFeed];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePreloadDidFinish:) 
												 name:MPMoviePlayerContentPreloadDidFinishNotification 
											   object:nil];
	
	// Register to receive a notification when the movie has finished playing. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:nil];
	
	// Register to receive a notification when the movie scaling mode has changed. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(movieScalingModeDidChange:) 
												 name:MPMoviePlayerScalingModeDidChangeNotification 
											   object:nil];
	
	//Copy database to the user's phone if needed.
	[self copyDatabaseIfNeeded];
	
	//Initialize the coffee array.
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.coffeeArray = tempArray;
	[tempArray release];
	
	//Once the db is copied, get the initial data to display on the screen.
	[Coffee getInitialDataToDisplay:[self getDBPath]];
	
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	[coffeeArray makeObjectsPerformSelector:@selector(updatec)];
	[Coffee finalizeStatements];
}


-(void)initAndPlayMovie:(NSURL *)movieURL
{
	// Initialize a movie player object with the specified URL
	MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	if (mp)
	{
		// save the movie player object
		self.moviePlayer = mp;
		[mp release];
		
		// Apply the user specified settings to the movie player object
		[self setMoviePlayerUserSettings];
		
		// Play the movie!
		[self.moviePlayer play];
	}
}
-(void)setMoviePlayerUserSettings
{
	// Копирует базу данных из ресурсов приложения в папку Documents на iPhone
	self.moviePlayer.scalingMode = MPMovieScalingModeNone;
	/* 
	 Movie control mode can be one of: MPMovieControlModeDefault, MPMovieControlModeVolumeOnly,
	 MPMovieControlModeHidden.
	 */
	// mMoviePlayer.movieControlMode = appDelegate.controlMode;
	self.moviePlayer.movieControlMode = MPMovieControlModeDefault;
	/*
	 The color of the background area behind the movie can be any UIColor value.
	 */
	self.moviePlayer.backgroundColor = [UIColor blackColor];
}

//  Notification called when the movie finished preloading.
- (void) moviePreloadDidFinish:(NSNotification*)notification
{
	/* 
	 < add your code here >
	 
	 MPMoviePlayerController* moviePlayerObj=[notification object];
	 etc.
	 */
}

//  Notification called when the movie finished playing.
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
	[playView removeFromSuperview];
    /*     
	 < add your code here >
	 
	 MPMoviePlayerController* moviePlayerObj=[notification object];
	 etc.
	 */
}

//  Notification called when the movie scaling mode has changed.
- (void) movieScalingModeDidChange:(NSNotification*)notification
{
    /* 
	 < add your code here >
	 
	 MPMoviePlayerController* moviePlayerObj=[notification object];
	 etc.
	 */
}



- (void)showLoadingView
{
    if (loadingView == nil)
    {
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        loadingView.opaque = NO;
        loadingView.backgroundColor = [UIColor darkGrayColor];
        loadingView.alpha = 0.5;
		
        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(142.0, 222.0, 37.0, 37.0)];
        [spinningWheel startAnimating];
        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [loadingView addSubview:spinningWheel];
        [spinningWheel release];
    }
    
    [window addSubview:loadingView];
}

- (void)hideLoadingView
{
    [loadingView removeFromSuperview];
}

- (void)showPlayView
{
    if (playView == nil)
    {
        playView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        playView.opaque = NO;
        playView.backgroundColor = [UIColor blackColor];
        playView.alpha = 1.0;
		NSLog(@"showPlayView");
        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(142.0, 222.0, 37.0, 37.0)];
        [spinningWheel startAnimating];
        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [playView addSubview:spinningWheel];
        [spinningWheel release];
    }
    
    [window addSubview:playView];
}

- (void)hidePlayView
{
    [playView removeFromSuperview];
}


- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SQL.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}	
}

- (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"SQL.sqlite"];
}

- (void) removeCoffee:(Coffee *)coffeeObj {
	
	//Delete it from the database.
	[coffeeObj deleteCoffee];
	
	//Remove it from the array.
	[coffeeArray removeObject:coffeeObj];
}

- (void) addCoffee:(Coffee *)coffeeObj {
	
	//Add it to the database.
	[coffeeObj addCoffee];
	
	//Add it to the coffee array.
	[coffeeArray addObject:coffeeObj];
}

-(void) addDw:(DwObjData *)DwObj
{
	[downloadArray addObject:DwObj];
}

-(void) removeDw:(DwObjData *)DwObj
{
	[downloadArray removeObject:DwObj];
}


- (void)dealloc {
	[controller release];
    [tabBarController release];
	[downloadQueue release];
    [window release];
	[coffeeArray release];
	[downloadArray release];
	// remove all movie notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerContentPreloadDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerScalingModeDidChangeNotification
                                                  object:nil];
	// remove notification for touches to overlay view
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:OverlayViewTouchNotification
                                                  object:nil];
	[moviePlayer release]; 
	
    [super dealloc];
}

@end

